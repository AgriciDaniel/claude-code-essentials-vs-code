"""Offline regression suite. No real installer, editor, auth or profile commands."""
import json
import hashlib
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest

REPO = Path(__file__).resolve().parents[1]
WINDOWS = os.name == "nt"
SHELL = os.environ.get("SETUP_TEST_SHELL") or ((shutil.which("pwsh") or shutil.which("powershell")) if WINDOWS else shutil.which("bash"))
PYTHON = sys.executable

TOOL = r'''
import json, os, pathlib, sys
root = pathlib.Path(os.environ["SETUP_TEST_ROOT"])
args = sys.argv[1:]
with (root / "calls.jsonl").open("a") as f: f.write(json.dumps(args) + "\n")
mode = os.environ.get("SETUP_TEST_MODE", "")
state = root / "extensions.txt"
if "--list-extensions" in args:
    if mode == "list-fail": sys.exit(23)
    print(state.read_text() if state.exists() else "", end="")
elif "--install-extension" in args:
    if mode == "install-fail": sys.exit(24)
    if mode == "second-fail" and "c.d" in args: sys.exit(24)
    if mode != "false-success":
        with state.open("a") as f: f.write(args[args.index("--install-extension")+1] + "\n")
else:
    sys.exit("Unexpected fake Code arguments")
'''

class SetupTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="setup test spaces ")
        self.root = Path(self.tmp.name)
        self.bin = self.root / "bin space"
        self.bin.mkdir()
        self.env = os.environ.copy()
        self.env["SETUP_TEST_ROOT"] = str(self.root)
        self.env["SETUP_TEST_MODE"] = ""
        # Child-only environment; do not modify the parent user's profile.
        for key in ("HOME", "USERPROFILE", "APPDATA", "LOCALAPPDATA",
                    "XDG_CONFIG_HOME", "XDG_DATA_HOME", "CLAUDE_CONFIG_DIR"):
            self.env[key] = str(self.root / key.lower())
            Path(self.env[key]).mkdir()
        (self.root / "fake_tool.py").write_text(TOOL)
        if WINDOWS:
            self.code = self.bin / "fake code.cmd"
            self.code.write_text('@"' + PYTHON + '" "' + str(self.root / "fake_tool.py") + '" %*\n')
            self.runner = self.root / "runner.ps1"
            self.runner.write_text(r'''
param([string]$Entry, [switch]$Apply, [switch]$InstallClaude,
      [string]$ClaudeVersion = 'stable', [string]$Extension = '',
      [string]$CodeCommand, [string]$CodeUserDataDir, [string]$CodeExtensionsDir)
$testOptions = @{ Apply=$Apply; InstallClaude=$InstallClaude; ClaudeVersion=$ClaudeVersion; CodeCommand=$CodeCommand }
if ($Extension) { $testOptions.Extensions = $Extension.Split(',') }
if ($CodeUserDataDir) { $testOptions.CodeUserDataDir = $CodeUserDataDir }
if ($CodeExtensionsDir) { $testOptions.CodeExtensionsDir = $CodeExtensionsDir }
. (Join-Path $Entry 'scripts/setup.ps1')
function Find-Claude {
    if (Test-Path -LiteralPath (Join-Path $env:SETUP_TEST_ROOT 'claude-installed')) {
        return (Join-Path $env:SETUP_TEST_ROOT 'fake claude.ps1')
    }
    return $null
}
function Invoke-WebRequest {
    param($Uri, $OutFile, [switch]$UseBasicParsing, $ErrorAction)
    if ($Uri -ne 'https://claude.ai/install.ps1') { throw 'Unexpected download URL' }
    if ($env:SETUP_TEST_MODE -eq 'download-fail') { throw 'fake network failure' }
    Copy-Item -LiteralPath (Join-Path $env:SETUP_TEST_ROOT 'vendor fixture.ps1') -Destination $OutFile
}
try {
    Invoke-Setup @testOptions
} catch { Write-Output $_; exit 1 }
''')
            (self.root / "fake claude.ps1").write_text(r'''
if ($env:SETUP_TEST_MODE -eq 'version-fail') { $global:LASTEXITCODE=25; return }
if ($env:SETUP_TEST_MODE -eq 'bad-version') { 'not a version'; return }
'2.1.999 (fixture)'
''')
            (self.root / "vendor fixture.ps1").write_text(r'''
param($Version)
if ($env:SETUP_TEST_MODE -eq 'vendor-fail') { exit 26 }
Set-Content -LiteralPath (Join-Path $env:SETUP_TEST_ROOT 'vendor-version') -Value $Version
if ($env:SETUP_TEST_MODE -ne 'vendor-false-success') {
    Set-Content -LiteralPath (Join-Path $env:SETUP_TEST_ROOT 'claude-installed') -Value 'fixture'
}
''')
        else:
            # Only explicitly selected utility binaries are reachable; real curl/code/claude cannot run.
            for name in ("bash", "uname", "tr", "grep", "mktemp", "rm", "rmdir", "dirname"):
                target = shutil.which(name)
                self.assertIsNotNone(target)
                (self.bin / name).symlink_to(target)
            self.env["PATH"] = str(self.bin)
            self.env["TMPDIR"] = str(self.root)
            self.code = self.bin / "fake code"
            self.code.write_text("#!" + PYTHON + "\n" + TOOL)
            self.code.chmod(0o755)
            curl = self.bin / "curl"
            curl.write_text(r'''#!/bin/bash
[[ "$SETUP_TEST_MODE" != download-fail ]] || exit 22
while [[ $# -gt 0 ]]; do
  if [[ "$1" == -o ]]; then
    printf '%s\n' '#!/bin/bash' \
      '[[ "$SETUP_TEST_MODE" != vendor-fail ]] || exit 26' \
      'printf "%s" "$1" > "$SETUP_TEST_ROOT/vendor-version"' \
      '[[ "$SETUP_TEST_MODE" != vendor-false-success ]] || exit 0' \
      'printf "%s\n" "#!/bin/bash" "printf '\''2.1.999 (fixture)\\n'\''" > "$HOME/.local/bin/claude"' \
      '/bin/chmod +x "$HOME/.local/bin/claude"' > "$2"
    exit 0
  fi
  shift
done
exit 29
''')
            curl.chmod(0o755)
            (Path(self.env["HOME"]) / ".local/bin").mkdir(parents=True)

    def tearDown(self):
        self.tmp.cleanup()

    def run_setup(self, apply=False, claude=False, ids=None, mode="", version="stable",
                  missing_code=False, dirs=False, entrypoint=False, extra=None):
        self.env["SETUP_TEST_MODE"] = mode
        code = str(self.root / "absent code") if missing_code else str(self.code)
        if WINDOWS:
            if entrypoint:
                cmd = [SHELL, "-NoProfile", "-NonInteractive", "-File", str(REPO / "scripts/setup.ps1")]
            else:
                cmd = [SHELL, "-NoProfile", "-NonInteractive", "-File", str(self.runner), "-Entry", str(REPO)]
            cmd += ["-CodeCommand", code, "-ClaudeVersion", version]
            if apply: cmd += ["-Apply"]
            if claude: cmd += ["-InstallClaude"]
            if ids: cmd += ["-Extensions" if entrypoint else "-Extension", ",".join(ids)]
            if dirs: cmd += ["-CodeUserDataDir", str(self.root / "code data"), "-CodeExtensionsDir", str(self.root / "code extensions")]
        else:
            cmd = [SHELL, str(REPO / "scripts/setup.sh"), "--code-command", code, "--claude-version", version]
            if apply: cmd += ["--apply"]
            if claude: cmd += ["--install-claude"]
            for item in ids or []: cmd += ["--extension", item]
            if dirs: cmd += ["--code-user-data-dir", str(self.root / "code data"), "--code-extensions-dir", str(self.root / "code extensions")]
        cmd += extra or []
        return subprocess.run(cmd, env=self.env, stdin=subprocess.DEVNULL,
                              stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, timeout=45)

    def calls(self):
        p = self.root / "calls.jsonl"
        return [json.loads(x) for x in p.read_text().splitlines()] if p.exists() else []

    def test_real_entrypoint_preview_is_offline(self):
        p = self.run_setup(claude=True, ids=["anthropic.claude-code"], entrypoint=True)
        self.assertEqual(p.returncode, 0, p.stdout)
        self.assertIn("Preview", p.stdout)
        self.assertEqual(self.calls(), [])

    def test_no_selection_no_changes(self):
        p = self.run_setup(apply=True, entrypoint=True)
        self.assertEqual(p.returncode, 0, p.stdout)
        self.assertEqual(self.calls(), [])

    def test_extension_success_repeat_and_spaces(self):
        for _ in range(2):
            p = self.run_setup(apply=True, ids=["Anthropic.claude-code", "anthropic.claude-code"], dirs=True)
            self.assertEqual(p.returncode, 0, p.stdout)
        installs = [x for x in self.calls() if "--install-extension" in x]
        self.assertEqual(len(installs), 1, self.calls())
        for args in self.calls():
            self.assertIn(str(self.root / "code data"), args)
            self.assertIn(str(self.root / "code extensions"), args)
            self.assertNotIn("--force", args)

    def test_missing_code_fails_before_claude(self):
        p = self.run_setup(apply=True, claude=True, ids=["a.b"], missing_code=True)
        self.assertNotEqual(p.returncode, 0, p.stdout)
        self.assertFalse((self.root / "vendor-version").exists())

    def test_large_inventory_does_not_reinstall_early_match(self):
        inventory = "a.b\n" + "".join("fixture.extension" + str(i) + "\n" for i in range(50000))
        (self.root / "extensions.txt").write_text(inventory)
        p = self.run_setup(apply=True, ids=["a.b"])
        self.assertEqual(p.returncode, 0, p.stdout)
        self.assertFalse(any("--install-extension" in c for c in self.calls()))

    def test_extension_failure_and_false_success(self):
        for mode in ("list-fail", "install-fail", "false-success"):
            p = self.run_setup(apply=True, ids=["a.b", "c.d"], mode=mode)
            self.assertNotEqual(p.returncode, 0, (mode, p.stdout))
            self.assertNotIn("Selected steps finished", p.stdout)
        self.assertFalse(any("c.d" in c for c in self.calls()))

    def test_reject_malformed_inputs_before_commands(self):
        for item in ("--force", "file.vsix/path", "a.b@1.2.3", "a.b;bad"):
            p = self.run_setup(apply=True, ids=[item])
            self.assertNotEqual(p.returncode, 0, p.stdout)
        self.assertNotEqual(self.run_setup(version="bad;version").returncode, 0)
        self.assertEqual(self.calls(), [])

    def test_unknown_and_missing_option_fail(self):
        cases = [["-UnknownSwitch"], ["-Extensions"]] if WINDOWS else [["--unknown"], ["--extension"]]
        for extra in cases:
            p = self.run_setup(entrypoint=True, extra=extra)
            self.assertNotEqual(p.returncode, 0, p.stdout)
        self.assertEqual(self.calls(), [])

    def test_native_fixture_success_repeat(self):
        for _ in range(2):
            p = self.run_setup(apply=True, claude=True, version="2.1.999")
            self.assertEqual(p.returncode, 0, p.stdout)
        self.assertIn("SKIP", p.stdout)
        self.assertEqual((self.root / "vendor-version").read_text().strip(), "2.1.999")
        self.assertEqual(self.calls(), [])

    def test_native_fixture_failures(self):
        for mode in ("download-fail", "vendor-fail", "vendor-false-success"):
            p = self.run_setup(apply=True, claude=True, mode=mode)
            self.assertNotEqual(p.returncode, 0, (mode, p.stdout))
            self.assertNotIn("VERIFIED executable", p.stdout)

    def test_numeric_version_postcondition(self):
        p = self.run_setup(apply=True, claude=True, version="1.2.3")
        self.assertNotEqual(p.returncode, 0, p.stdout)
        self.assertNotIn("VERIFIED executable", p.stdout)

    def test_existing_broken_cli_is_not_reinstalled(self):
        if WINDOWS:
            (self.root / "claude-installed").write_text("existing")
        else:
            broken = self.bin / "claude"
            broken.write_text('#!/bin/bash\nif [[ "$SETUP_TEST_MODE" == version-fail ]]; then exit 25; fi\nprintf "not a version\\n"\n')
            broken.chmod(0o755)
        for mode in ("version-fail", "bad-version"):
            p = self.run_setup(apply=True, claude=True, mode=mode)
            self.assertNotEqual(p.returncode, 0, p.stdout)
            self.assertNotIn("VERIFIED executable", p.stdout)
            self.assertFalse((self.root / "vendor-version").exists())

    def test_partial_failure_retry_preserves_completed_step(self):
        p = self.run_setup(apply=True, ids=["a.b", "c.d"], mode="second-fail")
        self.assertNotEqual(p.returncode, 0, p.stdout)
        self.assertEqual((self.root / "extensions.txt").read_text().strip(), "a.b")
        p = self.run_setup(apply=True, ids=["a.b", "c.d"])
        self.assertEqual(p.returncode, 0, p.stdout)
        self.assertEqual(sum("--install-extension" in c and "a.b" in c for c in self.calls()), 1)

    def test_extracted_source_manifest(self):
        manifest = REPO / "SOURCE-MANIFEST.json"
        if not manifest.exists():
            self.skipTest("Manifest is generated for the source ZIP; extraction check pending")
        data = json.loads(manifest.read_text())
        self.assertEqual(data["baseline"], "8b5575bff5f6cd3f0f964df54010233d9b04c010")
        for name, expected in data["files"].items():
            path = (REPO / name).resolve()
            self.assertTrue(path.is_relative_to(REPO))
            self.assertEqual(hashlib.sha256(path.read_bytes()).hexdigest(), expected, name)

    def test_directory_pair_required(self):
        option = "-CodeUserDataDir" if WINDOWS else "--code-user-data-dir"
        p = self.run_setup(apply=True, ids=["a.b"], extra=[option, str(self.root / "one only")])
        self.assertNotEqual(p.returncode, 0, p.stdout)
        self.assertEqual(self.calls(), [])

    def test_extension_wrapper(self):
        if WINDOWS:
            cmd = [SHELL, "-NoProfile", "-NonInteractive", "-File", str(REPO / "scripts/install-extensions.ps1"),
                   "-Apply", "-Extensions", "a.b", "-CodeCommand", str(self.code)]
        else:
            cmd = [SHELL, str(REPO / "scripts/install-extensions.sh"), "--apply",
                   "--extension", "a.b", "--code-command", str(self.code)]
        p = subprocess.run(cmd, env=self.env, stdin=subprocess.DEVNULL,
                           stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, timeout=45)
        self.assertEqual(p.returncode, 0, p.stdout)
        self.env["SETUP_TEST_MODE"] = "list-fail"
        p = subprocess.run(cmd, env=self.env, stdin=subprocess.DEVNULL,
                           stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, timeout=45)
        self.assertNotEqual(p.returncode, 0, p.stdout)

    def test_wrapper_preview_ignores_previous_exit(self):
        if WINDOWS:
            wrapper = str(REPO / "scripts/install-extensions.ps1").replace("'", "''")
            cmd = [SHELL, "-NoProfile", "-NonInteractive", "-Command",
                   "$global:LASTEXITCODE=77; & '" + wrapper + "'; if (-not $?) { exit 1 }"]
        else:
            cmd = [SHELL, "-c", '(exit 77); bash "$1"', "test", str(REPO / "scripts/install-extensions.sh")]
        p = subprocess.run(cmd, env=self.env, stdin=subprocess.DEVNULL,
                           stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, timeout=45)
        self.assertEqual(p.returncode, 0, p.stdout)
        self.assertEqual(self.calls(), [])

if __name__ == "__main__":
    if not SHELL: sys.exit("Required native shell not found; no tests run")
    print("Native host:", sys.platform, "| shell:", SHELL, "| external installs: MOCKED", flush=True)
    unittest.main(verbosity=2)

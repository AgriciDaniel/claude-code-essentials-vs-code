# Validation and supported test scope

Source provenance: commit `8b5575bff5f6cd3f0f964df54010233d9b04c010`
was verified as the local Git HEAD/commit object and against GitHub's commit API
on 2026-09-08. Its committer date is 2026-04-10T17:12:55Z. This ZIP includes
`SOURCE-MANIFEST.json` with that baseline and SHA256 for every source file;
the archive SHA256 and final acceptance results accompany the delivery.

## Recorded native evidence before the final-hash gate

The RC2 predecessor (SHA256
`C7E2096AC49EFBA30C3A0A1A8DA5A7969DF4471ABCCF1D942DB036211277995B`)
established this matrix. These are observations, not claims that every installer
or activation path was tested. The delivery receipt identifies the final ZIP
hash and its fresh-extraction reruns.

| Native environment | Actual script/regression evidence | Real product integration observed in RC2 |
|---|---|---|
| Windows 11 x64, PowerShell 7.6.3 and 5.1 | 15/15 fixture-backed tests on each shell; 14 direct entrypoint cases passed | Code 1.115.0 installed anthropic.claude-code 2.1.263 into paired private dirs; repeat skipped. 5.1 wrapper enumerated/skipped the same package, not a fresh 5.1 install |
| macOS 26.5.2 ARM64, Bash 3.2.57, Python 3.9.6 | 15/15 plus nine direct entrypoint cases and syntax checks passed | Missing-Code path tested; real Code/vendor install not part of RC2 |
| Debian 13.6 x64, Bash 5.2.37, Python 3.13.5 | 15/15 plus nine direct entrypoint cases passed under read-only-root isolation | Fresh confined native Claude 2.1.236 install and repeat skip; real Code install not part of RC2 |

RC1 exposed a missing `dirname` test fixture; RC2 fixed it. Owner review then
found the PowerShell extension wrapper could inherit a prior command's exit
status during preview. This source resets that status and includes its
regression. The final suite has **17 tests**, including missing/unknown options.

Real Code package presence is not extension activation, editor workflow or
authentication proof. Those operations are outside this package's tests.
Real Windows native-Claude installation has not been proved isolated; its
download/install/discovery paths are fixture-tested. Native installers remain
explicit opt-ins; preview is the default on every platform.

## Offline regression tests

Run `python tests/test_package.py` on Windows or
`python3 tests/test_package.py` on Unix (Python 3.9+).
Select another shell with the child process's `SETUP_TEST_SHELL` environment
variable. For example, Windows validation should cover both PowerShell 7 and
Windows PowerShell 5.1.

Python creates temporary paths with spaces and launches the actual candidate
shell entrypoints. Code, download and vendor install calls use fixtures.
PowerShell fixtures replace Claude discovery before apply, so Windows known-folder
APIs cannot resolve the human CLI. Bash's fixture PATH contains only selected
utilities and fake Code/download tools. No network or real installs are needed.
Child environment changes do not modify the parent environment.

Coverage includes offline preview/no-op, malformed/missing options, prerequisites,
paired storage arguments, duplicate selections, repeat execution, large
inventories, list/install/false-success failures, broken existing CLI, exact
requested versions, partial-failure retry, wrapper exit status, and the source
manifest after extraction. The manifest test is skipped only in an unpackaged
checkout where the manifest has not yet been generated.

## Final-hash independent integration procedure

1. Verify the supplied archive SHA256 and safely extract into a fresh private
   path with spaces. Do not test the moving implementation checkout.
2. Record OS/CPU/shell/Python versions. Run the entire offline suite on each
   native platform; no skips are expected in an extracted source package.
3. Run both actual entrypoints without options and with selected preview
   components, stdin closed. Require exit 0 and no installations. Run invalid
   arguments and an explicit missing Code path; require graceful nonzero exit.
4. For real Code integration, review the official CLI dispatch and supply BOTH
   private user-data and extension directories plus an explicit CodeCommand.
   Use fresh dirs for installation, then repeat against the same dirs. Do not
   sign in, enable Sync, open a GUI, or treat a named profile as a sandbox.
   A job-local official runtime can be used when no system Code CLI exists.
5. For real native Claude, prove vendor write locations independently.
   HOME/USERPROFILE redirection alone is not proof on Windows. Use a genuine
   confined environment or leave that substep explicitly untested. Do not
   authenticate. Where confined, test fresh installation and repeat skip.
6. Verify archive/source integrity again. Record exact commands, exits,
   outputs, runtime provenance and boundaries in the matching-hash delivery
   receipt. Distinguish fixture calls, actual package installation, activation
   and authentication.

Do not alter human homes, global packages, editor settings, services or OS state.
No reboots, upgrades or permission-policy changes. Failures may leave partial
job-owned state; preserve logs and return them for correction before acceptance.

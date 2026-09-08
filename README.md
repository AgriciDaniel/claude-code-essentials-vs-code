# Claude Code and VS Code Essentials

A small, opt-in setup helper for Claude Code and selected VS Code extensions.
The January 2026 tutorial's “26 extensions in one command” is historical: this
refresh installs **nothing by default**. Review your choices before applying them.

## Quick start from reviewed source

Download and extract the source ZIP, or clone this repository. Open a terminal
in the extracted repository. Inspect the scripts; do not pipe a moving GitHub
branch directly into a shell. No administrator shell is required by this wrapper.

On Windows, downloaded files or organizational execution policy can block a
PowerShell script before it starts. Inspect the file and its origin first;
if appropriate, unblock only the reviewed files through Properties or
`Unblock-File`. Follow your organization's policy. The helper never changes
execution policy or silently bypasses it.

Windows PowerShell 5.1+:

```powershell
# Preview only
.\scripts\setup.ps1 -InstallClaude -Extensions anthropic.claude-code
# Execute exactly those choices
.\scripts\setup.ps1 -InstallClaude -Extensions anthropic.claude-code -Apply
```

macOS / Linux / WSL, Bash 3.2+:

```bash
bash scripts/setup.sh --install-claude --extension anthropic.claude-code
bash scripts/setup.sh --install-claude --extension anthropic.claude-code --apply
```

An existing Claude executable is checked and preserved; no migration, version
change or channel change is attempted. A missing CLI uses Anthropic's native
HTTPS installer, with `stable` as this wrapper's default. Applying that choice
executes vendor code as your user and accepts its installation behavior, including
native auto-updates. The downloaded installer is temporary. HTTPS delivery and
a printed Windows hash are not an independent signature audit. Review the
[vendor installer and integrity instructions](https://code.claude.com/docs/en/setup)
if you need stricter provenance.

The official VS Code extension works independently; the CLI is optional for
extension-only use. [Anthropic VS Code guide](https://code.claude.com/docs/en/vs-code).

## Choose only what you use

- CLI only: omit the extension option.
- Extensions only: omit the Claude option, or use `install-extensions.ps1/.sh`.
- Extra extensions: PowerShell `-Extensions anthropic.claude-code,dbaeumer.vscode-eslint`;
  Bash repeat `--extension` for each ID.
- Install channel/version for a **missing** CLI: `-ClaudeVersion latest` /
  `--claude-version latest`, or a numeric `X.Y.Z`. It is not a permanent
  update lock and does not change an existing install.
- Nonstandard Code path: `-CodeCommand 'path with spaces/code.cmd'` /
  `--code-command '/path with spaces/code'`. Quote paths.
- Separate VS Code storage: pass **both** `-CodeUserDataDir` and
  `-CodeExtensionsDir`, or `--code-user-data-dir` and `--code-extensions-dir`.
  The same directories are used for listing, installation and verification.
  Without them, the selected CLI's default profile is targeted.

Extension IDs are validated as `publisher.extension`; URLs, VSIX paths, flags
and version suffixes are rejected. There is no “all” preset. Selected extension
dependencies/packs may add other extensions; review that publisher's listing.
Existing extensions are skipped without `--force`. See the
[26-extension audit](docs/extension-audit.md) and [selection guide](docs/vscode-extensions-guide.md).

## Prerequisites and behavior

[Platform setup](docs/dev-setup-guide.md) covers Windows, macOS and Linux PATH,
WSL, vendor prerequisites and targeted updates. Native Claude does not require
Node.js. The optional npm route currently requires Node.js 22+ and is documented
separately; this wrapper does not install npm, Node, Git, VS Code, WSL or runtimes.

Preview does not execute installers or Code/Claude commands. `-Apply/--apply`
is explicit noninteractive consent to the listed components. No stdin prompt can
swallow a piped script. VS Code or the vendor installer may still require human
action or fail due to policy/network restrictions; the wrapper never approves
additional dialogs. Cancel before apply to make no changes. Ctrl+C during apply
can leave a partial install; inspect it before rerunning.

Selected VS Code prerequisites are checked before installing Claude. Failures
stop with a nonzero exit and visible diagnostics. An extension must appear in
the post-install list; Claude must return a recognizable version. A successful
version check proves executable availability, **not authentication**. Prior
successful steps remain installed after later failures; there is no automatic
rollback or retry. Repeating a successful run skips existing components.
Upgrades use the original package manager, separately.

## First use and customization

Start `claude` in a project and follow its sign-in flow, or sign in through the
extension. A supported paid subscription, Console billing, or supported provider
access is required; these have different billing paths. Never paste keys into
templates. [Authentication](https://code.claude.com/docs/en/authentication).

Read the [Claude guide](docs/claude-code-guide.md) for project settings, reviewed
templates, optional skills/subagents/MCP and permission handling. Nothing copies
to `~/.claude`, changes a shell profile, bypasses permissions, adds MCP servers,
or installs third-party workflow frameworks automatically.

## Tests and review

```powershell
python tests/test_package.py
```

Use `python3` on Unix if that is your Python command (Python 3.9+). Tests launch
real script entrypoints with process-local fakes and disposable storage; they
never install the real products. [Test matrix and integration procedure](docs/validation.md)
distinguish script execution from real installer proof. See [CHANGELOG](CHANGELOG.md)
and [audit findings](docs/refresh-audit.md).

MIT licensed. Built by [Agrici Daniel](https://agricidaniel.com/about).
[YouTube](https://www.youtube.com/@AgriciDaniel) ·
[Community](https://www.skool.com/ai-marketing-hub) ·
[Open-source projects](https://github.com/AgriciDaniel).

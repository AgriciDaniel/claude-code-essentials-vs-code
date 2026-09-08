# Platform prerequisites and targeted maintenance

Checked against primary vendor documentation on 2026-09-08. These are choices,
not a bulk install checklist. The setup wrapper only installs selected Claude
and VS Code extension components.

| Platform | Preparation | Native Claude route |
|---|---|---|
| Windows | PowerShell 5.1+, current supported Windows; install VS Code with its user installer if wanted, then reopen terminal for PATH. Git for Windows is optional in current Claude documentation and supplies Bash. | Official PowerShell installer; no administrator required. WinGet is an alternative, not an additional install. |
| macOS | Supported macOS; Bash, curl. In VS Code run “Shell Command: Install 'code' command in PATH” if needed; reopen terminal. | Native installer; Homebrew cask is an alternative if Homebrew is already your chosen manager. |
| Linux | Supported distribution/architecture, Bash and curl. Install VS Code using the vendor's distribution instructions if needed. | Native installer; signed apt/dnf/apk repositories are alternatives, configured separately. |
| WSL | Run inside the selected Linux distribution. Keep Windows and WSL installations distinct. | Linux installer inside WSL; do not run the Bash wrapper in Git Bash as if it were Linux. |

Claude's current requirements include macOS 13+, Windows 10 1809+/Server 2019+,
Ubuntu 20.04+/Debian 10+/Alpine 3.19+, x64 or ARM64 and 4GB+ RAM.
Alpine/musl additionally needs runtime libraries and ripgrep configuration.
The wrapper delegates architecture/distribution validation to the vendor
installer and does not install OS libraries. It rejects other OS families.
[Claude platform requirements](https://code.claude.com/docs/en/setup).

VS Code has its own, potentially stricter requirements; a supported Claude host
does not prove VS Code compatibility. Follow the current vendor pages:
[Windows](https://code.visualstudio.com/docs/setup/windows),
[macOS](https://code.visualstudio.com/docs/setup/mac),
[Linux](https://code.visualstudio.com/docs/setup/linux).
If `code` is missing, fix PATH or supply an explicitly quoted Code command path.
Do not “fix” an absent command by reinstalling everything.

## Alternative Claude managers

Choose one installation method. Existing installations are preserved by the
wrapper. If using WinGet: `winget install --id Anthropic.ClaudeCode --exact`.
If using Homebrew: `brew install --cask claude-code`. Review each manager's
prompts and scopes. These are manual alternatives, never run by the wrapper.

The current npm package requires **Node.js 22+**, and installs a native binary.
Only if intentionally choosing npm, use
`npm install -g @anthropic-ai/claude-code`. Do not use sudo npm or assume a
global package prefix is writable. Native installation avoids the Node/npm
dependency. Project-specific JavaScript/Python dependencies belong in that
project's lockfile or virtual environment, not this setup package.
[Vendor install methods](https://code.claude.com/docs/en/setup).

## Update the selected product only

- Native install: vendor auto-updates apply; inspect `claude doctor`; use
  `claude update` for a deliberate manual update.
- WinGet install: `winget upgrade --id Anthropic.ClaudeCode --exact`.
- Homebrew install: `brew upgrade claude-code` (or the cask actually installed).
- npm install: `npm install -g @anthropic-ai/claude-code@latest`.
- VS Code extensions: review updates in the editor; this helper does not
  force-update existing extensions.

Do not run all-package upgrades, reboot/enable WSL, change global Git identity,
create SSH keys, install CUDA/ML libraries or change services to follow this
tutorial. Those are independent development tasks.

# Choose VS Code extensions for your project

The original video demonstrates 26 selections. They are not 26 requirements for Claude Code. Choose tools for your actual project; the [original extension audit](extension-audit.md) covers every ID, verified update dates, migrations, and limitations. Vendor guidance checked 2026-09-08.

## Official Claude Code companion

In VS Code's Extensions view, find **Claude Code**, published by **Anthropic**, and review the listing. For an intentional CLI installation:

```text
code --install-extension anthropic.claude-code
```

The extension bundles a private CLI for its panel but does **not** add `claude` to your terminal PATH. For terminal use, follow the standalone installation in the [README](../README.md). Complete interactive sign-in and review permission prompts. Installation does not authenticate your account. See [Anthropic's current VS Code documentation](https://code.claude.com/docs/en/vs-code).

The repository wrappers preview your explicit selection before applying it:

```powershell
# Windows: preview, then apply if this is your chosen extension
.\scripts\install-extensions.ps1 -Extensions anthropic.claude-code
.\scripts\install-extensions.ps1 -Extensions anthropic.claude-code -Apply
```

```bash
# macOS/Linux: preview, then apply if this is your chosen extension
bash scripts/install-extensions.sh --extension anthropic.claude-code
bash scripts/install-extensions.sh --extension anthropic.claude-code --apply
```

These are user installation instructions, not records of installation tests. If `code` is unavailable, use [VS Code CLI setup guidance](https://code.visualstudio.com/docs/configure/command-line).

## Choose additional IDs individually

Review purpose, publisher, dependencies, compatibility, and account/payment requirements before adding an ID. The wrappers accept PowerShell's `-Extensions` array or repeated Bash `--extension` options. There is no install-all recommendation.

| Need | Selection guidance |
|---|---|
| Python, notebooks, Tailwind, Prisma | Choose matching project support. Extensions do not replace runtimes, kernels, or project dependencies. |
| Formatting and linting | Match existing project conventions; preserve user settings and formatting choices. |
| JavaScript/TypeScript | VS Code includes language support. TypeScript Nightly is an advanced opt-in with stability tradeoffs. |
| Containers | Current Microsoft tooling is `ms-azuretools.vscode-containers`; the old Docker ID is a wrapper pack. An engine is separate. |
| Another AI assistant | Copilot and Cline are independent optional products, not Claude Code dependencies. Review current setup, billing, data policies, and permissions separately. |
| Themes, navigation, diagnostics | Choose by preference; check the audit for older packages and overlap with built-in features. |

The [audit](extension-audit.md) links each publisher and explains Docker/Copilot migrations. Do not automatically remove existing extensions because a refreshed selection omits them.

## Native Windows and WSL

Native Windows uses the Windows editor and Windows CLI installation. WSL uses a Windows VS Code frontend connected to a separate Linux distribution. `ms-vscode-remote.remote-wsl` belongs to that Windows-host workflow; it is not required for native Windows Claude Code, native macOS, or native Linux.

Install and authenticate the standalone CLI in the environment where its terminal runs. Windows and Linux homes/configuration are distinct. Check extension location controls in remote workspaces; do not assume a Windows CLI installation configured WSL. Installing the WSL extension does not provision a distribution. See [Microsoft WSL guidance](https://code.visualstudio.com/docs/remote/wsl).

## Dependencies, trust, and verification

Companion extensions can make the final inventory larger than the number selected. Extensions execute with VS Code's permissions; a named editor profile is not a sandbox. Retain publisher prompts and Workspace Trust, and review dependencies. See [VS Code extension security](https://code.visualstudio.com/docs/configure/extensions/extension-runtime-security).

Installation does not authorize executing project code, connecting accounts, configuring MCP, starting servers, or changing agent approvals. Preserve user settings.

After an intentional installation:

```text
code --list-extensions --show-versions
```

If you supplied custom user-data/extension directories, inspect that same target. A successful exit and inventory entry establish installation, not activation, authentication, or workflow compatibility. Check behavior in a trusted sample project. Review updates through VS Code instead of routinely forcing reinstalls.

# Claude Code and VS Code Essentials

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![Windows](https://img.shields.io/badge/Windows-0078D6?logo=windows)](https://www.microsoft.com/windows)
[![macOS](https://img.shields.io/badge/macOS-000000?logo=apple)](https://www.apple.com/macos)
[![Linux](https://img.shields.io/badge/Linux-FCC624?logo=linux&logoColor=black)](https://www.linux.org/)
[![VS Code](https://img.shields.io/badge/VS%20Code-007ACC?logo=visualstudiocode)](https://code.visualstudio.com/)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-orange)](https://claude.ai/code)

<p align="center">
  <img src="https://pub-528c6a71bd2845e4ba8a1a0265cff149.r2.dev/claude%20code%20vs%20code.jpeg" alt="Claude Code VS Code" width="800"/>
</p>

A complete guide for setting up a modern development environment with VS Code, Claude Code, and essential tools.

Perfect for **AI/ML developers**, **web developers**, and **creators** who want a professional setup fast.

---

## Quick Start

### Windows (PowerShell)
```powershell
irm https://raw.githubusercontent.com/AgriciDaniel/claude-code-essentials-vs-code/main/scripts/setup.ps1 | iex
```

### macOS / Linux (Bash)
```bash
curl -fsSL https://raw.githubusercontent.com/AgriciDaniel/claude-code-essentials-vs-code/main/scripts/setup.sh | bash
```

### Or Clone and Run Locally
```bash
git clone https://github.com/AgriciDaniel/claude-code-essentials-vs-code.git
cd claude-code-essentials-vs-code

# Windows
.\scripts\setup.ps1

# macOS / Linux
chmod +x scripts/setup.sh && ./scripts/setup.sh
```

---

## What's Included

| Guide | Description |
|-------|-------------|
| [Dev Setup Guide](docs/dev-setup-guide.md) | Core tools, package managers, CLI utilities |
| [VS Code Extensions](docs/vscode-extensions-guide.md) | 26 essential extensions + settings |
| [Claude Code Guide](docs/claude-code-guide.md) | Complete Claude Code features and usage |
| [Claude Code Resources](docs/claude-code-resources.md) | Ready-to-use skills, commands, agents |

---

## What Gets Installed

- **26 VS Code Extensions** - Python, ESLint, Prettier, Tailwind, GitLens, Claude Code Official, Copilot, and more
- **Claude Code CLI** - Full installation with directory structure
- **Example Commands and Skills** - Ready-to-use templates

---

## Top Claude Code Resources (2026)

### Workflow Systems

| System | Stars | Description | Install |
|--------|-------|-------------|---------|
| **BMAD Method** | 32.9k | 21 agents, 50+ workflows | `npx bmad-method install` |
| **SuperClaude** | 20.5k | 30 commands, 16 agents | `pipx install superclaude` |
| **CCPM** | 6.1k | GitHub-native project management | `curl -sSL https://automaze.io/ccpm/install \| bash` |

### MCP Servers (New Syntax)

```bash
# Official HTTP servers
claude mcp add --transport http github https://api.githubcopilot.com/mcp/
claude mcp add --transport http notion https://mcp.notion.com/mcp

# NPX-based servers
claude mcp add playwright -- npx @playwright/mcp@latest
claude mcp add memory -- npx -y @modelcontextprotocol/server-memory
```

### Community Resources

| Resource | Description |
|----------|-------------|
| [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) | 16.9k stars - Curated everything list |
| [wshobson/commands](https://github.com/wshobson/commands) | 57 production-ready commands |
| [claude-flow](https://github.com/ruvnet/claude-flow) | 60+ agents with swarm coordination |
| [SkillsMP.com](https://skillsmp.com) | 71k+ skills marketplace |

See [Claude Code Resources](docs/claude-code-resources.md) for the complete **Top 30 ranked list** with install commands.

---

## Platform-Specific Scripts

| Script | Windows | macOS | Linux |
|--------|---------|-------|-------|
| Full setup | `setup.ps1` | `setup.sh` | `setup.sh` |
| Extensions only | `install-extensions.ps1` | `install-extensions.sh` | `install-extensions.sh` |
| Claude Code only | `setup-claude-code.ps1` | `setup-claude-code.sh` | `setup-claude-code.sh` |

---

## Prerequisites

### Windows
- [Node.js](https://nodejs.org/) (LTS)
- [VS Code](https://code.visualstudio.com/)
- PowerShell 5.1+ (included in Windows)

### macOS
```bash
# Install Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Node.js and VS Code
brew install node
brew install --cask visual-studio-code
```

### Linux (Ubuntu/Debian)
```bash
# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# Install VS Code
sudo snap install code --classic
# Or: https://code.visualstudio.com/docs/setup/linux
```

---

## Guides Overview

### [Dev Setup Guide](docs/dev-setup-guide.md)
Complete toolchain: Node.js, Python, Git, package managers, CLI tools, containers, AI/ML packages.

### [VS Code Extensions](docs/vscode-extensions-guide.md)
26 curated extensions including the official Claude Code extension, with one-liner install.

### [Claude Code Guide](docs/claude-code-guide.md)
Everything about Claude Code: slash commands, skills, subagents, MCP servers, plugins, hooks.

### [Claude Code Resources](docs/claude-code-resources.md)
Ready-to-use templates: slash commands, skills, agents, and CLAUDE.md project template.

---

## Keep Everything Updated

### Windows
```powershell
winget upgrade --all
npm update -g @anthropic-ai/claude-code
```

### macOS
```bash
brew update && brew upgrade
npm update -g @anthropic-ai/claude-code
```

### Linux
```bash
sudo apt update && sudo apt upgrade -y
npm update -g @anthropic-ai/claude-code
```

---

## FAQ

**Q: Do I need a paid Claude account?**
A: Yes, Claude Code requires Claude Pro, Max, Teams, or API access.

**Q: Which platforms are supported?**
A: Windows, macOS, and Linux are all fully supported with dedicated scripts.

**Q: What's the difference between Cline and Claude Code extension?**
A: Cline is third-party. Claude Code (anthropic.claude-code) is Anthropic's official extension.

---

## License

MIT License - Use freely for personal and commercial projects.

---

## Support

If this helped you, consider starring this repo, forking and customizing, or sharing with other developers.

---

Made with love for the developer community
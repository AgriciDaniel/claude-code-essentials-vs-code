# 🚀 Developer Environment Setup Guide

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![Windows](https://img.shields.io/badge/Platform-Windows-blue.svg)](https://www.microsoft.com/windows)
[![VS Code](https://img.shields.io/badge/Editor-VS%20Code-007ACC.svg)](https://code.visualstudio.com/)
[![Claude Code](https://img.shields.io/badge/AI-Claude%20Code-orange.svg)](https://claude.ai/code)

A complete guide for setting up a modern development environment on Windows with VS Code, Claude Code, and essential tools.

Perfect for **AI/ML developers**, **web developers**, and **creators** who want a professional setup fast.

![Setup Preview](images/setup-preview.png)

---

## 📦 What's Included

| Guide | Description |
|-------|-------------|
| [Dev Setup Guide](docs/claude-code-essentials-vs-code.md) | Core tools, package managers, CLI utilities |
| [VS Code Extensions](docs/vscode-extensions-guide.md) | 26 essential extensions + settings |
| [Claude Code Guide](docs/claude-code-guide.md) | Complete Claude Code features & usage |
| [Claude Code Resources](docs/claude-code-resources.md) | Ready-to-use skills, commands, agents |

---

## ⚡ Quick Start

### One-Command Setup

Run this in PowerShell to install everything:

```powershell
irm https://raw.githubusercontent.com/AgriciDaniel/claude-code-essentials-vs-code/main/scripts/setup.ps1 | iex
```

Or clone and run locally:

```powershell
git clone https://github.com/AgriciDaniel/claude-code-essentials-vs-code.git
cd claude-code-essentials-vs-code
.\scripts\setup.ps1
```

---

## 🛠️ Manual Installation

### Core Tools

```powershell
# Node.js, Python, Git
winget install OpenJS.NodeJS.LTS
winget install Python.Python.3.12
winget install Git.Git

# VS Code
winget install Microsoft.VisualStudioCode

# Claude Code
npm install -g @anthropic-ai/claude-code
```

### VS Code Extensions (26 total)

```powershell
# Run the extension installer
.\scripts\install-extensions.ps1
```

### Claude Code Setup

```powershell
# Create directories
.\scripts\setup-claude-code.ps1
```

---

## 📁 Repository Structure

```
claude-code-essentials-vs-code/
├── README.md
├── LICENSE
├── docs/
│   ├── claude-code-essentials-vs-code.md          # Core development tools
│   ├── vscode-extensions-guide.md  # VS Code extensions
│   ├── claude-code-guide.md        # Claude Code complete guide
│   └── claude-code-resources.md    # Skills, commands, agents
├── scripts/
│   ├── setup.ps1                   # All-in-one setup script
│   ├── install-extensions.ps1      # VS Code extensions only
│   └── setup-claude-code.ps1       # Claude Code directories
├── templates/
│   ├── CLAUDE.md                   # Project template
│   └── commands/                   # Example slash commands
│       ├── fix-issue.md
│       ├── review.md
│       ├── test.md
│       └── document.md
└── images/                         # Screenshots (add your own!)
```

---

## 🎯 What Gets Installed

### Development Tools
- Node.js (LTS) + npm
- Python 3.12 + pip
- Git
- Docker Desktop
- WSL2

### Package Managers
- pnpm, yarn, bun
- TypeScript, Next.js

### CLI Tools
- GitHub CLI
- fzf, ripgrep, bat, zoxide, lazygit

### VS Code Extensions (26)
- Python, ESLint, Prettier
- Tailwind CSS, Prisma
- GitLens, Git Graph
- **Claude Code (Official)**, GitHub Copilot, Cline
- Docker, Remote WSL/SSH
- Jupyter, Thunder Client
- Error Lens, Material Icons
- And more...

### Claude Code
- Full CLI installation
- Directory structure
- Example commands & skills

---

## 📖 Guides Overview

### 1. [Dev Setup Guide](docs/claude-code-essentials-vs-code.md)
Complete toolchain installation: Node.js, Python, Git, package managers, CLI tools, containers, AI/ML packages.

### 2. [VS Code Extensions](docs/vscode-extensions-guide.md)
26 curated extensions organized by category, including the **official Claude Code extension**, with one-liner install commands and recommended settings.

### 3. [Claude Code Guide](docs/claude-code-guide.md)
Everything about Claude Code: installation, slash commands, skills, subagents, MCP servers, plugins, hooks, and best practices.

### 4. [Claude Code Resources](docs/claude-code-resources.md)
Ready-to-use templates: slash commands, skills, agents, CLAUDE.md template, and links to community resources.

---

## 🔄 Keep Everything Updated

```powershell
# Update all tools
winget upgrade --all
npm update -g
pip install --upgrade pip
wsl --update

# Update Claude Code
npm update -g @anthropic-ai/claude-code
```

---

## 🤝 Contributing

Contributions welcome! Feel free to:
- Add new tools or extensions
- Improve documentation
- Share your custom Claude Code commands
- Report issues

---

## ❓ FAQ

**Q: Do I need a paid Claude account?**
A: Yes, Claude Code requires Claude Pro, Max, Teams, or API access.

**Q: Can I use this on Mac/Linux?**
A: The guides focus on Windows/PowerShell, but most tools work cross-platform. Adapt `winget` commands to `brew` (Mac) or `apt` (Linux).

**Q: What's the difference between Cline and Claude Code extension?**
A: Cline (claude-dev) is a third-party extension. Claude Code (anthropic.claude-code) is Anthropic's official extension with native integration.

**Q: How do I reduce token usage?**
A: Use `/compact` to compress history, `/clear` to start fresh, and check `/context` for usage stats.

**Q: Can I use Claude Code offline?**
A: No, Claude Code requires an internet connection to communicate with Anthropic's API.

---

## 📜 License

MIT License - Use freely for personal and commercial projects.

---

## ⭐ Support

If this helped you, consider:
- ⭐ Starring this repo
- 🍴 Forking and customizing
- 📢 Sharing with other developers

---

Made with ❤️ for the developer community

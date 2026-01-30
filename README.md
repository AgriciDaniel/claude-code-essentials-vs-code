# Claude Code and VS Code Essentials

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![Windows](https://img.shields.io/badge/Platform-Windows-blue.svg)](https://www.microsoft.com/windows)
[![VS Code](https://img.shields.io/badge/Editor-VS%20Code-007ACC.svg)](https://code.visualstudio.com/)
[![Claude Code](https://img.shields.io/badge/AI-Claude%20Code-orange.svg)](https://claude.ai/code)

<p align="center">
  <img src="https://pub-528c6a71bd2845e4ba8a1a0265cff149.r2.dev/claude%20code%20vs%20code.jpeg" alt="Claude Code VS Code" width="800"/>
</p>

A complete guide for setting up a modern development environment on Windows with VS Code, Claude Code, and essential tools.

Perfect for **AI/ML developers**, **web developers**, and **creators** who want a professional setup fast.

---

## Quick Start

### One-Command Setup

Run this in PowerShell to install everything:
```
irm https://raw.githubusercontent.com/AgriciDaniel/claude-code-essentials-vs-code/main/scripts/setup.ps1 | iex
```

Or clone and run locally:
```
git clone https://github.com/AgriciDaniel/claude-code-essentials-vs-code.git
cd claude-code-essentials-vs-code
.\scripts\setup.ps1
```

---

## Whats Included

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
```
winget upgrade --all
npm update -g @anthropic-ai/claude-code
```

---

## FAQ

**Q: Do I need a paid Claude account?**  
A: Yes, Claude Code requires Claude Pro, Max, Teams, or API access.

**Q: Can I use this on Mac or Linux?**  
A: Guides focus on Windows, but most tools work cross-platform.

**Q: Whats the difference between Cline and Claude Code extension?**  
A: Cline is third-party. Claude Code (anthropic.claude-code) is Anthropics official extension.

---

## License

MIT License - Use freely for personal and commercial projects.

---

## Support

If this helped you, consider starring this repo, forking and customizing, or sharing with other developers.

---

Made with love for the developer community

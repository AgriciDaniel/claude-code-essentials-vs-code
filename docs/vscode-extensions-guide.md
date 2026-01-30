# VS Code Extensions Complete Guide

## Essential Extensions

### Install All (Copy & Run)

```powershell
# Core
code --install-extension ms-python.python
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension ms-vscode.vscode-typescript-next

# Web Development
code --install-extension bradlc.vscode-tailwindcss
code --install-extension prisma.prisma
code --install-extension formulahendry.auto-rename-tag
code --install-extension christian-kohler.path-intellisense
code --install-extension ritwickdey.LiveServer

# Git
code --install-extension eamodio.gitlens
code --install-extension mhutchie.git-graph

# AI Assistants (BOTH recommended!)
code --install-extension anthropic.claude-code
code --install-extension github.copilot
code --install-extension saoudrizwan.claude-dev

# Containers & Remote
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-vscode-remote.remote-wsl
code --install-extension ms-vscode-remote.remote-ssh

# Python & Data
code --install-extension ms-toolsai.jupyter

# API Testing
code --install-extension rangav.vscode-thunder-client

# Productivity
code --install-extension usernamehw.errorlens
code --install-extension PKief.material-icon-theme
code --install-extension aaron-bond.better-comments
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension alefragnani.Bookmarks
code --install-extension wix.vscode-import-cost
code --install-extension formulahendry.code-runner
```

---

## 🆕 Official Claude Code VS Code Extension (Beta)

Anthropic's **official** Claude Code extension brings the full Claude Code experience directly into VS Code with a native GUI.

### Install

```powershell
code --install-extension anthropic.claude-code
```

Or search "Claude Code" in VS Code Extensions (look for the Anthropic publisher).

### Features

| Feature | Description |
|---------|-------------|
| **Native Sidebar** | Dedicated Claude Code panel (Spark icon ✨) |
| **Plan Mode** | Review and edit Claude's plans before accepting |
| **Auto-Accept Edits** | Automatically apply changes as they're made |
| **Extended Thinking** | Toggle deep reasoning on/off |
| **File @-mentions** | Reference files with `@filename` |
| **Image Support** | Attach images for visual context |
| **Multiple Sessions** | Run several Claude sessions simultaneously |
| **MCP Servers** | Use configured MCP servers from CLI |

### Requirements

- VS Code **1.98.0** or higher

### Usage

1. Click the **Spark icon (✨)** in the sidebar
2. Prompt Claude as you would in terminal
3. Watch real-time code suggestions
4. Review and accept edits with inline diffs

### Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Cmd+Option+K` (Mac) | Insert file reference |
| `Alt+Ctrl+K` (Win/Linux) | Insert file reference |

### Pro Tips

- Drag sidebar wider to see inline diffs
- Click on diffs to expand full details
- Use `/mcp` to configure MCP servers
- Use `/plugin` to manage plugins

> ⚠️ **Security Note**: With auto-edit enabled, Claude can modify IDE config files. Consider using VS Code Restricted Mode for untrusted workspaces.

---

## Quick Install (All 26 Extensions)

**Option 1: Use the setup script (Recommended)**
```bash
# Windows
.\scripts\install-extensions.ps1

# Linux/Mac
./scripts/install-extensions.sh
```

**Option 2: One-liner** (copy the entire line - it's long but works)
```powershell
code --install-extension ms-python.python; code --install-extension dbaeumer.vscode-eslint; code --install-extension esbenp.prettier-vscode; code --install-extension ms-vscode.vscode-typescript-next; code --install-extension bradlc.vscode-tailwindcss; code --install-extension prisma.prisma; code --install-extension formulahendry.auto-rename-tag; code --install-extension christian-kohler.path-intellisense; code --install-extension ritwickdey.LiveServer; code --install-extension eamodio.gitlens; code --install-extension mhutchie.git-graph; code --install-extension anthropic.claude-code; code --install-extension github.copilot; code --install-extension saoudrizwan.claude-dev; code --install-extension ms-azuretools.vscode-docker; code --install-extension ms-vscode-remote.remote-wsl; code --install-extension ms-vscode-remote.remote-ssh; code --install-extension ms-toolsai.jupyter; code --install-extension rangav.vscode-thunder-client; code --install-extension usernamehw.errorlens; code --install-extension PKief.material-icon-theme; code --install-extension aaron-bond.better-comments; code --install-extension streetsidesoftware.code-spell-checker; code --install-extension alefragnani.Bookmarks; code --install-extension wix.vscode-import-cost; code --install-extension formulahendry.code-runner
```

---

## What Each Does

### Core Development

| Extension | Purpose |
|-----------|---------|
| Python | Python language support, debugging, linting |
| ESLint | JavaScript/TypeScript linting |
| Prettier | Auto code formatting |
| TypeScript Next | Latest TypeScript features |

### Web Development

| Extension | Purpose |
|-----------|---------|
| Tailwind CSS | Tailwind IntelliSense & autocomplete |
| Prisma | Database ORM syntax highlighting |
| Auto Rename Tag | Auto rename paired HTML tags |
| Path Intellisense | Filepath autocomplete |
| Live Server | Local dev server with hot reload |

### Git & Version Control

| Extension | Purpose |
|-----------|---------|
| GitLens | Git blame, history, annotations |
| Git Graph | Visual git branch graph |

### AI Assistants

| Extension | Purpose |
|-----------|---------|
| **Claude Code (Official)** | Anthropic's native VS Code extension (Beta) |
| GitHub Copilot | AI code completion (paid) |
| Cline (claude-dev) | Claude AI agent in VS Code |

### Containers & Remote

| Extension | Purpose |
|-----------|---------|
| Docker | Container management |
| Remote WSL | Develop in WSL |
| Remote SSH | Develop on remote servers |

### Data & Notebooks

| Extension | Purpose |
|-----------|---------|
| Jupyter | Notebook support for Python/ML |

### API Testing

| Extension | Purpose |
|-----------|---------|
| Thunder Client | REST API testing (like Postman) |

### Productivity

| Extension | Purpose |
|-----------|---------|
| Error Lens | Show errors inline in code |
| Material Icons | Better file icons |
| Better Comments | Colored comment annotations |
| Code Spell Checker | Catch typos in code/comments |
| Bookmarks | Mark important lines |
| Import Cost | Show package import sizes |
| Code Runner | Run code snippets quickly |

---

## Optional (Framework-Specific)

```powershell
# React/Next.js
code --install-extension dsznajder.es7-react-js-snippets

# Vue
code --install-extension Vue.volar

# Svelte
code --install-extension svelte.svelte-vscode

# GraphQL
code --install-extension GraphQL.vscode-graphql

# Markdown
code --install-extension yzhang.markdown-all-in-one

# YAML
code --install-extension redhat.vscode-yaml

# Database
code --install-extension mtxr.sqltools
```

---

## Recommended Settings

Add to `settings.json` (`Ctrl+Shift+P` → "Open Settings JSON"):

```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": "explicit"
  },
  "editor.minimap.enabled": false,
  "editor.wordWrap": "on",
  "files.autoSave": "onFocusChange",
  "workbench.iconTheme": "material-icon-theme"
}
```

---

## Verify Installation

```powershell
code --list-extensions
```

---

## Update All Extensions

VS Code auto-updates, but force check:
`Ctrl+Shift+P` → "Extensions: Check for Extension Updates"

---

## Total: 26 Extensions

Core (4) + Web (5) + Git (2) + AI (3) + Remote (3) + Data (1) + API (1) + Productivity (7)

# Dev Environment Setup Guide

## Core Tools

```powershell
# Node.js (LTS)
winget install OpenJS.NodeJS.LTS

# Python
winget install Python.Python.3.12

# Git
winget install Git.Git

# PowerShell 7
winget install Microsoft.PowerShell

# VS Code
winget install Microsoft.VisualStudioCode
```

## Package Managers

```powershell
# pnpm (faster than npm)
npm install -g pnpm

# Yarn
npm install -g yarn

# Bun (super fast JS runtime)
winget install Oven-sh.Bun

# uv (ultra-fast Python package manager)
winget install astral-sh.uv
```

## Claude Code

```powershell
# CLI
npm install -g @anthropic-ai/claude-code

# VS Code Extension
code --install-extension anthropic.claude-code
```

## Frameworks

```powershell
# Next.js
npm install -g create-next-app

# TypeScript
npm install -g typescript
```

## CLI Tools

```powershell
# GitHub CLI
winget install GitHub.cli

# fzf (fuzzy finder)
winget install junegunn.fzf

# ripgrep (fast search)
winget install BurntSushi.ripgrep.MSVC

# bat (better cat)
winget install sharkdp.bat

# zoxide (smarter cd)
winget install ajeetdsouza.zoxide

# lazygit (git UI)
winget install JesseDuffield.lazygit
```

## Containers

```powershell
# Docker Desktop
winget install Docker.DockerDesktop

# WSL2
wsl --install
```

## Python AI/ML Packages

```powershell
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124
pip install transformers datasets accelerate huggingface-hub
pip install pandas numpy matplotlib seaborn scikit-learn scipy
pip install jupyter notebook
```

## Git Config

```powershell
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git config --global init.defaultBranch main
```

## GitHub SSH Setup (Recommended)

```powershell
# Generate SSH key
ssh-keygen -t ed25519 -C "your@email.com"

# Start SSH agent
Get-Service -Name ssh-agent | Set-Service -StartupType Automatic
Start-Service ssh-agent

# Add key to agent
ssh-add $HOME\.ssh\id_ed25519

# Copy public key (add to GitHub → Settings → SSH Keys)
Get-Content $HOME\.ssh\id_ed25519.pub | clip

# Test connection
ssh -T git@github.com
```

## Update Everything

```powershell
winget upgrade --all
npm update -g
pip install --upgrade pip
wsl --update
```

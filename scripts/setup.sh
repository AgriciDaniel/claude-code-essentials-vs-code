#!/bin/bash

# Dev Environment Setup Script for Linux/Mac
# Run: chmod +x setup.sh && ./setup.sh

echo ""
echo "====== COMPLETE DEV ENVIRONMENT SETUP ======"
echo "This script will install VS Code extensions, Claude Code, and set up directories."
echo ""

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="mac"
    echo "[INFO] Detected: macOS"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    echo "[INFO] Detected: Linux"
else
    echo "[ERROR] Unsupported OS: $OSTYPE"
    exit 1
fi

# ===== VS CODE EXTENSIONS =====
echo ""
echo "[1/4] Installing VS Code Extensions..."

extensions=(
    "ms-python.python"
    "dbaeumer.vscode-eslint"
    "esbenp.prettier-vscode"
    "ms-vscode.vscode-typescript-next"
    "bradlc.vscode-tailwindcss"
    "prisma.prisma"
    "formulahendry.auto-rename-tag"
    "christian-kohler.path-intellisense"
    "ritwickdey.LiveServer"
    "eamodio.gitlens"
    "mhutchie.git-graph"
    "anthropic.claude-code"
    "github.copilot"
    "saoudrizwan.claude-dev"
    "ms-azuretools.vscode-docker"
    "ms-vscode-remote.remote-wsl"
    "ms-vscode-remote.remote-ssh"
    "ms-toolsai.jupyter"
    "rangav.vscode-thunder-client"
    "usernamehw.errorlens"
    "PKief.material-icon-theme"
    "aaron-bond.better-comments"
    "streetsidesoftware.code-spell-checker"
    "alefragnani.Bookmarks"
    "wix.vscode-import-cost"
    "formulahendry.code-runner"
)

# Check if VS Code is installed
if command -v code &> /dev/null; then
    for ext in "${extensions[@]}"; do
        echo "  Installing $ext..."
        code --install-extension "$ext" --force 2>/dev/null
    done
    echo "  [OK] ${#extensions[@]} VS Code extensions installed"
else
    echo "  [SKIP] VS Code not found. Install from https://code.visualstudio.com/"
fi

# ===== CLAUDE CODE =====
echo ""
echo "[2/4] Installing/Updating Claude Code..."

# Check if npm is installed
if command -v npm &> /dev/null; then
    npm install -g @anthropic-ai/claude-code 2>/dev/null
    if command -v claude &> /dev/null; then
        echo "  [OK] Claude Code: $(claude --version 2>/dev/null)"
    else
        echo "  [OK] Claude Code installed (restart terminal to use)"
    fi
else
    echo "  [SKIP] npm not found. Install Node.js first."
fi

# ===== CLAUDE CODE DIRECTORIES =====
echo ""
echo "[3/4] Setting up Claude Code directories..."

dirs=(
    "$HOME/.claude/commands"
    "$HOME/.claude/skills"
    "$HOME/.claude/agents"
)

for dir in "${dirs[@]}"; do
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo "  Created: $dir"
    else
        echo "  Exists: $dir"
    fi
done
echo "  [OK] Claude Code directories ready"

# ===== VERIFICATION =====
echo ""
echo "[4/4] Verification..."

if command -v code &> /dev/null; then
    ext_count=$(code --list-extensions 2>/dev/null | wc -l)
    echo "  VS Code Extensions: $ext_count installed"
fi

if command -v claude &> /dev/null; then
    echo "  Claude Code: $(claude --version 2>/dev/null)"
else
    echo "  Claude Code: Restart terminal to verify"
fi

echo "  Directories:"
for dir in "${dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo "    [OK] $dir"
    else
        echo "    [X] $dir"
    fi
done

# ===== DONE =====
echo ""
echo "====== SETUP COMPLETE ======"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal to refresh PATH"
echo "  2. Run 'claude' to start Claude Code"
echo "  3. Add custom commands to: ~/.claude/commands/"
echo "  4. Check docs/ folder for guides"
echo ""
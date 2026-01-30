#!/bin/bash

# VS Code Extensions Installer for Linux/Mac
# Run: chmod +x install-extensions.sh && ./install-extensions.sh

echo ""
echo "====== VS CODE EXTENSIONS INSTALLER ======"
echo ""

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

if ! command -v code &> /dev/null; then
    echo "[ERROR] VS Code not found!"
    echo "Install from: https://code.visualstudio.com/"
    exit 1
fi

echo "Installing ${#extensions[@]} extensions..."
echo ""

for ext in "${extensions[@]}"; do
    echo "  Installing $ext..."
    code --install-extension "$ext" --force 2>/dev/null
done

echo ""
echo "====== COMPLETE ======"
ext_count=$(code --list-extensions | wc -l)
echo "Total extensions installed: $ext_count"
echo ""
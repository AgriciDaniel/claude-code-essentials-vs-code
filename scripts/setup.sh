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
echo "[1/6] Installing VS Code Extensions..."

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
echo "[2/6] Installing/Updating Claude Code..."

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
echo "[3/6] Setting up Claude Code directories..."

dirs=(
    "$HOME/.claude/commands"
    "$HOME/.claude/skills/code-quality"
    "$HOME/.claude/skills/security"
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

# ===== EXAMPLE FILES =====
echo ""
echo "[4/6] Creating example files..."

# Example command
review_cmd="$HOME/.claude/commands/review.md"
if [ ! -f "$review_cmd" ]; then
    cat > "$review_cmd" << 'CMDEOF'
---
description: Review code for best practices
---
Review the code for:
1. Security vulnerabilities
2. Performance issues
3. Error handling
4. Code style consistency
5. Test coverage gaps

Provide specific suggestions with code examples.
CMDEOF
    echo "  Created: $review_cmd"
else
    echo "  Exists: $review_cmd"
fi

# Example skill
skill_file="$HOME/.claude/skills/code-quality/SKILL.md"
if [ ! -f "$skill_file" ]; then
    cat > "$skill_file" << 'SKILLEOF'
---
name: code-quality
description: Enforce code quality standards
---
When writing or reviewing code:

1. Follow project style guide
2. Use meaningful variable names
3. Keep functions under 50 lines
4. Add error handling
5. Write self-documenting code
6. Avoid magic numbers
7. Use early returns
SKILLEOF
    echo "  Created: $skill_file"
else
    echo "  Exists: $skill_file"
fi

echo "  [OK] Example files created"

# ===== MCP SERVERS (OPTIONAL) =====
echo ""
echo "[5/6] MCP Servers (Optional)..."
echo -n "Would you like to install recommended MCP servers? (y/n): "
read mcp

if [ "$mcp" = "y" ] || [ "$mcp" = "Y" ]; then
    echo "  Installing Memory MCP..."
    claude mcp add memory -- npx -y @modelcontextprotocol/server-memory 2>/dev/null
    echo "  Installing Playwright MCP..."
    claude mcp add playwright -- npx @playwright/mcp@latest 2>/dev/null
    echo "  [OK] MCP servers installed"
    echo ""
    echo "  To add GitHub MCP, run:"
    echo "  claude mcp add --transport http github https://api.githubcopilot.com/mcp/"
else
    echo "  Skipped MCP installation"
fi

# ===== VERIFICATION =====
echo ""
echo "[6/6] Verification..."

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
echo "Your Claude Code structure:"
echo "  ~/.claude/"
echo "    commands/     <- Your slash commands (try /review)"
echo "    skills/       <- Auto-invoked skills"
echo "    agents/       <- Custom subagents"
echo ""
echo "Top resources to explore:"
echo "  - BMAD Method: npx bmad-method install"
echo "  - SuperClaude: pipx install superclaude"
echo "  - See docs/claude-code-resources.md for Top 30 list"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal to refresh PATH"
echo "  2. Run 'claude' to start Claude Code"
echo "  3. Use '/review' to test your new command"
echo "  4. Check docs/ folder for guides"
echo ""
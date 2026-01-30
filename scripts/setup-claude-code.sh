#!/bin/bash

# Claude Code Setup Script for Linux/Mac
# Run: chmod +x setup-claude-code.sh && ./setup-claude-code.sh

echo ""
echo "====== CLAUDE CODE SETUP ======"
echo ""

# ===== INSTALL CLAUDE CODE =====
echo "[1/5] Installing Claude Code..."

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "  [ERROR] npm is not installed."
    echo "  Please install Node.js first: https://nodejs.org/"
    exit 1
fi

# Install Claude Code globally
npm install -g @anthropic-ai/claude-code
echo "  [OK] Claude Code installed"

# ===== CREATE DIRECTORIES =====
echo ""
echo "[2/5] Creating directories..."

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

# ===== CREATE EXAMPLE COMMAND =====
echo ""
echo "[3/5] Creating example command..."

review_cmd="$HOME/.claude/commands/review.md"
if [ ! -f "$review_cmd" ]; then
    cat > "$review_cmd" << 'CMDEOF'
# Code Review Command

Review the current code for:

1. **Security Issues**
   - SQL injection, XSS, authentication flaws
   - Exposed secrets or credentials

2. **Performance**
   - N+1 queries, unnecessary loops
   - Memory leaks, missing caching

3. **Code Quality**
   - DRY violations, complex functions
   - Missing error handling

4. **Best Practices**
   - Framework conventions
   - Naming and documentation

Provide specific line numbers and suggested fixes.
CMDEOF
    echo "  Created: $review_cmd"
else
    echo "  Exists: $review_cmd"
fi

# ===== CREATE EXAMPLE SKILL =====
echo ""
echo "[4/5] Creating example skill..."

skill_dir="$HOME/.claude/skills/code-quality"
skill_file="$skill_dir/SKILL.md"

if [ ! -d "$skill_dir" ]; then
    mkdir -p "$skill_dir"
fi

if [ ! -f "$skill_file" ]; then
    cat > "$skill_file" << 'SKILLEOF'
---
name: code-quality
description: Ensures code follows quality standards
auto_invoke: true
triggers:
  - "review"
  - "refactor"
  - "improve"
---

# Code Quality Skill

When reviewing or writing code:

## Standards
- Follow project style guide
- Use meaningful variable names
- Keep functions under 50 lines
- Add JSDoc/docstrings for public APIs

## Checks
- No console.log in production
- Proper error handling
- Type safety (TypeScript/Python hints)
- Test coverage for new code

## Output
- Explain changes made
- Note any concerns
- Suggest improvements
SKILLEOF
    echo "  Created: $skill_file"
else
    echo "  Exists: $skill_file"
fi

# ===== OPTIONAL: MCP SERVERS =====
echo ""
echo "[5/5] MCP Servers (Optional)..."
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
echo "====== SETUP COMPLETE ======"
echo ""
echo "Claude Code version: $(claude --version)"
echo ""
echo "Directories:"
for dir in "${dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo "  [OK] $dir"
    fi
done
echo ""
echo "Top resources to explore:"
echo "  - BMAD Method: npx bmad-method install"
echo "  - SuperClaude: pipx install superclaude"
echo "  - See docs/claude-code-resources.md for Top 30 list"
echo ""
echo "Next steps:"
echo "  1. Run 'claude' to start Claude Code"
echo "  2. Use '/review' to test your new command"
echo "  3. Add more commands to ~/.claude/commands/"
echo ""
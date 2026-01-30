#!/bin/bash

# Claude Code Setup Script for Linux/Mac
# Run: chmod +x setup-claude-code.sh && ./setup-claude-code.sh

echo ""
echo "====== CLAUDE CODE SETUP ======"
echo ""

# ===== CREATE DIRECTORIES =====
echo "[1/3] Creating directories..."

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
echo "[2/3] Creating example command..."

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
echo "[3/3] Creating example skill..."

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

# ===== VERIFICATION =====
echo ""
echo "====== SETUP COMPLETE ======"
echo ""
echo "Directories:"
for dir in "${dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo "  [OK] $dir"
    fi
done
echo ""
echo "Next steps:"
echo "  1. Run 'claude' to start Claude Code"
echo "  2. Use '/review' to test your new command"
echo "  3. Add more commands to ~/.claude/commands/"
echo ""
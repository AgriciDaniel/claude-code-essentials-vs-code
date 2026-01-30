# Claude Code Setup Script
# Run: .\setup-claude-code.ps1

Write-Host "`n====== CLAUDE CODE SETUP ======" -ForegroundColor Cyan

# Install/Update Claude Code
Write-Host "`n[1/3] Installing Claude Code..." -ForegroundColor Yellow
npm install -g @anthropic-ai/claude-code
Write-Host "  [OK] Claude Code installed" -ForegroundColor Green

# Create directories
Write-Host "`n[2/3] Creating directories..." -ForegroundColor Yellow

$dirs = @(
    "$HOME\.claude\commands",
    "$HOME\.claude\skills\code-quality",
    "$HOME\.claude\skills\security",
    "$HOME\.claude\agents"
)

foreach ($dir in $dirs) {
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
    Write-Host "  Created: $dir" -ForegroundColor Gray
}
Write-Host "  [OK] Directories created" -ForegroundColor Green

# Create example files
Write-Host "`n[3/3] Creating example files..." -ForegroundColor Yellow

# Example command
$reviewCommand = @"
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
"@

Set-Content -Path "$HOME\.claude\commands\review.md" -Value $reviewCommand
Write-Host "  Created: ~/.claude/commands/review.md" -ForegroundColor Gray

# Example skill
$codeQualitySkill = @"
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
"@

Set-Content -Path "$HOME\.claude\skills\code-quality\SKILL.md" -Value $codeQualitySkill
Write-Host "  Created: ~/.claude/skills/code-quality/SKILL.md" -ForegroundColor Gray

Write-Host "  [OK] Example files created" -ForegroundColor Green

# Verify
Write-Host "`n====== SETUP COMPLETE ======" -ForegroundColor Cyan
Write-Host "`nClaude Code version: $(claude --version)"
Write-Host "`nYour Claude Code structure:"
Write-Host "  ~/.claude/"
Write-Host "    commands/     <- Your slash commands"
Write-Host "    skills/       <- Auto-invoked skills"
Write-Host "    agents/       <- Custom subagents"
Write-Host "`nRun 'claude' to start!`n"

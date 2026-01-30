# Dev Environment Setup Script
# Run: .\setup.ps1

Write-Host "`n====== COMPLETE DEV ENVIRONMENT SETUP ======" -ForegroundColor Cyan
Write-Host "This script will install VS Code extensions, Claude Code, and set up directories.`n"

# ===== VS CODE EXTENSIONS =====
Write-Host "[1/6] Installing VS Code Extensions..." -ForegroundColor Yellow

$extensions = @(
    "ms-python.python",
    "dbaeumer.vscode-eslint",
    "esbenp.prettier-vscode",
    "ms-vscode.vscode-typescript-next",
    "bradlc.vscode-tailwindcss",
    "prisma.prisma",
    "formulahendry.auto-rename-tag",
    "christian-kohler.path-intellisense",
    "ritwickdey.LiveServer",
    "eamodio.gitlens",
    "mhutchie.git-graph",
    "anthropic.claude-code",
    "github.copilot",
    "saoudrizwan.claude-dev",
    "ms-azuretools.vscode-docker",
    "ms-vscode-remote.remote-wsl",
    "ms-vscode-remote.remote-ssh",
    "ms-toolsai.jupyter",
    "rangav.vscode-thunder-client",
    "usernamehw.errorlens",
    "PKief.material-icon-theme",
    "aaron-bond.better-comments",
    "streetsidesoftware.code-spell-checker",
    "alefragnani.Bookmarks",
    "wix.vscode-import-cost",
    "formulahendry.code-runner"
)

$installed = 0
foreach ($ext in $extensions) {
    Write-Host "  Installing $ext..." -ForegroundColor Gray
    code --install-extension $ext --force 2>$null
    $installed++
}
Write-Host "  [OK] $installed VS Code extensions installed" -ForegroundColor Green

# ===== CLAUDE CODE =====
Write-Host "`n[2/6] Installing/Updating Claude Code..." -ForegroundColor Yellow
npm install -g @anthropic-ai/claude-code 2>$null
$claudeVersion = claude --version 2>$null
Write-Host "  [OK] Claude Code: $claudeVersion" -ForegroundColor Green

# ===== CLAUDE CODE DIRECTORIES =====
Write-Host "`n[3/6] Setting up Claude Code directories..." -ForegroundColor Yellow

$dirs = @(
    "$HOME\.claude\commands",
    "$HOME\.claude\skills\code-quality",
    "$HOME\.claude\skills\security",
    "$HOME\.claude\agents"
)

foreach ($dir in $dirs) {
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Force -Path $dir | Out-Null
        Write-Host "  Created: $dir" -ForegroundColor Gray
    } else {
        Write-Host "  Exists: $dir" -ForegroundColor Gray
    }
}
Write-Host "  [OK] Claude Code directories ready" -ForegroundColor Green

# ===== EXAMPLE FILES =====
Write-Host "`n[4/6] Creating example files..." -ForegroundColor Yellow

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

if (!(Test-Path "$HOME\.claude\commands\review.md")) {
    Set-Content -Path "$HOME\.claude\commands\review.md" -Value $reviewCommand
    Write-Host "  Created: ~/.claude/commands/review.md" -ForegroundColor Gray
}

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

if (!(Test-Path "$HOME\.claude\skills\code-quality\SKILL.md")) {
    Set-Content -Path "$HOME\.claude\skills\code-quality\SKILL.md" -Value $codeQualitySkill
    Write-Host "  Created: ~/.claude/skills/code-quality/SKILL.md" -ForegroundColor Gray
}

Write-Host "  [OK] Example files created" -ForegroundColor Green

# ===== MCP SERVERS (OPTIONAL) =====
Write-Host "`n[5/6] MCP Servers (Optional)..." -ForegroundColor Yellow
Write-Host "Would you like to install recommended MCP servers? (y/n)" -ForegroundColor Cyan
$mcp = Read-Host

if ($mcp -eq 'y' -or $mcp -eq 'Y') {
    Write-Host "  Installing Memory MCP..." -ForegroundColor Gray
    claude mcp add memory -- npx -y @modelcontextprotocol/server-memory 2>$null
    Write-Host "  Installing Playwright MCP..." -ForegroundColor Gray
    claude mcp add playwright -- npx @playwright/mcp@latest 2>$null
    Write-Host "  [OK] MCP servers installed" -ForegroundColor Green
    Write-Host "`n  To add GitHub MCP, run:" -ForegroundColor Yellow
    Write-Host "  claude mcp add --transport http github https://api.githubcopilot.com/mcp/"
} else {
    Write-Host "  Skipped MCP installation" -ForegroundColor Gray
}

# ===== VERIFICATION =====
Write-Host "`n[6/6] Verification..." -ForegroundColor Yellow

$extCount = (code --list-extensions 2>$null).Count
Write-Host "  VS Code Extensions: $extCount installed" -ForegroundColor Green

$claudeCheck = claude --version 2>$null
if ($claudeCheck) {
    Write-Host "  Claude Code: $claudeCheck" -ForegroundColor Green
} else {
    Write-Host "  Claude Code: Not found (restart terminal)" -ForegroundColor Yellow
}

Write-Host "  Directories:" -ForegroundColor Green
foreach ($dir in $dirs) {
    if (Test-Path $dir) { 
        Write-Host "    [OK] $dir" -ForegroundColor Green 
    } else {
        Write-Host "    [X] $dir" -ForegroundColor Red
    }
}

# ===== DONE =====
Write-Host "`n====== SETUP COMPLETE ======" -ForegroundColor Cyan
Write-Host "`nYour Claude Code structure:"
Write-Host "  ~/.claude/"
Write-Host "    commands/     <- Your slash commands (try /review)"
Write-Host "    skills/       <- Auto-invoked skills"
Write-Host "    agents/       <- Custom subagents"
Write-Host "`nTop resources to explore:"
Write-Host "  - BMAD Method: npx bmad-method install"
Write-Host "  - SuperClaude: pipx install superclaude"
Write-Host "  - See docs/claude-code-resources.md for Top 30 list"
Write-Host "`nNext steps:" -ForegroundColor White
Write-Host "  1. Restart your terminal to refresh PATH"
Write-Host "  2. Run 'claude' to start Claude Code"
Write-Host "  3. Use '/review' to test your new command"
Write-Host "  4. Check docs/ folder for guides`n"

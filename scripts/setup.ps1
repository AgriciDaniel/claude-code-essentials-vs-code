# Dev Environment Setup Script
# Run: .\setup.ps1

Write-Host "`n====== COMPLETE DEV ENVIRONMENT SETUP ======" -ForegroundColor Cyan
Write-Host "This script will install VS Code extensions, Claude Code, and set up directories.`n"

# ===== VS CODE EXTENSIONS =====
Write-Host "[1/4] Installing VS Code Extensions..." -ForegroundColor Yellow

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
Write-Host "`n[2/4] Installing/Updating Claude Code..." -ForegroundColor Yellow
npm install -g @anthropic-ai/claude-code 2>$null
$claudeVersion = claude --version 2>$null
Write-Host "  [OK] Claude Code: $claudeVersion" -ForegroundColor Green

# ===== CLAUDE CODE DIRECTORIES =====
Write-Host "`n[3/4] Setting up Claude Code directories..." -ForegroundColor Yellow

$dirs = @(
    "$HOME\.claude\commands",
    "$HOME\.claude\skills",
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

# ===== VERIFICATION =====
Write-Host "`n[4/4] Verification..." -ForegroundColor Yellow

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
Write-Host "`nNext steps:" -ForegroundColor White
Write-Host "  1. Restart your terminal to refresh PATH"
Write-Host "  2. Run 'claude' to start Claude Code"
Write-Host "  3. Add custom commands to: $HOME\.claude\commands\"
Write-Host "  4. Check docs/ folder for guides`n"

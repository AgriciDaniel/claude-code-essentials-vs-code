# VS Code Extensions Installer
# Run: .\install-extensions.ps1

Write-Host "`n====== VS CODE EXTENSIONS INSTALLER ======" -ForegroundColor Cyan

$extensions = @(
    # Core
    "ms-python.python",
    "dbaeumer.vscode-eslint",
    "esbenp.prettier-vscode",
    "ms-vscode.vscode-typescript-next",
    
    # Web Development
    "bradlc.vscode-tailwindcss",
    "prisma.prisma",
    "formulahendry.auto-rename-tag",
    "christian-kohler.path-intellisense",
    "ritwickdey.LiveServer",
    
    # Git
    "eamodio.gitlens",
    "mhutchie.git-graph",
    
    # AI (All 3 recommended!)
    "anthropic.claude-code",
    "github.copilot",
    "saoudrizwan.claude-dev",
    
    # Containers & Remote
    "ms-azuretools.vscode-docker",
    "ms-vscode-remote.remote-wsl",
    "ms-vscode-remote.remote-ssh",
    
    # Data
    "ms-toolsai.jupyter",
    
    # API Testing
    "rangav.vscode-thunder-client",
    
    # Productivity
    "usernamehw.errorlens",
    "PKief.material-icon-theme",
    "aaron-bond.better-comments",
    "streetsidesoftware.code-spell-checker",
    "alefragnani.Bookmarks",
    "wix.vscode-import-cost",
    "formulahendry.code-runner"
)

$total = $extensions.Count
$current = 0

foreach ($ext in $extensions) {
    $current++
    Write-Host "[$current/$total] Installing $ext..." -ForegroundColor Yellow
    code --install-extension $ext --force 2>$null
}

Write-Host "`n[OK] $total extensions installed!" -ForegroundColor Green
Write-Host "Total extensions now: $((code --list-extensions).Count)`n"

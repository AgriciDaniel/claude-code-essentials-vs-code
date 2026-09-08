#Requires -Version 5.1
[CmdletBinding()]
param(
    [switch]$Apply,
    [switch]$InstallClaude,
    [ValidatePattern('^(stable|latest|[0-9]+\.[0-9]+\.[0-9]+)$')]
    [string]$ClaudeVersion = 'stable',
    [string[]]$Extensions = @(),
    [string]$CodeCommand = 'code',
    [string]$CodeUserDataDir,
    [string]$CodeExtensionsDir
)

function Invoke-Checked {
    param([string]$Command, [string[]]$Arguments)
    $global:LASTEXITCODE = 0
    $result = & $Command @Arguments
    if ($LASTEXITCODE -ne 0) { throw "$Command failed (exit $LASTEXITCODE). Earlier steps remain installed; review output before retrying." }
    return $result
}
function Find-Claude {
    $command = Get-Command claude -ErrorAction SilentlyContinue
    if ($command) {
        if ($command.Source) { return $command.Source }
        return $command.Name
    }
    $native = Join-Path ([Environment]::GetFolderPath('UserProfile')) '.local\bin\claude.exe'
    if (Test-Path -LiteralPath $native -PathType Leaf) { return $native }
    return $null
}
function Install-NativeClaude {
    param([string]$Version)
    $tempDir = Join-Path ([IO.Path]::GetTempPath()) ('claude-setup-' + [guid]::NewGuid())
    New-Item -ItemType Directory -Path $tempDir -ErrorAction Stop | Out-Null
    $installer = Join-Path $tempDir 'install.ps1'
    try {
        Invoke-WebRequest -UseBasicParsing -Uri 'https://claude.ai/install.ps1' -OutFile $installer -ErrorAction Stop
        if ((Get-Item -LiteralPath $installer).Length -eq 0) { throw 'Installer download is empty.' }
        $hasher = [Security.Cryptography.SHA256]::Create()
        try { $hash = [BitConverter]::ToString($hasher.ComputeHash([IO.File]::ReadAllBytes($installer))).Replace('-', '') }
        finally { $hasher.Dispose() }
        Write-Host "Downloaded vendor installer SHA256: $hash"
        $shell = (Get-Process -Id $PID).Path
        Invoke-Checked $shell @('-NoProfile', '-File', $installer, $Version) | Out-Host
    } finally {
        if (Test-Path -LiteralPath $installer) { Remove-Item -LiteralPath $installer -ErrorAction Stop }
        Remove-Item -LiteralPath $tempDir -ErrorAction Stop
    }
}
function Invoke-Setup {
    param([switch]$Apply, [switch]$InstallClaude, [string]$ClaudeVersion = 'stable',
          [string[]]$Extensions = @(), [string]$CodeCommand = 'code',
          [string]$CodeUserDataDir, [string]$CodeExtensionsDir)
    $ErrorActionPreference = 'Stop'
    if ([Environment]::OSVersion.Platform -ne [PlatformID]::Win32NT) { throw 'Use scripts/setup.sh on macOS, Linux or WSL.' }
    if ([bool]$CodeUserDataDir -ne [bool]$CodeExtensionsDir) { throw 'Specify both CodeUserDataDir and CodeExtensionsDir for an isolated VS Code target.' }
    $codeArgs = @()
    $codeTarget = 'the default profile'
    if ($CodeUserDataDir) { $codeArgs = @('--user-data-dir', $CodeUserDataDir, '--extensions-dir', $CodeExtensionsDir) }
    if ($CodeUserDataDir) { $codeTarget = 'the explicit storage directories shown below' }
    if ($ClaudeVersion -notmatch '^(stable|latest|[0-9]+\.[0-9]+\.[0-9]+)$') { throw 'Invalid Claude version.' }
    $selected = @($Extensions | ForEach-Object {
        if ($_ -notmatch '^[a-zA-Z0-9][a-zA-Z0-9-]*\.[a-zA-Z0-9][a-zA-Z0-9-]*$') {
            throw "Invalid extension ID: $_. Use publisher.extension (no flags, paths, URLs or versions)."
        }
        $_.ToLowerInvariant()
    } | Select-Object -Unique)
    if (-not $InstallClaude -and $selected.Count -eq 0) { Write-Host 'No components selected. Use -InstallClaude and/or -Extensions publisher.extension.' }
    if ($InstallClaude) { Write-Host "PLAN: native Claude ($ClaudeVersion) if absent; execute https://claude.ai/install.ps1 as this user. Vendor auto-updates apply." }
    foreach ($id in $selected) { Write-Host "PLAN: missing VS Code extension $id in $codeTarget. Dependencies may also install; review publisher and permissions." }
    if ($CodeUserDataDir) { Write-Host "VS Code override: user data=$CodeUserDataDir; extensions=$CodeExtensionsDir" }
    if (-not $Apply) { Write-Host 'Preview only. No commands, downloads or profile writes. Add -Apply to execute choices.'; return }
    $installed = @()
    if ($selected.Count -gt 0) {
        if (-not (Get-Command $CodeCommand -ErrorAction SilentlyContinue)) { throw 'VS Code CLI missing. See docs/dev-setup-guide.md; reopen terminal after fixing PATH.' }
        $installed = @(Invoke-Checked $CodeCommand ($codeArgs + @('--list-extensions')) | ForEach-Object { $_.Trim().ToLowerInvariant() })
    }
    if ($InstallClaude) {
        $claude = Find-Claude
        $alreadyPresent = [bool]$claude
        if ($claude) { Write-Host "SKIP: existing Claude at $claude; version/channel unchanged." }
        else {
            Install-NativeClaude $ClaudeVersion
            $claude = Find-Claude
            if (-not $claude) { throw 'Installer returned success but Claude not found on PATH or in ~/.local/bin; unverified.' }
        }
        $version = @(Invoke-Checked $claude @('--version')) -join [Environment]::NewLine
        if ($version -notmatch '\d+\.\d+\.\d+') { throw 'Claude returned no recognizable version; unverified.' }
        if (-not $alreadyPresent -and $ClaudeVersion -match '^\d+\.\d+\.\d+$') {
            $reported = [regex]::Match($version, '\d+\.\d+\.\d+').Value
            if ($reported -ne $ClaudeVersion) { throw "Requested Claude $ClaudeVersion but found $reported; verification failed." }
        }
        Write-Host "VERIFIED executable: $version (authentication not checked)."
    }
    foreach ($id in $selected) {
        if ($installed -contains $id) { Write-Host "SKIP: $id already installed; no force/update."; continue }
        Invoke-Checked $CodeCommand ($codeArgs + @('--install-extension', $id)) | Out-Host
        $after = @(Invoke-Checked $CodeCommand ($codeArgs + @('--list-extensions')) | ForEach-Object { $_.Trim().ToLowerInvariant() })
        if ($after -notcontains $id) { throw "$id absent after installation; verification failed." }
        Write-Host "VERIFIED extension: $id"
    }
    Write-Host 'Selected steps finished. Authentication, MCP, templates, permissions and editor settings were not configured.'
}
if ($MyInvocation.InvocationName -ne '.') {
    try { Invoke-Setup @PSBoundParameters } catch { Write-Error $_ -ErrorAction Continue; exit 1 }
}

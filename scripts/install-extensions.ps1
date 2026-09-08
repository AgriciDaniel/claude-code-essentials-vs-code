#Requires -Version 5.1
[CmdletBinding()]
param([switch]$Apply, [string[]]$Extensions = @(), [string]$CodeCommand = 'code', [string]$CodeUserDataDir, [string]$CodeExtensionsDir)
$global:LASTEXITCODE = 0
& "$PSScriptRoot\setup.ps1" @PSBoundParameters
if (-not $?) { exit 1 }
if ($LASTEXITCODE) { exit $LASTEXITCODE }

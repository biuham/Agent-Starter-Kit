# Install only into unused destinations; never merge or overwrite project rules.
param(
    [string]$TargetDir = (Get-Location).Path
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'kit-safety.ps1')
$TargetDir = [IO.Path]::GetFullPath($TargetDir)
if (-not (Test-Path -LiteralPath $TargetDir -PathType Container)) {
    throw 'TargetDir must be an existing project directory.'
}
$paths = @('AGENTS.md', '.agents', 'docs/agents', 'skills-lock.json', 'setup.ps1', 'update-skills.ps1', 'kit-safety.ps1')
# Keep kit notices without colliding with the target project's own LICENSE.
$notices = @('LICENSE', 'THIRD-PARTY.md')
# Validate the complete batch before writing anything.
foreach ($path in $paths) {
    $source = Join-Path $PSScriptRoot $path
    $target = Join-Path $TargetDir $path
    if (-not (Test-Path -LiteralPath $source)) { throw "Missing kit file: $source" }
    Assert-KitPlainPath $source -Recurse
    Assert-KitPlainPath $target
    if (Test-Path -LiteralPath $target) { throw "Destination already exists; review and merge manually: $target" }
}
foreach ($notice in $notices) {
    $source = Join-Path $PSScriptRoot $notice
    # Installed copies store notices here instead of at the project root.
    if (-not (Test-Path -LiteralPath $source)) { $source = Join-Path $PSScriptRoot "docs/agents/kit/$notice" }
    if (-not (Test-Path -LiteralPath $source -PathType Leaf)) { throw "Missing kit notice: $notice" }
    Assert-KitPlainPath $source
}
foreach ($path in $paths) {
    $target = Join-Path $TargetDir $path
    $parent = Split-Path -Parent $target
    if (-not (Test-Path -LiteralPath $parent)) {
        New-Item -ItemType Directory -Path $parent | Out-Null
    }
    Copy-Item -LiteralPath (Join-Path $PSScriptRoot $path) -Destination $target -Recurse
}
$noticeDir = Join-Path $TargetDir 'docs/agents/kit'
if (-not (Test-Path -LiteralPath $noticeDir)) { New-Item -ItemType Directory -Path $noticeDir | Out-Null }
foreach ($notice in $notices) {
    $source = Join-Path $PSScriptRoot $notice
    if (-not (Test-Path -LiteralPath $source)) { $source = Join-Path $PSScriptRoot "docs/agents/kit/$notice" }
    if (-not (Test-Path -LiteralPath (Join-Path $noticeDir $notice))) {
        Copy-Item -LiteralPath $source -Destination $noticeDir
    }
}
$count = @(Get-ChildItem -LiteralPath (Join-Path $TargetDir '.agents/skills') -Directory |
    Where-Object { Test-Path -LiteralPath (Join-Path $_.FullName 'SKILL.md') }).Count
Write-Host "Copied kit files and $count skills to $TargetDir. Customize AGENTS.md and verify discovery in your agent."

# Default: local inventory only. -Apply explicitly permits upstream replacement.
param([switch]$Apply)
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'kit-safety.ps1')
$projectRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
Assert-KitPlainPath $projectRoot
foreach ($path in @('.agents', 'skills-lock.json')) {
    Assert-KitPlainPath (Join-Path $projectRoot $path) -Recurse
}
# Only the backup destination matters; unrelated scratch fixtures may contain links.
Assert-KitPlainPath (Join-Path $projectRoot '.scratch')
$lockPath = Join-Path $projectRoot 'skills-lock.json'
$lock = Get-Content -LiteralPath $lockPath -Raw -Encoding UTF8 | ConvertFrom-Json
if ($lock.version -notin @(1, 2) -or -not $lock.skills) { throw 'Unsupported or empty skills-lock.json.' }
$installed = @(Get-ChildItem -LiteralPath (Join-Path $projectRoot '.agents/skills') -Directory |
    Where-Object { Test-Path -LiteralPath (Join-Path $_.FullName 'SKILL.md') } | Select-Object -ExpandProperty Name)
$tracked = @($lock.skills.PSObject.Properties.Name)
$untracked = @($installed | Where-Object { $tracked -notcontains $_ })
$missing = @($tracked | Where-Object { $installed -notcontains $_ })
$legacy = @($lock.skills.PSObject.Properties | Where-Object { -not $_.Value.skillPath } | Select-Object -ExpandProperty Name)
Write-Host "Installed: $($installed.Count); lock entries: $($tracked.Count)."
Write-Host "Not tracked (manual review): $($untracked -join ', ')"
Write-Host "Tracked but missing: $($missing -join ', ')"
Write-Host "Without skillPath (CLI may skip): $($legacy -join ', ')"
if (-not $Apply) { Write-Host 'No changes made. Use -Apply only after reviewing local customizations.'; return }
if ($missing.Count) { throw 'Resolve missing tracked skills before updating.' }
$npx = Get-Command npx.cmd -ErrorAction SilentlyContinue
if (-not $npx) { $npx = Get-Command npx -ErrorAction Stop }
$backup = Join-Path $projectRoot ('.scratch/skills-backup-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $backup | Out-Null
Copy-Item -LiteralPath (Join-Path $projectRoot '.agents') -Destination $backup -Recurse
Copy-Item -LiteralPath $lockPath -Destination $backup
Write-Host "Backup: $backup. Restore manually if needed; update is not transactional."
Push-Location -LiteralPath $projectRoot
try {
    & $npx skills update --project
    if ($LASTEXITCODE -ne 0) { throw "skills CLI failed (exit $LASTEXITCODE). Backup: $backup" }
    Write-Host 'Project update command finished. Review CLI warnings and git diff; this does not certify all skills were updated.'
} finally { Pop-Location }

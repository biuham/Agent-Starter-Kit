$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$sandbox = Join-Path $root ('.scratch/script-tests-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $sandbox | Out-Null
function Assert($Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}
function Expect-Failure([scriptblock]$Action, [string]$Pattern) {
    $caught = $null
    try { & $Action } catch { $caught = $_.Exception.Message }
    Assert ($caught -and $caught -like $Pattern) "Expected failure: $Pattern; got: $caught"
}
# Parse scripts without executing external commands.
foreach ($file in @('setup.ps1', 'update-skills.ps1', 'kit-safety.ps1', 'tests/scripts.ps1')) {
    $tokens = $null
    $errors = $null
    [void][Management.Automation.Language.Parser]::ParseFile((Join-Path $root $file), [ref]$tokens, [ref]$errors)
    Assert ($errors.Count -eq 0) "Parse failed: $file"
}
$project = Join-Path $sandbox 'new-project'
New-Item -ItemType Directory -Path $project | Out-Null
& (Join-Path $root 'setup.ps1') -TargetDir $project
Assert (Test-Path -LiteralPath (Join-Path $project '.agents/skills/ponytail/SKILL.md')) 'Skill was not copied.'
Assert (Test-Path -LiteralPath (Join-Path $project 'update-skills.ps1')) 'Updater was not copied.'
Assert (Test-Path -LiteralPath (Join-Path $project 'docs/agents/kit/LICENSE')) 'Kit license was not copied.'
$before = (Get-FileHash -LiteralPath (Join-Path $project 'AGENTS.md')).Hash
Expect-Failure { & (Join-Path $root 'setup.ps1') -TargetDir $project } '*already exists*'
Assert ((Get-FileHash -LiteralPath (Join-Path $project 'AGENTS.md')).Hash -eq $before) 'Existing rules changed.'

$conflict = Join-Path $sandbox 'late-conflict'
New-Item -ItemType Directory -Path $conflict | Out-Null
Set-Content -LiteralPath (Join-Path $conflict 'skills-lock.json') -Value 'keep me'
Expect-Failure { & (Join-Path $root 'setup.ps1') -TargetDir $conflict } '*already exists*'
Assert (-not (Test-Path -LiteralPath (Join-Path $conflict 'AGENTS.md'))) 'Preflight wrote partial files.'

# A project reached via a junction must not modify its real destination.
$linked = Join-Path $sandbox 'linked-project'
New-Item -ItemType Junction -Path $linked -Target $conflict | Out-Null
Expect-Failure { & (Join-Path $root 'setup.ps1') -TargetDir $linked } '*Linked path*'
Assert (-not (Test-Path -LiteralPath (Join-Path $conflict 'AGENTS.md'))) 'Junction target changed.'

$updater = Join-Path $project 'update-skills.ps1'
$global:kitTestNpxCalled = $false
function global:npx.cmd {
    $global:kitTestNpxCalled = $true
    Assert ((Get-Location).Path -eq $project) 'Updater ran in caller directory.'
    Assert (($args -join ' ') -eq 'skills update --project') 'Wrong update scope.'
    $global:LASTEXITCODE = 7
}
try {
    & $updater
    Assert (-not $global:kitTestNpxCalled) 'Default inventory called npx.'
    Assert (-not (Test-Path -LiteralPath (Join-Path $project '.scratch'))) 'Inventory wrote a backup.'
    $caller = (Get-Location).Path
    Expect-Failure { & $updater -Apply } '*exit 7*'
    Assert $global:kitTestNpxCalled 'Apply did not call npx.'
    Assert ((Get-Location).Path -eq $caller) 'Caller directory was not restored.'
    $backup = @(Get-ChildItem -LiteralPath (Join-Path $project '.scratch') -Directory)[0].FullName
    Assert (Test-Path -LiteralPath (Join-Path $backup '.agents/skills/ponytail/SKILL.md')) 'Backup is incomplete.'
    Assert (Test-Path -LiteralPath (Join-Path $backup 'skills-lock.json')) 'Backup lacks lockfile.'
    New-Item -ItemType Junction -Path (Join-Path $project '.scratch/unrelated-fixture') -Target $conflict | Out-Null
    function global:npx.cmd { $global:LASTEXITCODE = 0 }
    & $updater -Apply
} finally {
    Remove-Item Function:\npx.cmd
    Remove-Variable kitTestNpxCalled -Scope Global
}

$linkedUpdater = Join-Path $sandbox 'linked-updater'
New-Item -ItemType Directory -Path $linkedUpdater | Out-Null
foreach ($file in @('update-skills.ps1', 'kit-safety.ps1', 'skills-lock.json')) {
    Copy-Item -LiteralPath (Join-Path $root $file) -Destination $linkedUpdater
}
New-Item -ItemType Junction -Path (Join-Path $linkedUpdater '.agents') -Target (Join-Path $project '.agents') | Out-Null
Expect-Failure { & (Join-Path $linkedUpdater 'update-skills.ps1') } '*Linked path*'
Write-Host "PASS: parse, install, conflicts, junctions, inventory, scoped updater, backup and exit handling. Fixtures: $sandbox"

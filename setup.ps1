# Script nạp nhanh Agent Kit vào dự án bất kỳ (PowerShell)
# Cách dùng: Chạy script này từ thư mục gốc của dự án mục tiêu
param(
    [string]$TargetDir = (Get-Location).Path
)

$SourceDir = $PSScriptRoot

Write-Host ">>> Đang nạp Agent Kit vào: $TargetDir" -ForegroundColor Cyan

# 1. Sao chép AGENTS.md
Copy-Item -Path (Join-Path $SourceDir "AGENTS.md") -Destination (Join-Path $TargetDir "AGENTS.md") -Force
Write-Host "[+] Đã nạp AGENTS.md (Quy tắc mẹ thực chiến)" -ForegroundColor Green

# 2. Sao chép .agents (rules, skills, workflows)
Copy-Item -Path (Join-Path $SourceDir ".agents") -Destination $TargetDir -Recurse -Force
Write-Host "[+] Đã nạp .agents/ (Rules, Workflows & 63 Skills cốt lõi)" -ForegroundColor Green

# 3. Sao chép docs/agents
if (-not (Test-Path (Join-Path $TargetDir "docs"))) {
    New-Item -ItemType Directory -Path (Join-Path $TargetDir "docs") -Force | Out-Null
}
Copy-Item -Path (Join-Path $SourceDir "docs\agents") -Destination (Join-Path $TargetDir "docs\agents") -Recurse -Force
Write-Host "[+] Đã nạp docs/agents/ (Hướng dẫn domain & issue-tracker)" -ForegroundColor Green

# 4. Sao chép skills-lock.json
Copy-Item -Path (Join-Path $SourceDir "skills-lock.json") -Destination (Join-Path $TargetDir "skills-lock.json") -Force
Write-Host "[+] Đã nạp skills-lock.json" -ForegroundColor Green

Write-Host "`n>>> Hoàn tất! Dự án của bạn đã sẵn sàng cho AI Agent (OpenCode, Antigravity, Claude, ChatGPT)." -ForegroundColor Green

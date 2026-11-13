# Script cập nhật toàn bộ Skills lên phiên bản mới nhất từ các tác giả gốc
Write-Host ">>> Đang kết nối lên GitHub của các tác giả để cập nhật skills..." -ForegroundColor Cyan

if (Get-Command npx -ErrorAction SilentlyContinue) {
    npx skills update
    Write-Host "`n>>> Đã cập nhật xong toàn bộ skills!" -ForegroundColor Green
} else {
    Write-Host "[!] Không tìm thấy Node.js / npx trên hệ thống. Vui lòng cài đặt Node.js để cập nhật skills." -ForegroundColor Red
}

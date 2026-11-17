# Kiểm chứng theo thay đổi

Áp dụng các mục khớp stack và rủi ro; project nhận kit điều chỉnh lệnh theo cấu trúc test thực tế.

- **Script kit:** sửa `setup.ps1`, `update-skills.ps1`, `kit-safety.ps1` hoặc test của kit thì chạy `powershell -NoProfile -File .\tests\scripts.ps1` tại root starter kit. Installer không copy `tests/` sang project nhận kit.
- **PHP:** chạy `php -l <file>` cho file thay đổi.
- **JavaScript:** chạy `node -c <file>`. JavaScript nhúng trong PHP phải kiểm tra riêng qua nội dung render hoặc trình duyệt; PHP lint không kiểm tra JavaScript.
- **Flutter/Dart:** chạy `flutter analyze` và test liên quan khi thay đổi hành vi.
- **CSS:** kiểm tra cú pháp bằng công cụ sẵn có và xem bản render; cân bằng ngoặc không thay thế kiểm tra giao diện.
- **UI:** kiểm tra luồng thao tác, trạng thái lỗi/loading, kích thước màn hình liên quan và bàn phím/focus cho thành phần tương tác. Dùng dữ liệu giả hoặc đã che thông tin khi chụp ảnh.
- **Logic và bug:** kiểm tra hành vi theo cơ chế test hiện có, tránh test chỉ sao chép implementation.
- **Auth, dữ liệu nhạy cảm, tác vụ định kỳ, thao tác xóa:** kiểm tra thành công, thất bại và ranh giới quyền/dữ liệu bị ảnh hưởng; không thử phá hủy dữ liệu thật khi chưa được phép.

Phân biệt lỗi mới với lỗi tồn tại trước. Không suy từ lint thành tính năng đúng, benchmark local thành hiệu năng production hoặc tự tuyên bố tuân thủ WCAG đầy đủ.

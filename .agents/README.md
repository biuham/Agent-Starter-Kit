# Quy tắc và skill dùng chung

## Phạm vi

- `AGENTS.md`: quy trình, kiểm chứng, bảo mật và nghiệp vụ của dự án hiện tại.
- `.agents/rules/`: Ponytail chọn giải pháp tối giản, Graphify điều hướng mã nguồn. Phạm vi, xử lý yêu cầu chưa rõ và kiểm chứng nằm trong `AGENTS.md`; không cần thêm rule Karpathy trùng nội dung.
- `.agents/skills`: junction tới `C:\xampp\htdocs\fls_thong_nhat\.agents\skills`. Đây là thư viện dùng chung, không phải bản riêng của CareBVTN.
- `.gemini/antigravity/skills`: nguồn bổ sung hiện có. Với tên trùng, ưu tiên bản chung khi có thể chọn đường dẫn; không nạp cả hai. Chưa xác minh thứ tự khám phá của từng harness nên giữ nguyên bản phụ, không xóa hay thay cấu hình suy đoán.
- Skill toàn cục cũng có thể xuất hiện trong catalog. Graphify hiện có tại `C:\Users\LENOVO\.agents\skills\graphify`; không phải thành phần được mang theo chỉ bằng junction dự án.

## Dùng cho dự án mới

1. Đọc hướng dẫn tại `C:\xampp\htdocs\fls_thong_nhat\.agents\README.md` và xác minh đích thư viện còn tồn tại.
2. Liên kết `.agents/skills` tới cùng thư viện khi thư mục đích trong dự án mới chưa tồn tại. Giữ nguyên thư mục có sẵn; kiểm tra trước khi hợp nhất.
3. Tái sử dụng rule bổ trợ, nhưng viết `AGENTS.md` theo stack, lệnh kiểm tra và rủi ro thực tế của dự án mới; không sao chép nghiệp vụ y tế sang dự án khác.
4. Mở phiên mới và kiểm tra catalog thực tế. Danh sách skill của phiên đang chạy có thể chưa phản ánh metadata vừa sửa.

Trigger là chỉ dẫn lựa chọn skill của model, không phải bảo đảm thực thi. Chỉ nạp skill khớp nhiệm vụ; kiểm tra hành vi trên harness sử dụng trước khi khẳng định trigger hoạt động.

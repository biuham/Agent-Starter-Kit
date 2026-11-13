# Nội dung bên thứ ba

Giấy phép MIT tại root chỉ áp dụng phần tự viết của kit, không thay thế điều khoản của skill/tài nguyên được mang theo.

## Bằng chứng hiện có

- `skills-lock.json` ghi nguồn của 18 mục (Matt Pocock, Anthropic, Addy Osmani và wshobson); đây không phải danh mục xuất xứ đầy đủ cho 63 skill.
- `.agents/skills/frontend-design/LICENSE.txt` và `.agents/skills/webapp-testing/LICENSE.txt` chứa thông báo giấy phép riêng, cần giữ cùng nội dung khi phân phối.
- Một số skill có metadata/tham chiếu nguồn trong `SKILL.md`; đọc cả tài nguyên đi kèm, không chỉ file hướng dẫn chính.

## Trước khi phân phối hoặc cập nhật

1. Xác minh repo tác giả, đường dẫn skill, phiên bản và giấy phép của từng thành phần được sử dụng; không suy nguồn chỉ từ tên giống nhau.
2. Giữ copyright, license, NOTICE và các hạn chế áp dụng cho tài nguyên phụ.
3. Đối chiếu bản vendored với upstream trước khi ghi nguồn/hash mới vào lockfile. Hash hiện có không tự chứng minh quyền phân phối.

Chưa audit đầy đủ nguồn/giấy phép của 63 skill. Không khẳng định toàn bộ thư viện được phép cấp lại theo MIT hay đã sẵn sàng cho mọi mục đích thương mại. Tài liệu này ghi rõ giới hạn, không phải kết luận pháp lý.

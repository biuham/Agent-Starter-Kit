# Quy tắc và skill dùng lại

- `AGENTS.md` ở root: workflow, kiểm chứng và bảo mật; điều chỉnh theo project hiện tại.
- `rules/`: Ponytail và Graphify bổ trợ. Metadata `always_on` chỉ có tác dụng nếu harness hỗ trợ; `AGENTS.md` vẫn chứa quy trình cốt lõi.
- `skills/`: các thư mục thật được mang theo repo. Cài bằng `setup.ps1` tạo bản riêng trong project, không liên kết tới một đường dẫn cá nhân.

## Chọn và dùng skill

Chỉ nạp skill phù hợp nhiệm vụ. Với skill trùng tên ở nhiều nguồn, dùng bản project nếu harness cho chọn đường dẫn; không nạp hai bản và không suy đoán thứ tự ưu tiên. Sau khi cài/sửa metadata, mở phiên mới rồi kiểm tra catalog thực tế. Trigger là hướng dẫn lựa chọn, không bảo đảm hành vi.

Nếu chủ động chuyển sang junction/thư viện chung, ghi rõ đích tại tài liệu project: sửa qua liên kết ảnh hưởng mọi project dùng thư viện. Installer/updater của kit từ chối đường dẫn liên kết để tránh sửa nhầm nguồn chung.

## Bảo trì

Chạy `update-skills.ps1` ở root để kiểm kê local; xem README root trước khi dùng `-Apply`. Lockfile hiện chưa bao phủ đủ thư viện. Giữ chỉnh sửa riêng, kiểm tra nguồn và giấy phép trước khi thay skill; không sửa nội dung bên thứ ba hàng loạt chỉ để đồng bộ phong cách tài liệu.

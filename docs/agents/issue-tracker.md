# Quy ước Theo dõi Tác vụ: Local Markdown

> [!IMPORTANT]
> **Chính sách Không thủ tục rườm rà (No Bureaucracy Policy)**:
> Đối với các tác vụ thông thường (sửa lỗi, tinh chỉnh UI/CSS, viết hàm, refactor nhỏ): **CODE TRỰC TIẾP VÀO FILE NGUỒN**, không tạo file spec hay ticket markdown.
> Quy ước dưới đây **chỉ áp dụng** khi người dùng gõ lệnh `/plan`, `/track` hoặc khi xây dựng một phân hệ/epic kiến trúc lớn cần phân rã nhiều công đoạn.

---

## 1. Cấu trúc thư mục (Chỉ dùng cho Epic lớn)

Khi triển khai tính năng lớn, lưu vết tại thư mục `.scratch/`:
- **Thư mục tính năng**: `.scratch/<feature-slug>/`
- **Tài liệu đặc tả (Spec)**: `.scratch/<feature-slug>/spec.md`
- **Danh sách đầu việc (Issues)**: Mỗi task một file tại `.scratch/<feature-slug>/issues/<NN>-<slug>.md` (đánh số từ `01`, `02`...)
- **Trạng thái**: Dòng `Status:` ở đầu file (xem [`triage-labels.md`](./triage-labels.md))

---

## 2. Quy ước khi Skill gọi lệnh

- Khi một skill yêu cầu *"publish to the issue tracker"*: Tạo file mới trong `.scratch/<feature-slug>/`.
- Khi một skill yêu cầu *"fetch the relevant ticket"*: Đọc đúng file theo đường dẫn người dùng cung cấp.

---

## 3. Điều hướng công việc (Wayfinding)

Sử dụng bởi `/wayfinder` để quản lý tiến độ:
- **Bản đồ tổng thể**: `.scratch/<effort>/map.md` (ghi chú, quyết định đã chốt, vùng chưa rõ).
- **Ticket con**: `.scratch/<effort>/issues/NN-<slug>.md`. Ghi rõ `Type:` (`research`/`prototype`/`grilling`/`task`) và `Status:` (`claimed`/`resolved`).
- **Phụ thuộc**: Dòng `Blocked by: NN, NN` ở đầu file.
- **Tiến trình**: Nhận task (`Status: claimed`) -> Thực thi -> Đánh dấu hoàn tất (`Status: resolved`) và cập nhật liên kết vào `map.md`.

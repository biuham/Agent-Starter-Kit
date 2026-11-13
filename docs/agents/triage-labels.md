# Nhãn Phân loại Tác vụ (Triage Labels)

Các skill quy trình chuẩn hóa trạng thái công việc theo 5 nhãn canonical dưới đây:

| Nhãn (Canonical) | Ý nghĩa | Hành động tiếp theo |
| :--- | :--- | :--- |
| `needs-triage` | Đầu việc mới phát sinh, cần đánh giá phạm vi | Trưởng nhóm/Agent phân tích độ ưu tiên |
| `needs-info` | Thiếu thông tin hoặc yêu cầu chưa rõ ràng | Hỏi người dùng để làm rõ |
| `ready-for-agent` | Đã đủ đặc tả, sẵn sàng để Agent tự động thực thi | Agent nhận việc và bắt đầu code |
| `ready-for-human` | Đòi hỏi quyết định nghiệp vụ hoặc thao tác thủ công | Bàn giao cho người dùng xử lý |
| `wontfix` | Không thực hiện / Ngoài phạm vi dự án | Đóng tác vụ |

> [!NOTE]
> Trong chế độ lập trình 1:1 hàng ngày, việc gắn nhãn này là **hoàn toàn tự nguyện/tùy chọn**, không bắt buộc áp dụng cho các tác vụ code thông thường.

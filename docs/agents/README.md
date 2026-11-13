# Tài liệu cho agent

`AGENTS.md` ở root là nguồn workflow chung. Thư mục này cung cấp ngữ cảnh theo nhu cầu, không tự động nạp toàn bộ.

- Khi thay đổi thuật ngữ/nghiệp vụ hoặc gặp quyết định kiến trúc cũ: đọc [domain.md](domain.md).
- Khi người dùng yêu cầu `/plan`, `/track` hoặc triển khai phân hệ mới phức tạp cần chia việc: đọc [issue-tracker.md](issue-tracker.md).
- Khi dùng nhãn task: đọc [triage-labels.md](triage-labels.md).

Rules bổ trợ nằm ở `.agents/rules/`, skill ở `.agents/skills/`. Cách cài và cập nhật nằm trong README root; không giả định harness tự nạp rules hoặc toàn bộ skills vào context.

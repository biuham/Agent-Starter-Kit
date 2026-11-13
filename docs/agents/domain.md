# Hướng dẫn Ngữ cảnh Nghiệp vụ (Domain Docs)

Quy định cách thức các Agent tiếp cận và sử dụng tài liệu nghiệp vụ, thuật ngữ y tế trong dự án.

---

## 1. Nguồn tri thức nghiệp vụ bắt buộc

Trước khi tìm hiểu sâu hoặc thiết kế các module liên quan đến lâm sàng/nghiệp vụ bệnh viện:
- **`GLOSSARY.md`** tại thư mục gốc: Bảng giải nghĩa các thuật ngữ lâm sàng, tên viết tắt, mã phân hệ bệnh viện.
- **`docs/adr/`**: Các quyết định kiến trúc quan trọng (Architecture Decision Records).

> [!TIP]
> Nếu các tài liệu trên chưa có trong một phân hệ nhỏ, hãy tiếp tục công việc một cách tự nhiên; không tự ý tạo file tài liệu khi chưa có yêu cầu cụ thể.

---

## 2. Nhất quán về ngôn ngữ lâm sàng

- Luôn dùng đúng thuật ngữ y khoa được định nghĩa trong `GLOSSARY.md` (ví dụ: "Đợt khám", "Toa thuốc", "Chỉ số sinh hiệu", "Phân hệ Bác sĩ"...).
- Tuyệt đối không tự bịa ra các từ đồng nghĩa gây nhầm lẫn giữa dữ liệu bệnh án và dữ liệu hệ thống.

---

## 3. Cảnh báo xung đột kiến trúc (ADR Conflicts)

Nếu giải pháp đề xuất có điểm mâu thuẫn với một bản ghi ADR có sẵn trong `docs/adr/`, Agent bắt buộc phải nêu rõ lý do trước khi thực hiện:
> *"Lưu ý: Thay đổi này khác với quyết định trong ADR-xxxx (...), đề xuất áp dụng vì lý do..."*

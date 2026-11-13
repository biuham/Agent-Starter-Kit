# Hướng dẫn Kiến trúc Agent (Agentic Framework Documentation)

Tài liệu này giải thích cấu trúc và nguyên tắc vận hành của hệ thống AI Agent trong dự án.

---

## 1. Bản đồ cấu trúc Agentic Framework

```text
CareBVTN/
├── AGENTS.md                  # QUY TẮC TỐI THƯỢNG: Kỷ luật thực thi, Ponytail, Verification, Bảo mật
├── .agents/
│   ├── rules/                 # Các luật nền tảng nạp tự động (always_on)
│   │   ├── graphify.md        # Lối tắt Fast-path & điều hướng Knowledge Graph
│   │   ├── ponytail.md        # Thang quyết định 7 nấc, diff tối thiểu (YAGNI)
│   │   └── karpathy-guidelines.md # Kỷ luật thực thi: Think before coding, surgical changes
│   └── skills/                # 63 kỹ năng thực chiến đã tinh lọc (UI, Mobile, API, TDD, Security...)
└── docs/agents/               # Hướng dẫn quy ước quản lý ngữ cảnh
    ├── README.md              # Tài liệu này
    ├── domain.md              # Quy ước thuật ngữ lâm sàng/nghiệp vụ (GLOSSARY.md, ADR)
    ├── issue-tracker.md       # Quy ước task/spec nội bộ (chỉ kích hoạt khi /plan hoặc làm Epic)
    └── triage-labels.md       # Nhãn phân loại trạng thái công việc
```

---

## 2. Triết lý vận hành: "Code thật > Giấy tờ"

1. **Task thông thường (Sửa lỗi, chỉnh UI/CSS, thêm hàm, refactor)**:
   - **Làm trực tiếp**: Đọc file nguồn liên quan, sửa tối thiểu, tự kiểm tra cú pháp (`php -l`, `node -c`, `flutter analyze`) và báo cáo kết quả ngắn gọn (3–5 dòng).
   - **Tuyệt đối không** tạo file `spec.md`, `plan.md`, `issue.md` trong `.scratch/`.
2. **Tính năng lớn / Nghiên cứu phức tạp**:
   - Chỉ lập kế hoạch chi tiết thành file văn bản khi người dùng yêu cầu lệnh `/plan` hoặc khi xây dựng một phân hệ hoàn toàn mới.
   - Khi đó, áp dụng quy ước tại [`issue-tracker.md`](./issue-tracker.md) và [`domain.md`](./domain.md).

---

## 3. Quản lý và cập nhật Skills

- Danh mục kỹ năng được chuẩn hóa và tinh gọn tại `.agents/skills/` (giữ ngân sách token luôn nằm trong ngưỡng an toàn, không bị tràn context).
- Để đồng bộ hoặc cập nhật kỹ năng mới từ các tác giả gốc:
  ```bash
  npx skills update
  ```


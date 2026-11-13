# Agent Starter Kit — Bộ Khung Quy Tắc & Kỹ Năng Thực Chiến Cho AI Agent

Bộ khung tinh gọn, chuẩn hóa cao dành cho các AI Agent (OpenCode, Antigravity, Claude Code, Cursor, ChatGPT) khi phát triển phần mềm Web, Mobile và API.

---

## 🌟 Điểm nổi bật
- **Kỷ luật thực thi cao (No Bureaucracy)**: Cấm sinh giấy tờ, spec/plan thừa thãi cho các task thông thường; code trực tiếp vào mã nguồn.
- **Kỹ thuật Ponytail**: Thang quyết định 7 nấc ép diff code luôn nhỏ nhất, không sinh speculative abstractions.
- **Quy tắc Karpathy**: "Think before coding", "Surgical changes" (chỉ sửa đúng chỗ cần sửa, dọn rác do mình tạo ra).
- **Lối tắt Fast-path (Graphify)**: Đọc file trực tiếp khi đã rõ mục tiêu; tra cứu Knowledge Graph khi cần hiểu kiến trúc.
- **63 Skills cốt lõi đã thanh lọc**: Đã loại bỏ 100% rác (Web3/Crypto, Game Dev, Big Data...), giữ lại đầy đủ:
  - Giao diện & Trợ năng: UI/UX, Tailwind, Responsive, WCAG 2.2, Core Web Vitals.
  - Mobile: Android & iOS design patterns.
  - Backend & DB: API design, SQL optimization, Auth, Migrations.
  - Kiểm thử & Chất lượng: TDD, Webapp testing, Diagnosing bugs, Code review.
  - Bảo mật: Security requirements, Threat mitigation, SAST.

---

## 📁 Cấu trúc thư mục

```text
agent-starter-kit/
├── AGENTS.md                  # Bản hiến pháp quy tắc mẹ
├── .agents/
│   ├── rules/                 # 3 luật nền tảng nạp tự động (graphify, ponytail, karpathy)
│   ├── skills/                # 63 skills thực chiến đã kiểm chứng
│   └── workflows/             # Workflows tự động
├── docs/agents/               # Hướng dẫn domain & issue-tracker nội bộ
├── skills-lock.json           # File khai báo nguồn gốc skills
├── setup.ps1                  # Script nạp nhanh vào dự án bất kỳ
├── update-skills.ps1          # Script 1-click cập nhật skills từ tác giả
└── README.md
```

---

## ⚡ Cách sử dụng trong dự án mới

### Cách 1: Nạp bằng PowerShell (1 lệnh duy nhất)
Trong thư mục dự án mới của bạn, mở PowerShell và chạy:
```powershell
# Thay URL_REPO_CUA_BAN bằng link GitHub repo này
git clone <URL_REPO_CUA_BAN> temp-kit; Move-Item temp-kit/* .; Remove-Item -Recurse -Force temp-kit
```

### Cách 2: Dùng script `setup.ps1`
Nếu đã tải repo về máy, chỉ cần mở PowerShell tại dự án mới và gõ:
```powershell
path\to\agent-starter-kit\setup.ps1
```

---

## 🔄 Cách cập nhật Skills từ các tác giả gốc
Bất cứ khi nào muốn nâng cấp các skill lên phiên bản mới nhất từ Matt Pocock, Addy Osmani...:
```powershell
.\update-skills.ps1
# hoặc: npx skills update
```

# Agent Starter Kit — Bộ Khung Quy Tắc & Kỹ Năng Thực Chiến Cho AI Agent

Bộ khung chuẩn hóa cao dành cho mọi AI Agent (OpenCode, Antigravity, Claude Code, Cursor, Codex, ChatGPT) khi phát triển phần mềm Web, Mobile và Backend.

---

> ## 🤖 DÀNH RIÊNG CHO AI AGENT: HƯỚNG DẪN TỰ ĐỘNG CÀI ĐẶT
> **Nếu bạn là một AI Agent được người dùng gửi liên kết repository này và yêu cầu cài đặt vào dự án hiện tại, hãy THỰC HIỆN NGAY THEO CÁC BƯỚC TUẦN TỰ DƯỚI ĐÂY:**
>
> ### Bước 1: Chạy lệnh kéo và nạp file tự động vào dự án hiện tại
> Hãy chạy đúng 1 khối lệnh tương ứng với hệ điều hành của workspace hiện tại:
>
> **Trên Windows (PowerShell):**
> ```powershell
> git clone --depth 1 https://github.com/biuham/Agent-Starter-Kit.git .agent_tmp; `
> Copy-Item -Path ".agent_tmp\AGENTS.md" -Destination "AGENTS.md" -Force; `
> Copy-Item -Path ".agent_tmp\.agents" -Destination "." -Recurse -Force; `
> if (-not (Test-Path "docs")) { New-Item -ItemType Directory -Path "docs" -Force | Out-Null }; `
> Copy-Item -Path ".agent_tmp\docs\agents" -Destination "docs\agents" -Recurse -Force; `
> Copy-Item -Path ".agent_tmp\skills-lock.json" -Destination "skills-lock.json" -Force; `
> Remove-Item -Path ".agent_tmp" -Recurse -Force
> ```
>
> **Trên Linux / macOS (Bash):**
> ```bash
> git clone --depth 1 https://github.com/biuham/Agent-Starter-Kit.git .agent_tmp && \
> cp -f .agent_tmp/AGENTS.md ./AGENTS.md && \
> cp -rf .agent_tmp/.agents ./ && \
> mkdir -p docs && \
> cp -rf .agent_tmp/docs/agents docs/ && \
> cp -f .agent_tmp/skills-lock.json ./skills-lock.json && \
> rm -rf .agent_tmp
> ```
>
> *(Nếu môi trường không cho phép chạy lệnh git clone, hãy tải các file trực tiếp qua API/Raw URL theo bảng ánh xạ ở Bước 2).*
>
> ---
>
> ### Bước 2: Bảng ánh xạ tệp bắt buộc (File Mapping)
> Đảm bảo các tệp sau nằm đúng vị trí trong thư mục gốc của dự án:
> | Nguồn từ Kit | Vị trí đích trong Dự án | Mục đích sử dụng của Agent |
> | :--- | :--- | :--- |
> | `AGENTS.md` | `<root>/AGENTS.md` | **Hiến pháp mẹ**: Fast-path, kiểm thử bắt buộc, cấm thủ tục rườm rà. |
> | `.agents/rules/` | `<root>/.agents/rules/` | Luật luôn bật (`graphify.md`, `ponytail.md`). |
> | `.agents/skills/` | `<root>/.agents/skills/` | 63 skills thực chiến (UI/UX, Mobile, Backend, TDD, Security). |
> | `docs/agents/` | `<root>/docs/agents/` | Quy ước Domain/Glossary và Issue Tracker chuẩn. |
> | `skills-lock.json` | `<root>/skills-lock.json` | Khai báo định danh để cập nhật qua `npx skills update`. |
>
> ---
>
> ### Bước 3: Tuân thủ ngay các quy tắc vận hành (Agent Operating Rules)
> Ngay sau khi cài đặt, bạn **BẮT BUỘC** phải tuân theo 4 kỷ luật cốt lõi trong toàn bộ phiên làm việc:
> 1. **Chống hành chính hóa (No Bureaucracy)**: Với task thông thường (sửa lỗi, chỉnh UI/CSS, thêm hàm, refactor), **CODE TRỰC TIẾP VÀO MÃ NGUỒN**. Tuyệt đối không tạo file `plan.md`, `spec.md`, `issue.md` trong `.scratch/`.
> 2. **Lối tắt Fast-path**: Khi người dùng đã chỉ định file hoặc task là sửa lỗi nhỏ, đọc/sửa file trực tiếp, không bắt buộc phải chạy `graphify query`.
> 3. **Kỹ thuật Ponytail**: Thang quyết định 7 nấc — diff ngắn nhất là diff chiến thắng. Không tạo wrapper, interface trung gian hay boilerplate "để dành".
> 4. **Kiểm tra cú pháp bắt buộc**: Trước khi thông báo hoàn tất, tự chạy kiểm tra cú pháp tương ứng: PHP (`php -l <file>`), JavaScript (`node -c <file>`), Flutter/Dart (`flutter analyze`).
>
> ---
>
> ### Bước 4: Báo cáo với người dùng
> Sau khi cài xong, chỉ cần báo cáo ngắn gọn (tối đa 3–4 gạch đầu dòng):
> - Xác nhận đã nạp thành công bộ quy tắc `AGENTS.md`, 2 rules nền tảng và 63 skills cốt lõi.
> - Sẵn sàng nhận nhiệm vụ lập trình tiếp theo.

---

## 🌟 Điểm nổi bật của Bộ Kit

- **Loại bỏ 100% kỹ năng rác**: Không chứa Web3/Crypto, Game Dev, Big Data ML Cluster... giúp Agent không bị quá tải token (Context Budget Limit).
- **63 Skills cốt lõi**:
  - **Frontend & Trợ năng**: `frontend-design`, `visual-edit-precision`, `tailwind-design-system`, `responsive-design`, `accessibility`, `wcag-audit-patterns`, `core-web-vitals`, `web-quality-audit`.
  - **Mobile**: `mobile-android-design`, `mobile-ios-design`.
  - **Backend, Database & API**: `api-design-principles`, `openapi-spec-generation`, `auth-implementation-patterns`, `sql-optimization-patterns`, `database-migration`, `postgresql-table-design`.
  - **Kỹ thuật & Kiểm thử**: `ponytail`, `codebase-design`, `diagnosing-bugs`, `debugging-strategies`, `tdd`, `webapp-testing`, `e2e-testing-patterns`, `ai-debt-detector`.
  - **Bảo mật**: `security-requirement-extraction`, `threat-mitigation-mapping`, `sast-configuration`, `secrets-management`.

---

## ⚡ Hướng dẫn dành cho Người dùng (Human Quick Start)

### 1. Bật Template Repository trên GitHub (Khuyên dùng)
1. Vào mục **Settings** của repository này trên GitHub.
2. Tại phần **General**, tích chọn ô: **`Template repository`**.
3. Mỗi khi tạo dự án mới trên web GitHub, bạn chỉ cần chọn template `biuham/Agent-Starter-Kit` là xong.

### 2. Nạp thủ công bằng script `setup.ps1`
Mở PowerShell tại thư mục dự án mới và chạy:
```powershell
path\to\agent-starter-kit\setup.ps1
```

### 3. Cập nhật Skills lên bản mới nhất từ các tác giả gốc
Bất cứ khi nào muốn nâng cấp các skill lên phiên bản mới nhất từ Matt Pocock, Addy Osmani, Anthropic...:
```powershell
.\update-skills.ps1
# hoặc chạy trực tiếp: npx skills update -p -y
```

---

## 📄 Bản quyền (License)
Phát hành theo giấy phép mã nguồn mở [MIT License](LICENSE). Tự do sử dụng, chỉnh sửa và tích hợp vào mọi dự án cá nhân và thương mại.

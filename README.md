# Agent Starter Kit

Bộ khuôn mẫu dùng chung cho các project mới, không gắn với riêng một ứng dụng hay một cặp project. Phù hợp làm điểm khởi đầu cho Web, Mobile và Backend; mỗi project điều chỉnh stack, nghiệp vụ và lệnh kiểm tra của mình. Mục tiêu: sửa đúng phạm vi, ít thủ tục, giữ an toàn dữ liệu và kiểm chứng trước khi báo xong.

Kit tập trung ba việc: đóng gói quy tắc làm việc kiểu senior dev, giảm copy thủ công khi bắt đầu project và làm nơi bảo trì bộ hướng dẫn gốc. Các bản đã cài là snapshot độc lập: cập nhật kit không tự lan sang mọi project; hợp nhất có kiểm tra khi muốn nhận thay đổi mới.

## Dùng cho project mới trên Windows

Clone kit vào một thư mục riêng (không clone đè lên project), đọc script rồi chạy:

```powershell
git clone https://github.com/biuham/Agent-Starter-Kit.git C:\tools\agent-starter-kit
& C:\tools\agent-starter-kit\setup.ps1 -TargetDir C:\work\my-project
```

Thay đường dẫn theo máy mình. Thư mục project phải tồn tại. Script kiểm tra toàn bộ đích trước khi copy, dừng nếu gặp file/thư mục có sẵn hoặc symlink/junction trong đường dẫn được dùng; không merge, ghi đè hay xóa tự động. Lỗi I/O giữa chừng có thể để lại bản cài một phần: kiểm tra các file đã copy trước khi thử lại.

Nếu project đã có `AGENTS.md`, `.agents` hoặc các file đích khác, giữ nguyên chúng và hợp nhất thủ công sau khi xem diff. Không dùng `Copy-Item -Force` để nạp cả bộ. Linux/macOS hiện chưa có installer được kiểm thử; có thể hợp nhất thủ công với cùng nguyên tắc.

Installer copy:
- `AGENTS.md`: quy trình mặc định; chỉnh lại theo stack, lệnh test và rủi ro của project.
- `.agents/`: rules bổ trợ và các thư mục skill độc lập, không tạo junction.
- `docs/agents/`: tài liệu nghiệp vụ và quy ước task tùy chọn.
- `docs/agents/kit/`: giấy phép và ghi chú nguồn của kit, không ghi đè LICENSE của project.
- `skills-lock.json`, `setup.ps1`, `update-skills.ps1`, `kit-safety.ps1`: metadata và script để tiếp tục dùng trong project mới.

Có thể bật **Template repository** trong GitHub Settings để tạo repo mới từ kit. Với project đã có mã nguồn, dùng cách cài có kiểm tra xung đột ở trên.

## Xác minh agent đã nhận hướng dẫn

Copy thành công chỉ chứng minh file có trên đĩa. Việc đọc `AGENTS.md`, khám phá skill và hỗ trợ `trigger: always_on` phụ thuộc harness/phiên bản; không tự động áp dụng cho mọi IDE, Claude Code hay ChatGPT chỉ nhờ copy file.

1. Chỉnh `AGENTS.md` cho project; xem [tài liệu thư viện](.agents/README.md).
2. Mở phiên agent mới, kiểm tra catalog có skill cần dùng và thử một task nhỏ.
3. Nếu harness cần file cấu hình khác, cấu hình theo tài liệu chính thức của nó; giữ quy tắc project ở một nguồn, tránh sao chép nhiều bản dễ lệch.

## Cập nhật và giữ chỉnh sửa riêng

```powershell
.\update-skills.ps1          # Chỉ kiểm kê local, không gọi mạng/không sửa file
.\update-skills.ps1 -Apply   # Cho phép chạy npx skills update --project
```

Hiện thư viện có 63 skill nhưng lockfile chỉ có 18 mục; trong đó một số mục thiếu `skillPath`. Không suy diễn lockfile quản lý đủ thư viện hoặc tự bịa nguồn/hash để lấp chỗ trống. Lệnh mặc định liệt kê skill không được quản lý, mục thiếu trên đĩa và mục legacy có thể bị CLI bỏ qua.

`-Apply` yêu cầu Node.js/npx và mạng, tạo backup `.agents` cùng lockfile trong `.scratch/`, chạy CLI tại đúng thư mục project và báo lỗi khi exit code khác 0. Upstream có thể thay thế các chỉnh sửa riêng; backup không phải rollback tự động. Xem cảnh báo CLI và `git diff` sau khi chạy, không coi exit 0 là bằng chứng tất cả skill đã được cập nhật. `npx` có thể tải/chạy phiên bản CLI mới; chỉ dùng khi tin cậy nguồn.

Không cập nhật qua junction/shared library. Nếu chủ động dùng thư viện chung, quản lý cập nhật tại repo nguồn và đánh giá ảnh hưởng các project khác. Không chạy cập nhật upstream chỉ để thử installer.

## Kiểm thử script

```powershell
powershell -NoProfile -File .\tests\scripts.ps1
```

Test dùng project giả trong `.scratch/`, không gọi npx thật. Kiểm tra cài mới, xung đột, junction và lỗi updater; không chứng minh khả năng khám phá của từng harness hay cập nhật upstream thực tế.

## Phạm vi skill và hành vi agent

- Với PHP, MySQL, Flutter, Vanilla JS và REST API, bộ hiện tại có nền tảng API/auth, SQL, UI, trợ năng và kiểm thử. Không cần thêm skill chỉ để tăng số lượng; thiếu hướng dẫn chuyên biệt PHP/MySQL/Flutter thì dùng tài liệu chính thức và quy ước project theo task thực tế. Skill PostgreSQL chỉ nạp khi dùng PostgreSQL, không áp dụng máy móc cho MySQL.
- Có nhóm nội dung chồng lấn (review, debugging, accessibility); chỉ nạp skill khớp nhiệm vụ, không chạy tất cả. 63 là số hiện tại, không phải mục tiêu cố định hay bảo đảm ngân sách context trên mọi model/harness.
- OpenCode hỗ trợ `.agents/skills` theo [tài liệu discovery](https://opencode.ai/docs/skills/). Catalog chỉ quảng bá metadata, model phải gọi công cụ để nạp nội dung; dùng Gemini qua router không tạo bảo đảm model luôn gọi đúng. Giữ trigger rõ trong `AGENTS.md`, kiểm tra tool trace trên task mẫu trước khi kết luận, không cần thêm system prompt lặp lại khi chưa thấy lỗi cụ thể.
- Task thường sửa trực tiếp; `.scratch/` vẫn dùng cho log, ảnh và script tạm. Chỉ hạn chế việc tự sinh hồ sơ kế hoạch cho task nhỏ, không cấm vùng scratch. Tài liệu nghiệp vụ cần đọc khi task liên quan, không chỉ khi làm Epic.

## Nguồn và giấy phép

[MIT License](LICENSE) áp dụng cho phần tự viết của kit. Skill, script và tài nguyên bên thứ ba giữ giấy phép/thông báo riêng; xem [THIRD-PARTY.md](THIRD-PARTY.md). Không coi giấy phép gốc của kit là quyền cấp lại cho toàn bộ nội dung vendored.

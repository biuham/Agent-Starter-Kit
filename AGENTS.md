# AGENTS.md — Quy tắc vận hành project

Áp dụng cho mọi agent trong repository. Tuân theo thứ bậc chỉ dẫn của harness; skill không cấp thêm quyền hoặc thay thế workflow project.

## 1. Workflow

- Nhận yêu cầu → nạp skill phù hợp → đọc mã và xác định phạm vi → sửa tối thiểu → kiểm chứng → báo kết quả.
- Trước khi sửa, kiểm tra Git status và diff liên quan; giữ nguyên công việc ngoài nhiệm vụ. Tự làm khi yêu cầu rõ, chỉ hỏi khi thiếu thông tin ảnh hưởng tính đúng đắn, phạm vi hoặc thao tác không thể hoàn tác.
- Task thường sửa trực tiếp, không sinh spec/ticket. Với `/plan`, `/track` hoặc phân hệ lớn cần chia việc, đọc `docs/agents/issue-tracker.md`. Chỉ dùng Conductor khi project đã dùng hoặc người dùng yêu cầu thiết lập.
- Khi sửa mô hình/thuật ngữ nghiệp vụ hoặc xử lý quyết định kiến trúc cũ, đọc `docs/agents/domain.md`.
- File tạm, log và ảnh kiểm tra đặt trong `.scratch/`; test duy trì theo cấu trúc project. Chỉ chạy lại kiểm tra khi có thay đổi, lỗi hoặc nghi vấn mới.

## 2. Nạp skill trước khi làm

Trước mỗi nhiệm vụ, bắt buộc nạp theo thứ tự **`ponytail` → `graphify` → skill liên quan trong bảng dưới**, rồi mới thực hiện. Dùng công cụ nạp skill của harness; nếu không có, đọc `.agents/skills/<tên>/SKILL.md` bằng công cụ đọc file sẵn có. Nội dung đã nạp trong ngữ cảnh thì tái sử dụng, không nạp lại; catalog không thay thế nội dung skill. Nạp Graphify không phải yêu cầu dựng đồ thị: chỉ chạy các bước phù hợp mục 3.

| Nhiệm vụ | Skill / hướng dẫn cần nạp |
|---|---|
| Thiết kế hoặc chỉnh UI / HTML / CSS | `frontend-design` |
| Sửa UI theo ảnh hoặc screenshot | `visual-edit-precision` |
| Layout đa kích thước / design tokens, typography / tương tác, chuyển động UI | Lần lượt `responsive-design` / `visual-design-foundations` / `interaction-design`, theo phần việc thực tế |
| Trợ năng / kiểm tra web bằng trình duyệt | Lần lượt `accessibility` / `webapp-testing` |
| Điều tra bug / viết test / tối ưu SQL / thiết kế API | Lần lượt `diagnosing-bugs` / `tdd` / `sql-optimization-patterns` / `api-design-principles` |
| Audit bảo mật / pen-test toàn bộ codebase | `security-audit` *(chỉ dùng khi kiểm tra bảo mật chuyên sâu)* |
| Sửa rules hoặc hướng dẫn agent | `writing-for-agents` |

Task khác: chọn theo mô tả skill khả dụng. Ưu tiên bản project nếu harness cho chọn. Nếu không nạp được Ponytail hoặc Graphify, báo thiếu và chờ xử lý trước khi sửa file; skill bổ trợ thiếu thì báo giới hạn và dùng quy tắc project. Cách dùng nhiều nguồn hoặc thư viện chung: `.agents/README.md`; xác minh đích liên kết trước khi sửa skill.

## 3. Sửa tối thiểu và điều hướng

- Chọn giải pháp nhỏ nhất giải quyết đủ yêu cầu: tái sử dụng code → stdlib/nền tảng → dependency đã cài → code mới tối thiểu. Giữ quy ước hiện có; không thêm tính năng hay abstraction để dành.
- Sửa bug phải kiểm tra caller và nguyên nhân dùng chung; giữ validation, xử lý lỗi bảo vệ dữ liệu, phân quyền và trợ năng.
- Đã rõ file/symbol: đọc trực tiếp. Cần quan hệ module: dùng `graphify query` / `graphify path`, đối chiếu mã hiện tại. Graphify thiếu/lỗi/cũ: tìm kiếm trực tiếp, không lặp lệnh lỗi.
- Sau sửa code, chạy `graphify update .` một lần; chỉ sửa tài liệu thì bỏ qua. Báo lỗi đồng bộ nếu có, không chặn công việc không liên quan.

## 4. Kiểm chứng và an toàn

- Trước khi sửa code, đọc `docs/agents/verification.md` và áp dụng các mục khớp stack/rủi ro. Logic không tầm thường hoặc sửa bug phải có kiểm tra hành vi chạy lại được; thay đổi trình bày nhỏ không cần dựng bộ test mới.
- Rà diff cuối và chạy `git diff --check`. Chỉ báo kiểm tra đã chạy; phân biệt lỗi mới với lỗi cũ, lint với kiểm chứng hành vi; nêu rõ phần chưa kiểm tra.
- Giữ bí mật credentials/token và dữ liệu cá nhân khỏi commit, log hoặc chia sẻ; ưu tiên dữ liệu giả, che thông tin nhạy cảm trong ảnh/log. Không thử thao tác phá hủy trên dữ liệu thật khi chưa được phép.
- Không reset, ghi đè công việc người khác, xóa dữ liệu, force-push hoặc bỏ hook khi chưa được cho phép rõ ràng. Skill yêu cầu bước vượt quyền thì dừng bước đó và báo lại.
- Chỉ commit/push khi người dùng yêu cầu; rà stage, không ép thêm file ignore hoặc secrets. Commit mô tả tiếng Việt; sau push kiểm tra trạng thái đồng bộ.

## 5. Giao tiếp

Tiếng Việt, đi thẳng vào kết quả; mặc định 3–5 gạch đầu dòng gồm kết quả, file, kiểm tra và giới hạn. Chỉ cập nhật giữa chừng khi có phát hiện hoặc trở ngại đáng biết. Khi sửa file, liên kết `[tên_file](file:///đường_dẫn_tuyệt_đối)`; chưa đủ kiểm chứng thì không gọi là hoàn tất.

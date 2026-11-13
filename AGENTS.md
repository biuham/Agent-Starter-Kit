# AGENTS.md — Quy tắc vận hành CareBVTN

Áp dụng cho mọi agent làm việc trong repository. Thực thi nhanh, thay đổi tối thiểu, kiểm chứng trước khi báo hoàn tất. Khi có xung đột, tuân theo thứ bậc chỉ dẫn của harness và nêu ngắn gọn xung đột ảnh hưởng đến công việc.

## 1. Quy trình thực thi

- Nhận yêu cầu → xác định phạm vi và file liên quan → sửa tối thiểu → kiểm tra → báo kết quả.
- Trước khi sửa, kiểm tra trạng thái Git và diff liên quan; giữ nguyên công việc có sẵn không thuộc nhiệm vụ.
- Task thông thường: sửa trực tiếp mã nguồn, không tạo `spec.md`, `plan.md`, `issue.md`. Chỉ lập kế hoạch thành file khi người dùng yêu cầu `/plan` hoặc triển khai module/kiến trúc mới cần phân tích phức tạp.
- Script dùng một lần, ảnh kiểm tra và log tạm đặt trong `.scratch/`; test hồi quy cần duy trì đặt theo cấu trúc test của dự án. Không xóa file có sẵn chỉ vì trông giống file tạm.
- Tự xử lý khi yêu cầu đã rõ; chỉ hỏi khi thiếu thông tin ảnh hưởng đến tính đúng đắn, phạm vi hoặc thao tác không thể hoàn tác.
- Chạy song song các kiểm tra độc lập khi phù hợp. Chỉ chạy lại kiểm tra khi có thay đổi, lỗi hoặc nghi vấn mới; không đọc lại nội dung đã đủ ngữ cảnh.

## 2. Tự động sử dụng skill

- Trước khi thực hiện, đối chiếu nhiệm vụ với mô tả skill khả dụng và nạp skill phù hợp bằng công cụ của harness; không chờ người dùng nhắc tên.
- Chỉ nạp skill cần thiết cho nhiệm vụ; không nạp hàng loạt, theo từ khóa đơn lẻ hoặc nạp lại skill đã có trong ngữ cảnh.
- Các điểm định tuyến chính khi skill khả dụng: coding/review → `ponytail`; thiết kế UI → `frontend-design`; sửa UI theo ảnh → `visual-edit-precision`; kiểm tra web bằng trình duyệt → `webapp-testing`; sửa hướng dẫn agent → `writing-for-agents`. Với nhiệm vụ khác, dựa vào mô tả thực tế của skill.
- Áp dụng hướng dẫn vào công việc, không chỉ thông báo “đã nạp skill”. Nếu skill không khả dụng, dùng quy tắc tại đây và báo giới hạn khi ảnh hưởng kết quả.
- `.agents/skills` là liên kết tới thư viện dùng chung có chủ đích; sửa qua liên kết ảnh hưởng mọi dự án sử dụng. Giữ hướng dẫn đặc thù CareBVTN tại đây, không đưa vào skill chung.
- Khi nhiều nguồn có cùng tên skill, dùng bản từ `.agents/skills` nếu harness cho phép chọn đường dẫn; nguồn phụ chỉ bổ sung tên còn thiếu. Không nạp hai bản cùng tên hoặc suy đoán thứ tự ưu tiên của harness. Xem hướng dẫn tái sử dụng tại `.agents/README.md`.

## 3. Ponytail — Kỹ thuật tối giản

- Chọn thay đổi nhỏ nhất giải quyết đầy đủ yêu cầu; ưu tiên code rõ ràng, kiểm chứng được hơn việc ép ít dòng.
- Thứ tự lựa chọn: có thực sự cần → tái sử dụng thành phần dự án → thư viện chuẩn/nền tảng → dependency đã cài → viết lượng code tối thiểu.
- Không thêm dependency, wrapper, interface, cấu hình hoặc tính năng “để dành” khi chưa có nhu cầu thực tế. Giữ cấu trúc và quy ước hiện có.
- Khi sửa lỗi, kiểm tra các caller liên quan và sửa nguyên nhân tại điểm dùng chung nếu phù hợp.
- Không cắt giảm validation, xử lý lỗi bảo vệ dữ liệu y tế, phân quyền RBAC hoặc trợ năng WCAG 2.2 để đổi lấy tốc độ.

## 4. Điều hướng mã nguồn và Graphify

- Khi đã xác định rõ file/symbol: đọc trực tiếp phần liên quan; không bắt buộc truy vấn đồ thị trước.
- Khi cần hiểu kiến trúc hoặc quan hệ module: dùng `graphify query "<câu hỏi>"` hoặc `graphify path "<A>" "<B>"`; đối chiếu kết quả với mã hiện tại.
- Sau khi hoàn tất sửa code, chạy `graphify update .` một lần. Chỉ sửa tài liệu thì không cần cập nhật AST.
- Nếu Graphify thiếu, lỗi hoặc dữ liệu cũ: dùng tìm kiếm trực tiếp để tiếp tục; báo ngắn gọn nếu chưa đồng bộ được. Không lặp lệnh vô ích.

## 5. Kiểm chứng trước khi báo hoàn tất

- PHP thay đổi: chạy `php -l <file>`; JavaScript thay đổi: chạy `node -c <file>`. JavaScript nhúng trong PHP phải được kiểm tra riêng qua nội dung render hoặc trình duyệt; PHP lint không kiểm tra JavaScript.
- Flutter/Dart thay đổi: chạy `flutter analyze` và test liên quan khi thay đổi hành vi. Phân biệt lỗi mới với lỗi tồn tại trước.
- CSS thay đổi: kiểm tra cú pháp bằng công cụ sẵn có và xem bản render; cân bằng ngoặc không thay thế kiểm tra giao diện.
- UI thay đổi: kiểm tra luồng thao tác, trạng thái lỗi/loading, kích thước màn hình liên quan và bàn phím/focus đối với thành phần tương tác. Dùng dữ liệu giả hoặc đã che thông tin khi chụp ảnh.
- Logic không tầm thường hoặc sửa lỗi: để lại một kiểm tra hành vi có thể chạy lại theo cơ chế test hiện có; tránh test chỉ sao chép implementation. Thay đổi thuần trình bày nhỏ không cần dựng bộ test mới.
- Auth, dữ liệu y tế, lịch nhắc hoặc thao tác xóa: kiểm tra cả thành công, thất bại và ranh giới quyền/dữ liệu bị ảnh hưởng. Không dùng dữ liệu thật để thử thao tác phá hủy nếu chưa được cho phép.
- Chạy `git diff --check` và rà lại diff cuối. Chỉ báo những kiểm tra đã thực sự chạy; nêu rõ phần bị chặn hoặc chưa kiểm tra. Không suy từ lint thành “tính năng đúng”, từ benchmark local thành hiệu năng production, hoặc tự tuyên bố tuân thủ WCAG đầy đủ.

## 6. Bảo mật, dữ liệu và Git

- Không commit, in log hoặc gửi ra ngoài mật khẩu CSDL, JWT/token, khóa bí mật, Firebase Service Account; đặc biệt chú ý `api/config/local.php` và `fcm_config.php`.
- Ưu tiên dữ liệu giả cho kiểm thử. Họ tên, CCCD, SĐT, bệnh án trong ảnh/video/log thử nghiệm phải được mask trước khi lưu hoặc chia sẻ; chỉ xuất kết quả tổng hợp khi đủ chứng minh.
- Không reset, ghi đè công việc người khác, xóa dữ liệu, force-push hoặc bỏ qua hook khi chưa được cho phép rõ ràng.
- Chỉ commit/push khi người dùng yêu cầu; rà nội dung stage, không ép thêm file bị ignore hoặc thông tin nhạy cảm. Sau push, kiểm tra trạng thái đồng bộ trước khi báo thành công.
- Viết nội dung mô tả commit bằng tiếng Việt; có thể giữ tiền tố kỹ thuật như `fix`, `feat`.

## 7. Giao tiếp

- Tiếng Việt, đi thẳng vào kết quả. Mặc định tối đa 3–5 gạch đầu dòng: kết quả, file thay đổi, kiểm tra, giới hạn nếu có. Giải thích dài hơn khi người dùng yêu cầu hoặc cần quyết định quan trọng.
- Chỉ cập nhật giữa chừng khi có phát hiện, lựa chọn hoặc trở ngại đáng biết; không kể từng lần đọc file/chạy lệnh.
- Không nhắc lại yêu cầu, tự khen, cam kết lặp lại hoặc liệt kê việc ngoài phạm vi không liên quan.
- Khi có sửa file, liên kết dạng `[tên_file](file:///đường_dẫn_tuyệt_đối)`. Nêu kết quả kiểm tra thực tế; nếu chưa kiểm chứng đủ thì không gọi là hoàn tất.

---
name: flutter-dart
description: Use when changing Flutter widgets, layout, navigation, state, or Dart code in a Flutter app, and when writing or debugging Flutter tests.
license: MIT
---

# Flutter và Dart

1. **Tìm đúng package.** Xác định `pubspec.yaml` của app cần sửa, phiên bản SDK mà repo dùng và test gần nhất. Đọc widget, nguồn state và caller liên quan. Giữ cách quản lý state, routing, theme và API client hiện có; dùng lại widget/service trước khi thêm dependency.
2. **Giữ đúng vòng đời.** `build()` chỉ dựng UI; khởi động tác vụ từ lifecycle hoặc thao tác phù hợp, không gọi API mỗi lần rebuild. Gỡ listener, hủy timer/subscription và giải phóng controller do widget sở hữu khi `dispose`; nếu nguồn lắng nghe đổi, gỡ đăng ký cũ trước khi gắn nguồn mới. Sau `await`, kiểm tra `mounted` trước khi dùng `State.context` hoặc gọi `setState`; với `BuildContext` nhận qua biến/tham số, kiểm tra `context.mounted` trên chính context đó. Nếu nhiều request có thể chồng nhau, bảo đảm kết quả cũ không ghi đè state mới.
3. **Kiểm tra hành vi thay đổi.** Với màn hình có gọi API, giữ phân biệt loading, rỗng và lỗi; chặn gửi lặp khi thao tác ghi đang chạy nếu có rủi ro ghi trùng. Với layout, kiểm tra khung hẹp, chữ phóng lớn và bàn phím nếu có form. Dùng unit test cho logic Dart, widget test cho thao tác và trạng thái UI; ưu tiên test hồi quy tại chỗ với dữ liệu giả thay vì gọi backend thật.
4. **Xác minh từ root của package.** Dùng SDK của repo để chạy `dart format` trên file Dart đã sửa, `flutter analyze` và `flutter test <đường-dẫn-test>` khi đổi hành vi. Với plugin hay luồng phụ thuộc hệ điều hành, kiểm tra trên thiết bị/emulator phù hợp nếu có; widget test không xác nhận luồng native. Báo rõ việc nào chưa chạy. Chỉ build release khi được yêu cầu và dùng cấu hình ký của project.

Tham chiếu: [vòng đời State](https://api.flutter.dev/flutter/widgets/State/dispose.html), [BuildContext sau async](https://dart.dev/tools/linter-rules/use_build_context_synchronously), [các mức kiểm thử Flutter](https://docs.flutter.dev/testing/overview).

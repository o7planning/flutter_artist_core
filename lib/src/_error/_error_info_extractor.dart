part of '../../flutter_artist_core.dart';

///
/// Template 1:
/// ```json
/// {
///   "code": "INVALID_INPUT",
///   "message": "The provided data is invalid.",
///   "details": [
///       {
///       "field": "email",
///       "message": "Email address is not in a valid format."
///       },
///       {
///       "field": "password",
///       "message": "Password must be at least 8 characters long."
///       }
///   ]
/// }
/// ```
///
/// Template 2:
///
/// ```json
/// {
///   "code": "INVALID_INPUT",
///   "message": "The provided data is invalid.",
///   "details": [
///      "Email address is not in a valid format.",,
///      "Password must be at least 8 characters long."
///   ]
/// }
/// ```
/// Template 3:
///
/// ```json
/// {
///   "errors": {
///     "global": ["Hệ thống đang bảo trì", "Vui lòng thử lại sau"],
///     "auth": ["Token hết hạn"]
///   }
/// }
/// ```
///
/// Template 4:
///
/// ```
/// {
///  "error": {
///     "innerError": {
///       "code": "5001",
///       "message": "Database connection failed",
///       "stackTrace": "..."
///     }
///   }
/// }
/// ```
///
/// Template 5:
///
/// ```
/// {
///   "errors": {
///     "username": ["Tên đăng nhập đã tồn tại", "Không được chứa ký tự đặc biệt"],
///     "password": ["Mật khẩu quá ngắn"]
///   }
/// }
/// ```
///
/// See documents:
///
/// https://o7planning.org/14825/flutterartist-errorinfoextractor
///
abstract class ErrorInfoExtractor {
  const ErrorInfoExtractor();

  String? extractErrorMessage({required Map<String, dynamic> errorJson});

  List<String>? extractErrorDetails({required Map<String, dynamic> errorJson});
}

part of '../../flutter_artist_core.dart';

///
/// ```json
/// {
///   "status" : 401,
///   "errorMessage" : "Some Message",
///   "errorDetails" : [ "Cause 1", "Cause 2" ]
/// }
/// ```
class ApiError extends AppError {
  ApiErrorType? errorType;
  int? statusCode;
  String? statusMessage;
  String? originErrorText;
  dynamic Function(Map<String, dynamic> value)? usedConverter;

  ApiError({
    this.statusCode,
    this.statusMessage,
    this.errorType,
    this.originErrorText,
    required super.errorMessage,
    super.errorDetails,
    this.usedConverter,
  });
}

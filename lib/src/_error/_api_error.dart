part of '../../flutter_artist_core.dart';

///
/// ```json
/// {
///   "status" : "INTERNAL_SERVER_ERROR",
///   "errorMessage" : "Some Message",
///   "errorDetails" : [ "Cause 1", "Cause 2" ]
/// }
/// ```
class ApiError extends AppError {
  ApiErrorType? apiErrorType;
  String? status;
  dynamic errorData;

  ApiError({
    this.status,
    this.apiErrorType,
    this.errorData,
    required super.errorMessage,
    super.errorDetails,
  });
}

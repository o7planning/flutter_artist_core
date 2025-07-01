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

  ApiError({
    this.status,
    this.apiErrorType,
    required super.errorMessage,
    super.errorDetails,
  });
}

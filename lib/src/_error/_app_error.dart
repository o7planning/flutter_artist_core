part of '../../flutter_artist_core.dart';

///
/// ```json
/// {
///   "errorMessage" : "Some Message",
///   "errorDetails" : [ "Cause 1", "Cause 2" ]
/// }
/// ```
class AppError {
  String errorMessage;
  List<String>? errorDetails;

  AppError({required this.errorMessage, this.errorDetails});

  factory AppError.fromError({required dynamic error}) {
    return ErrorUtils.toAppError(error);
  }

  @override
  String toString() {
    return errorMessage;
  }
}

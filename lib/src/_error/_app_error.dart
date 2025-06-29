part of '../../flutter_artist_core.dart';

///
/// ```json
/// {
///   "message" : "Some Message",
///   "errorDetails" : [ "Cause 1", "Cause 2" ]
/// }
/// ```
class AppError {
  String errorMessage;
  List<String>? errorDetails;

  AppError({required this.errorMessage, this.errorDetails});

  @override
  String toString() {
    return errorMessage;
  }
}

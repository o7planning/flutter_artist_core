part of '../../flutter_artist_core.dart';

///
/// ```json
/// {
///   "status" : "INTERNAL_SERVER_ERROR",
///   "errorMessage" : "Some Message",
///   "errorDetails" : [ "Cause 1", "Cause 2" ]
/// }
/// ```
class ApiError {
  String? status;
  String errorMessage;
  List<String>? errorDetails;

  ApiError({this.status, required this.errorMessage, this.errorDetails});

  @override
  String toString() {
    return this.errorMessage;
  }
}

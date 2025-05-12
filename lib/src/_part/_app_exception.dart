part of '../../flutter_artist_core.dart';

///
/// ```json
/// {
///   "message" : "Some Message",
///   "errorDetails" : [ "Cause 1", "Cause 2" ]
/// }
/// ```
class AppException {
  String message;
  List<String>? details;

  AppException({
    required this.message,
    this.details,
  });

  @override
  String toString() {
    return message;
  }
}

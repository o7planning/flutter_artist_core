part of '../../flutter_artist_core.dart';

class ErrorInfo {
  final String message;
  final List<String>? errorDetails;
  final StackTrace? stackTrace;

  ErrorInfo({
    required this.message,
    required this.errorDetails,
    required this.stackTrace,
  });
}

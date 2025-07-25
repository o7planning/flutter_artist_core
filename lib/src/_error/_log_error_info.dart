part of '../../flutter_artist_core.dart';

class LogErrorInfo extends ErrorInfo {
  final int id;
  final String? shelfName;
  final String? methodName;

  LogErrorInfo({
    required this.id,
    required this.shelfName,
    required this.methodName,
    required super.errorMessage,
    required super.errorDetails,
    required super.stackTrace,
  });
}

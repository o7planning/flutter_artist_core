part of '../../flutter_artist_core.dart';

class LogErrorInfo extends ErrorInfo {
  final int id;
  final String? shelfName;

  LogErrorInfo({
    required this.id,
    required this.shelfName,
    required super.errorMessage,
    required super.errorDetails,
    required super.stackTrace,
  });
}

part of '../../flutter_artist_core.dart';

class ErrorInfo {
  final String errorMessage;
  final List<String>? errorDetails;
  final StackTrace? stackTrace;

  ErrorInfo({
    required this.errorMessage,
    required this.errorDetails,
    required this.stackTrace,
  });

  factory ErrorInfo.fromError({
    required dynamic error,
    required StackTrace? stackTrace,
  }) {
    final appError = AppError.fromError(error: error);
    return ErrorInfo(
      errorMessage: appError.errorMessage,
      errorDetails: appError.errorDetails,
      stackTrace: stackTrace,
    );
  }
}

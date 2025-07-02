part of '../../flutter_artist_core.dart';

enum ApiErrorType {
  /// Caused by a connection timeout.
  connectionTimeout,

  /// It occurs when url is sent timeout.
  sendTimeout,

  /// It occurs when receiving timeout.
  receiveTimeout,

  /// Caused by an incorrect certificate as configured by [ValidateCertificate].
  badCertificate,

  /// The [Error] was caused by an incorrect status code as configured by
  /// [ValidateStatus].
  badResponse,

  /// When the request is cancelled, dio will throw a error with this type.
  cancel,

  /// Caused for example by a `xhr.onError` or SocketExceptions.
  connectionError,

  /// Default error type, Some other [Error].
  unknown,

  // Json is not valid.
  invalidJson,

  // Json Syntax.
  notJson,

  // Conversion Error.
  conversion,
}

extension ApiErrorTypeE on ApiErrorType {
  String get description {
    switch (this) {
      case ApiErrorType.connectionTimeout:
        return "Connection Timeout";
      case ApiErrorType.sendTimeout:
        return "Send Timeout";
      case ApiErrorType.receiveTimeout:
        return "Receive Timeout";
      case ApiErrorType.badCertificate:
        return "Bad Certificate";
      case ApiErrorType.badResponse:
        return "Bad Response";
      case ApiErrorType.cancel:
        return "Request Cancelled";
      case ApiErrorType.connectionError:
        return "Connection Error";
      case ApiErrorType.unknown:
        return "Unknown Error";
      case ApiErrorType.invalidJson:
        return "Invalid JSON";
      case ApiErrorType.notJson:
        return "Not JSON Error";
      case ApiErrorType.conversion:
        return "Conversion Error";
    }
  }
}

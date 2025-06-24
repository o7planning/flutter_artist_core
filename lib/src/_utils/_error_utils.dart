part of '../../flutter_artist_core.dart';

class ErrorUtils {
  static AppException toAppException(Object error) {
    if (error is AppException) {
      return error as AppException;
    } else if (error is ApiError) {
      return error.toAppException();
    } else if (error is Exception) {
      return AppException(message: error.toString());
    } else if (error is Error) {
      return AppException(message: error.toString());
    }
    return AppException(message: error.toString());
  }
}

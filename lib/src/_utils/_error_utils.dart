part of '../../flutter_artist_core.dart';

class ErrorUtils {
  AppException? toAppException(dynamic error) {
    if (error == null) {
      return null;
    }
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

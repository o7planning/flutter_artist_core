part of '../../flutter_artist_core.dart';

class ErrorUtils {
  static AppError toAppError(Object error) {
    if (error is AppError) {
      return error;
    } else if (error is Exception) {
      return AppError(errorMessage: error.toString());
    } else if (error is Error) {
      return AppError(errorMessage: error.toString());
    } else if (error is List<int>) {
      return AppError(errorMessage: "Data List<int> error");
    }
    return AppError(errorMessage: error.toString());
  }
}

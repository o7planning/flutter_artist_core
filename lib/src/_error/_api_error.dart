part of '../../flutter_artist_core.dart';

///
/// ```json
/// {
///   "status" : 401,
///   "errorMessage" : "Some Message",
///   "errorDetails" : [ "Cause 1", "Cause 2" ]
/// }
/// ```
class ApiError extends AppError {
  ApiErrorType? apiErrorType;
  int? statusCode;
  dynamic errorData;

  ApiError({
    this.statusCode,
    this.apiErrorType,
    this.errorData,
    required super.errorMessage,
    super.errorDetails,
  });

  static ApiError fromMap({
    required int? statusCode,
    required String? statusMessage,
    required Map<String, dynamic> map,
  }) {
    String errorMessage =
        map['errorMessage'] ??
        map['error'] ??
        map['message'] ??
        statusMessage ??
        "Error";
    //
    dynamic errorDetailsX = map['errors'] ?? map['errorDetails'];
    //
    List<String>? errorDetails;
    if (errorDetailsX != null) {
      if (errorDetailsX is List) {
        errorDetails =
            errorDetailsX.map((detail) => detail.toString()).toList();
      } else {
        errorDetails = [errorDetailsX.toString()];
      }
    }
    return ApiError(
      statusCode: statusCode,
      errorMessage: errorMessage,
      errorDetails: errorDetails,
    );
  }

  static ApiError fromResponseErrorData({
    required int? statusCode,
    required String? statusMessage,
    required dynamic responseErrorData,
  }) {
    if (responseErrorData == null) {
      return ApiError(
        statusCode: statusCode,
        apiErrorType: ApiErrorType.unknown,
        errorData: null,
        errorMessage: statusMessage ?? "Unknown Error",
        errorDetails: null,
      );
    }
    if (responseErrorData is String) {
      var jsonObj;
      try {
        jsonObj = jsonDecode(responseErrorData);
      } catch (e) {
        return ApiError(
          statusCode: statusCode,
          apiErrorType: ApiErrorType.unknown,
          errorData: null,
          errorMessage: statusMessage ?? "Unknown Error",
          errorDetails: null,
        );
      }
      if (jsonObj == null) {
        return ApiError(
          statusCode: statusCode,
          apiErrorType: ApiErrorType.unknown,
          errorData: null,
          errorMessage: statusMessage ?? "Unknown Error",
          errorDetails: null,
        );
      } else if (jsonObj is Map) {
        return ApiError.fromMap(
          statusCode: statusCode,
          statusMessage: statusMessage,
          map: jsonObj as Map<String, dynamic>,
        );
      } else if (jsonObj is List) {
        return ApiError(
          statusCode: statusCode,
          apiErrorType: ApiErrorType.unknown,
          errorData: null,
          errorMessage: statusMessage ?? "Unknown Error (Array)",
          errorDetails: null,
        );
      } else {
        return ApiError(
          statusCode: statusCode,
          apiErrorType: ApiErrorType.unknown,
          errorData: null,
          errorMessage: statusMessage ?? "Unknown Error",
          errorDetails: null,
        );
      }
    } else if (responseErrorData is Map) {
      return ApiError.fromMap(
        statusCode: statusCode,
        statusMessage: statusMessage,
        map: responseErrorData as Map<String, dynamic>,
      );
    } else {
      return ApiError(
        statusCode: statusCode,
        apiErrorType: ApiErrorType.unknown,
        errorData: null,
        errorMessage: statusMessage ?? "Unknown Error",
        errorDetails: null,
      );
    }
  }
}

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
  ApiErrorType? errorType;
  int? statusCode;
  String? statusMessage;
  String? originErrorText;
  dynamic Function(Map<String, dynamic> value)? usedConverter;

  ApiError({
    this.statusCode,
    this.statusMessage,
    this.errorType,
    this.originErrorText,
    required super.errorMessage,
    super.errorDetails,
    this.usedConverter,
  });

  static ApiError fromMap({
    required ApiErrorType errorType,
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
    String? originErrorText;
    try {
      originErrorText = JsonUtils.toBeautifulJson(map);
    } catch (e) {}

    return ApiError(
      statusCode: statusCode,
      errorType: errorType,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
      errorDetails: errorDetails,
      originErrorText: originErrorText,
    );
  }

  static ApiError fromResponseErrorData({
    required ApiErrorType errorType,
    required int? statusCode,
    required String? statusMessage,
    required dynamic responseErrorData,
  }) {
    if (responseErrorData == null) {
      return ApiError(
        statusCode: statusCode,
        statusMessage: statusMessage,
        errorType: errorType,
        originErrorText: null,
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
          statusMessage: statusMessage,
          errorType: errorType,
          originErrorText: responseErrorData,
          errorMessage: statusMessage ?? "Unknown Error Message (*)",
          errorDetails: null,
        );
      }
      if (jsonObj == null) {
        return ApiError(
          statusCode: statusCode,
          statusMessage: statusMessage,
          errorType: errorType,
          originErrorText: responseErrorData,
          errorMessage: statusMessage ?? "Unknown Error Message (*)",
          errorDetails: null,
        );
      } else if (jsonObj is Map) {
        return ApiError.fromMap(
          errorType: errorType,
          statusCode: statusCode,
          statusMessage: statusMessage,
          map: jsonObj as Map<String, dynamic>,
        );
      } else if (jsonObj is List) {
        return ApiError(
          statusCode: statusCode,
          statusMessage: statusMessage,
          errorType: ApiErrorType.unknown,
          originErrorText: responseErrorData,
          errorMessage: statusMessage ?? "Unknown Error Message (Array)",
          errorDetails: null,
        );
      } else {
        return ApiError(
          statusCode: statusCode,
          statusMessage: statusMessage,
          errorType: ApiErrorType.unknown,
          originErrorText: responseErrorData,
          errorMessage: statusMessage ?? "Unknown Error Message",
          errorDetails: null,
        );
      }
    } else if (responseErrorData is Map) {
      return ApiError.fromMap(
        errorType: errorType,
        statusCode: statusCode,
        statusMessage: statusMessage,
        map: responseErrorData as Map<String, dynamic>,
      );
    } else {
      return ApiError(
        statusCode: statusCode,
        statusMessage: statusMessage,
        errorType: errorType,
        originErrorText: responseErrorData,
        errorMessage: statusMessage ?? "Unknown Error Message",
        errorDetails: null,
      );
    }
  }
}

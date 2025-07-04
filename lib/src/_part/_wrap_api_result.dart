part of '../../flutter_artist_core.dart';

class WrapApiResult {
  int? statusCode;
  String? statusMessage;

  //
  String? result;
  ApiError? apiError;

  Map<String, dynamic>? data;

  WrapApiResult.error({
    this.statusCode,
    this.statusMessage,
    ApiErrorType? apiErrorType,
    required String errorMessage,
    List<String>? errorDetails,
    String? originErrorText,
  }) : apiError = ApiError(
         statusCode: statusCode,
         statusMessage: statusMessage,
         apiErrorType: apiErrorType,
         errorMessage: errorMessage,
         errorDetails: errorDetails,
         originErrorText: originErrorText,
       );

  WrapApiResult.data({this.statusCode, this.statusMessage, this.data});

  static WrapApiResult? fromDynamicData({
    int? statusCode,
    String? statusMessage,
    dynamic data,
  }) {
    if (data is String) {
      return fromJson(
        statusCode: statusCode,
        statusMessage: statusMessage,
        json: data,
      );
    } else if (data is Map<String, dynamic>) {
      return fromMap(
        statusCode: statusCode,
        statusMessage: statusMessage,
        map: data,
      );
    } else {
      // TODO:
      throw UnimplementedError();
    }
  }

  static WrapApiResult? fromMap({
    int? statusCode,
    String? statusMessage,
    required Map<String, dynamic> map,
  }) {
    Map<String, dynamic>? data;
    try {
      data = map['data'];
    } catch (e, stackTrace) {
      return WrapApiResult.error(
        statusCode: statusCode,
        statusMessage: statusMessage,
        apiErrorType: ApiErrorType.invalidJson,
        errorMessage: "Invalid JSON - 'data' attribute invalid",
      );
    }
    return WrapApiResult.data(
      statusCode: statusCode,
      statusMessage: statusMessage,
      data: data,
    );
  }

  static WrapApiResult? fromJson({
    int? statusCode,
    String? statusMessage,
    required String json,
  }) {
    if (json.trim().isEmpty) {
      return null;
    }
    Map<String, dynamic> map;
    try {
      map = jsonDecode(json);
    } catch (e, stackTrace) {
      return WrapApiResult.error(
        statusCode: statusCode,
        statusMessage: statusMessage,
        apiErrorType: ApiErrorType.notJson,
        errorMessage: "Not JSON: $e",
      );
    }
    return fromMap(
      statusCode: statusCode,
      statusMessage: statusMessage,
      map: map,
    );
  }
}

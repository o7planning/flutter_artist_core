part of '../../flutter_artist_core.dart';

class WrapApiResult {
  String? result;
  ApiErrorType? apiErrorType;
  int? statusCode;
  String? errorMessage;
  List<String>? errorDetails;
  Map<String, dynamic>? data;
  dynamic errorData;

  WrapApiResult.error({
    this.statusCode,
    required this.apiErrorType,
    this.errorMessage,
    this.errorDetails,
    this.errorData,
  });

  WrapApiResult.data({this.data});

  ApiError? toApiError() {
    if (errorMessage != null) {
      return ApiError(
        apiErrorType: apiErrorType,
        errorMessage: errorMessage!,
        errorDetails: errorDetails,
        statusCode: statusCode,
        errorData: errorData,
      );
    }
    return null;
  }

  static WrapApiResult? fromDynamicData(dynamic data) {
    if (data is String) {
      return fromJson(data);
    } else {
      return fromMap(data);
    }
  }

  static WrapApiResult? fromMap(Map<String, dynamic> map) {
    Map<String, dynamic>? data;
    try {
      data = map['data'];
    } catch (e, stackTrace) {
      return WrapApiResult.error(
        apiErrorType: ApiErrorType.invalidJson,
        errorMessage: "Invalid JSON - 'data' attribute invalid",
      );
    }
    return WrapApiResult.data(data: data);
  }

  static WrapApiResult? fromJson(String json) {
    if (json.trim().isEmpty) {
      return null;
    }
    Map<String, dynamic> map;
    try {
      map = jsonDecode(json);
    } catch (e, stackTrace) {
      return WrapApiResult.error(
        apiErrorType: ApiErrorType.notJson,
        errorMessage: "Not JSON: $e",
      );
    }
    return fromMap(map);
  }
}

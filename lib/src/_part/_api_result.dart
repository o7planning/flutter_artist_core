part of '../../flutter_artist_core.dart';

///
/// SUCCESS DATA:
/// ```json
/// {
///    "email": "tom@example.com",
///    "userName": "tom"
/// }
/// ```
/// ERROR CASE 1:
/// ```json
/// {
///    "timestamp": "2025-01-26T05:34:11.649+00:00",
///    "status": 500,
///    "error": "Internal Server Error",
///    "path": "/rest/appUserInfoPage"
// }
/// ```
/// ERROR CASE 2:
/// ```json
/// {
///   "status" : "INTERNAL_SERVER_ERROR",
///   "errorMessage" : "Some Message",
///   "errorDetails" : [ "Cause 1", "Cause 2" ]
/// }
/// ```
/// LEANTEK PROJECT:
/// ```json
/// {
///    "result": "success",
///    "status": null,
///    "errorMessage" : null,
///    "data": { ... }
/// }
/// ```
///
class ApiResult<D> {
  D? data;
  int? statusCode;
  ApiError? apiError;

  // TODO: Remove.
  ApiResult({this.data, this.statusCode, this.apiError});

  ApiResult.data(this.data);

  ApiResult.apiError(ApiError this.apiError) : statusCode = apiError.statusCode;

  ApiResult.error({
    this.statusCode,
    ApiErrorType? apiErrorType,
    required String errorMessage,
    List<String>? errorDetails,
    String? originErrorText,
  }) : apiError = ApiError(
         statusCode: statusCode,
         apiErrorType: apiErrorType,
         errorMessage: errorMessage,
         errorDetails: errorDetails,
         originErrorText: originErrorText,
       );

  static ApiResult<D> fromDynamicData<D>({
    required int? statusCode,
    required dynamic data,
    required Converter? dataConverter,
  }) {
    if (data == null) {
      return ApiResult<D>();
    }
    if (data is String) {
      return fromJson<D>(
        json: data,
        dataConverter: dataConverter,
        statusCode: statusCode,
      );
    } else if (data is Map<String, dynamic>) {
      return fromMap<D>(
        map: data,
        dataConverter: dataConverter,
        statusCode: statusCode,
      );
    } else {
      // TODO: List??
      return ApiResult<D>.apiError(
        ApiError(
          errorMessage: "Not support response data type ${data.runtimeType}",
        ),
      );
    }
  }

  static ApiResult<D> fromJson<D>({
    required String json,
    required Converter? dataConverter,
    required int? statusCode,
  }) {
    if (json.trim().isEmpty) {
      return ApiResult();
    }
    Map<String, dynamic> map;
    try {
      map = jsonDecode(json);
    } catch (e, stackTrace) {
      return ApiResult<D>.apiError(
        ApiError(
          apiErrorType: ApiErrorType.notJson,
          errorMessage: "Not JSON: $e",
        ),
      );
    }
    return fromMap(
      map: map,
      dataConverter: dataConverter,
      statusCode: statusCode,
    );
  }

  ///
  /// CASE 1:
  /// ```json
  /// {
  ///    "timestamp": "2025-01-26T05:34:11.649+00:00",
  ///    "status": 500,
  ///    "error": "Internal Server Error",
  ///    "path": "/rest/appUserInfoPage"
  /// }
  /// ```
  /// CASE 2:
  /// ```json
  /// {
  ///   "status" : "INTERNAL_SERVER_ERROR",
  ///   "errorMessage" : "Some Message",
  ///   "errorDetails" : [ "Cause 1", "Cause 2" ]
  /// }
  /// ```
  ///
  static ApiResult<D> fromMap<D>({
    required Map<String, dynamic> map,
    required Converter? dataConverter,
    required int? statusCode,
  }) {
    D? data;
    if (dataConverter != null) {
      try {
        data = dataConverter(map);
      } catch (e, stackTrace) {
        return ApiResult<D>.apiError(
          ApiError(
            apiErrorType: ApiErrorType.conversion,
            errorMessage: "Data Convert error: $e",
            originErrorText: JsonUtils.jsonEncodeMap(map: map),
          ),
        );
      }
    }
    //
    return ApiResult.data(data);
  }

  bool isError() {
    return apiError != null;
  }

  void throwIfError() {
    if (isError()) {
      throw apiError!;
    }
  }

  ///
  /// Throw ApiError if data is null.
  ///
  void throwIfErrorOrDataNull({required String nullDataMessage}) {
    if (isError()) {
      throw apiError!;
    } else if (data == null) {
      throw ApiError(
        statusCode: statusCode,
        errorMessage: nullDataMessage,
        errorDetails: null,
      );
    }
  }

  ApiResult<PageData<D>> toPageDataResult() {
    PageData<D> pageData =
        data ==
                null //
            ? DefaultPageData.empty()
            : DefaultPageData.item(item: data as D);
    return ApiResult<PageData<D>>(
      data: pageData,
      statusCode: statusCode,
      apiError: apiError,
    );
  }

  ApiResult<void> toVoidResult() {
    return ApiResult<void>(
      data: null,
      statusCode: statusCode,
      apiError: apiError,
    );
  }

  ApiResult<F> convert<F>({required F Function(D data) converter}) {
    F? fData = data == null ? null : converter(data!);
    return ApiResult<F>(
      data: fData,
      statusCode: statusCode,
      apiError: apiError,
    );
  }
}

typedef ErrorConverter = String Function(dynamic);

// {
//   "result": "fail",
//   "errorMessage": "Bad Request",
//   "errorCode": "400",
//   "errors": [
//      "Exists Key Result.",
//      "Exists Aligned Objective."
//   ]
// }
String defaultErrorConverter(dynamic error) {
  return error.toString();
}

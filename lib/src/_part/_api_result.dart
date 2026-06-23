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
  final D? data;
  final int? statusCode;
  final String? statusMessage;
  final ApiError? error;

  ApiResult.success({this.data, this.statusCode, this.statusMessage})
    : assert(
        statusCode == null ||
            statusCode == 304 ||
            (statusCode >= 200 && statusCode < 300),
      ),
      error = null;

  ApiResult.error({
    this.statusCode,
    this.statusMessage,
    ApiErrorType? errorType,
    required String errorMessage,
    List<String>? errorDetails,
    String? originErrorText,
  }) : // assert(
       //   statusCode == null ||
       //       statusCode < 200 ||
       //       (statusCode > 300 && statusCode != 304),
       // ),
       error = ApiError(
         statusCode: statusCode,
         statusMessage: statusMessage,
         errorType: errorType,
         errorMessage: errorMessage,
         errorDetails: errorDetails,
         originErrorText: originErrorText,
       ),
       data = null;

  ApiResult.fromError(ApiError this.error)
    : // assert(
      //   error.statusCode == null ||
      //       error.statusCode! < 200 ||
      //       (error.statusCode! >= 300 && error.statusCode != 304),
      // ),
      statusCode = error.statusCode,
      statusMessage = error.statusMessage,
      data = null;

  factory ApiResult.fromDynamicData({
    required int? statusCode,
    required String? statusMessage,
    required dynamic data,
    required Converter? dataConverter,
    bool printOriginDioStackTrace = true,
  }) {
    if (data == null) {
      return ApiResult<D>.success(
        statusCode: statusCode,
        statusMessage: statusMessage,
        data: null,
      );
    }
    if (data is String) {
      return ApiResult.fromJson(
        statusCode: statusCode,
        statusMessage: statusMessage,
        json: data,
        dataConverter: dataConverter,
      );
    } else if (data is Map<String, dynamic>) {
      return ApiResult.fromMap(
        statusCode: statusCode,
        statusMessage: statusMessage,
        map: data,
        dataConverter: dataConverter,
        printOriginDioStackTrace: printOriginDioStackTrace,
      );
    } else {
      // TODO: List??
      return ApiResult<D>.fromError(
        ApiError(
          statusCode: statusCode,
          statusMessage: statusMessage,
          errorMessage: "Not support response data type ${data.runtimeType}",
        ),
      );
    }
  }

  factory ApiResult.fromJson({
    required int? statusCode,
    required String? statusMessage,
    required String json,
    required Converter? dataConverter,
  }) {
    if (json.trim().isEmpty) {
      return ApiResult.success(
        statusCode: statusCode,
        statusMessage: statusMessage,
        data: null,
      );
    }
    Map<String, dynamic> map;
    try {
      map = jsonDecode(json);
    } catch (e, _) {
      return ApiResult<D>.fromError(
        ApiError(
          statusCode: statusCode,
          statusMessage: statusMessage,
          errorType: ApiErrorType.notJson,
          errorMessage: "Not JSON: $e",
        ),
      );
    }
    return ApiResult.fromMap(
      statusCode: statusCode,
      statusMessage: statusMessage,
      map: map,
      dataConverter: dataConverter,
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
  factory ApiResult.fromMap({
    required int? statusCode,
    required String? statusMessage,
    required Map<String, dynamic> map,
    required Converter? dataConverter,
    bool printOriginDioStackTrace = true,
  }) {
    D? data;
    if (dataConverter != null) {
      try {
        data = dataConverter(map);
      } catch (e, stackTrace) {
        if (printOriginDioStackTrace) {
          print(stackTrace);
        }
        return ApiResult<D>.fromError(
          ApiError(
            statusCode: statusCode,
            statusMessage: statusMessage,
            errorType: ApiErrorType.conversion,
            errorMessage: "Data Convert error: $e",
            originErrorText: FaJsonUtils.jsonEncodeMap(map: map),
            usedConverter: dataConverter,
          ),
        );
      }
    }
    //
    return ApiResult<D>.success(
      statusCode: statusCode,
      statusMessage: statusMessage,
      data: data,
    );
  }

  bool isError() {
    return error != null;
  }

  void throwIfError() {
    if (isError()) {
      throw error!;
    }
  }

  ///
  /// Throw ApiError if data is null.
  ///
  void throwIfErrorOrDataNull({required String nullDataMessage}) {
    if (isError()) {
      throw error!;
    } else if (data == null) {
      throw ApiError(
        statusCode: statusCode,
        statusMessage: statusMessage,
        errorMessage: nullDataMessage,
        errorDetails: null,
      );
    }
  }

  ApiResult<PageData<D>> toPageDataResult() {
    PageData<D> pageData =
        data == null ? PageData.empty() : PageData.ofItem(data as D);
    return error == null
        ? ApiResult<PageData<D>>.success(
          data: pageData,
          statusCode: statusCode,
          statusMessage: statusMessage,
        )
        : ApiResult<PageData<D>>.fromError(error!);
  }

  ApiResult<R> toNullDataResult<R>() {
    return error == null
        ? ApiResult<R>.success(
          statusCode: statusCode,
          statusMessage: statusMessage,
          data: null,
        )
        : ApiResult<R>.fromError(error!);
  }

  ApiResult<void> toVoidResult() {
    return error == null
        ? ApiResult<void>.success(
          statusCode: statusCode,
          statusMessage: statusMessage,
          data: null,
        )
        : ApiResult<void>.fromError(error!);
  }

  ApiResult<F> convert<F>({required F Function(D data) converter}) {
    F? fData = data == null ? null : converter(data as D);
    return error == null
        ? ApiResult<F>.success(
          statusCode: statusCode,
          statusMessage: statusMessage,
          data: fData,
        )
        : ApiResult<F>.fromError(error!);
  }

  /// Casts an ApiResult containing flat ListData into an ApiResult containing structured PageData.
  static ApiResult<PageData<ITEM>> createPageDataResult<ITEM>(
    ApiResult<ListData<ITEM>> listResult,
  ) {
    if (listResult.error != null) {
      return ApiResult<PageData<ITEM>>.fromError(listResult.error!);
    }
    return ApiResult<PageData<ITEM>>.success(
      statusCode: listResult.statusCode,
      statusMessage: listResult.statusMessage,
      data: listResult.data?.toPageData(),
    );
  }

  /// Casts an ApiResult containing structured PageData into an ApiResult containing flat ListData.
  static ApiResult<ListData<ITEM>> createListDataResult<ITEM>(
    ApiResult<PageData<ITEM>> pageResult,
  ) {
    if (pageResult.error != null) {
      return ApiResult<ListData<ITEM>>.fromError(pageResult.error!);
    }
    return ApiResult<ListData<ITEM>>.success(
      statusCode: pageResult.statusCode,
      statusMessage: pageResult.statusMessage,
      data: pageResult.data?.toListData(),
    );
  }
}

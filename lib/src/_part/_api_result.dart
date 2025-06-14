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
  String? status;
  String? errorMessage;
  List<String>? errorDetails;
  String? originText;

  ApiResult({
    this.data,
    this.status,
    this.errorMessage,
    this.errorDetails,
    this.originText,
  });

  ApiResult.data(this.data);

  ApiResult.error({
    this.status,
    this.errorMessage,
    this.errorDetails,
    this.originText,
  });

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
      return ApiResult<D>(
        errorMessage: "Not support response data type ${data.runtimeType}",
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
      print("ERROR jsonDecode: $e");
      print("JSON: $json");
      return ApiResult.error(errorMessage: "Error jsonDecode: $e");
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
  // }
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
    String? status =
        (map['status'] ?? map['errorStatus'] ?? statusCode).toString();
    //
    String? errorMessage =
        map['errorMessage'] ?? map['error'] ?? map['message'];
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
    //
    D? data;
    if (dataConverter != null) {
      try {
        data = dataConverter(map);
      } catch (e, stackTrace) {
        errorMessage ??= "Data Convert error: $e";
      }
    }
    //
    if (statusCode != null && statusCode >= 300) {
      return ApiResult.error(
        status: status,
        errorMessage: errorMessage ?? "Error with status code: $statusCode",
        errorDetails: errorDetails,
      );
    } else {
      return ApiResult(
        status: status,
        errorMessage: errorMessage,
        errorDetails: errorDetails,
        data: data,
      );
    }
  }

  bool isError() {
    return errorMessage != null;
  }

  void throwIfError() {
    if (isError()) {
      throw ApiError(
        status: status,
        errorMessage: errorMessage!,
        errorDetails: errorDetails,
      );
    }
  }

  ///
  /// Throw ApiError if data is null.
  ///
  void throwIfErrorOrDataNull({required String nullDataMessage}) {
    if (isError()) {
      throw ApiError(
        status: status,
        errorMessage: errorMessage!,
        errorDetails: errorDetails,
      );
    } else if (data == null) {
      throw ApiError(
        status: status,
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
      status: status,
      errorMessage: errorMessage,
      errorDetails: errorDetails,
    );
  }

  ApiResult<void> toVoidResult() {
    return ApiResult<void>(
      data: null,
      status: status,
      errorMessage: errorMessage,
      errorDetails: errorDetails,
    );
  }

  ApiResult<F> convert<F>({required F Function(D data) converter}) {
    F? fData = data == null ? null : converter(data!);
    return ApiResult<F>(
      data: fData,
      status: status,
      errorMessage: errorMessage,
      errorDetails: errorDetails,
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

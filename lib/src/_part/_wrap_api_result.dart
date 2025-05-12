part of '../../flutter_artist_core.dart';

class WrapApiResult {
  String? result;
  String? status;
  String? errorMessage;
  List<String>? errorDetails;
  Map<String, dynamic>? data;

  WrapApiResult({
    required this.result,
    this.status,
    this.errorMessage,
    this.errorDetails,
    this.data,
  });

  static WrapApiResult? fromDynamicData(dynamic data) {
    if (data is String) {
      return fromJson(data);
    } else {
      return fromMap(data);
    }
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
  static WrapApiResult? fromMap(Map<String, dynamic> map) {
    try {
      String? result = map['result'];
      //
      String? status = (map['status'] ?? map['errorStatus']).toString();
      //
      String? errorMessage =
          map['errorMessage'] ?? map['error'] ?? map['message'];
      //
      dynamic errorDs = map['errors'] ?? map['errorDetails'];
      //

      Map<String, dynamic>? data = map['data'];
      //
      List<String>? errorDetails;
      if (errorDs != null) {
        if (errorDs is List) {
          errorDetails = errorDs.map((e) => e.toString()).toList();
        } else {
          errorDetails = [errorDs.toString()];
        }
      }
      //
      return WrapApiResult(
        result: result,
        status: status,
        errorMessage: errorMessage,
        errorDetails: errorDetails,
        data: data,
      );
    } catch (e) {
      return WrapApiResult(
        result: "fail",
        status: null,
        errorMessage: "Error $e",
        errorDetails: null,
        data: null,
      );
    }
  }

  static WrapApiResult? fromJson(String json) {
    if (json.trim().isEmpty) {
      return null;
    }
    Map<String, dynamic> map = jsonDecode(json);
    return fromMap(map);
  }
}

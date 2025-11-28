part of '../../flutter_artist_core.dart';

///
/// ```json
/// {
///   "code": "INVALID_INPUT",
///   "message": "The provided data is invalid.",
///   "details": [
///       {
///       "field": "email",
///       "message": "Email address is not in a valid format."
///       },
///       {
///       "field": "password",
///       "message": "Password must be at least 8 characters long."
///       }
///   ]
/// }
/// ```
///
/// OR:
/// ```json
/// {
///   "code": "INVALID_INPUT",
///   "message": "The provided data is invalid.",
///   "details": [
///      "Email address is not in a valid format.",,
///      "Password must be at least 8 characters long."
///   ]
/// }
/// ```
///
/// See documents:
///
/// https://o7planning.org/14825/flutterartist-errorinfoextractor
///
abstract class ErrorInfoExtractor {
  const ErrorInfoExtractor();

  String? extractErrorMessage({required Map<String, dynamic> errorJson});

  List<String>? extractErrorDetails({required Map<String, dynamic> errorJson});
}

class SimpleErrorInfoExtractor extends ErrorInfoExtractor {
  final List<String> errorMessageProperties;
  final List<String> errorDetailsProperties;

  const SimpleErrorInfoExtractor({
    this.errorMessageProperties = const ["errorMessage", "message", "error"],
    this.errorDetailsProperties = const ["errorDetails", "details", "detail"],
  });

  @override
  String? extractErrorMessage({required Map<String, dynamic> errorJson}) {
    for (String propName in errorMessageProperties) {
      dynamic value = errorJson[propName];
      if (value is String) {
        return value;
      }
    }
    return null;
  }

  @override
  List<String>? extractErrorDetails({required Map<String, dynamic> errorJson}) {
    for (String propName in errorDetailsProperties) {
      dynamic value = errorJson[propName];
      if (value is List) {
        try {
          List<String> errorDetails = value.cast<String>();
          return errorDetails;
        } catch (e) {}
      }
    }
    for (String propName in errorDetailsProperties) {
      dynamic value = errorJson[propName];
      if (value is String) {
        return [value];
      }
    }
    return null;
  }
}

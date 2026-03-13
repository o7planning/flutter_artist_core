part of '../../flutter_artist_core.dart';

class FlexibleErrorInfoExtractor extends ErrorInfoExtractor {
  final List<String> messageKeys;
  final List<String> detailKeys;

  /// Custom function to convert a detail object to a string.
  /// If not provided, the system will use the default Stringify mechanism.
  final String Function(dynamic detail)? detailStringifier;

  const FlexibleErrorInfoExtractor({
    this.messageKeys = const [
      "message",
      "errorMessage",
      "error",
      "msg",
      "title",
    ],
    this.detailKeys = const ["details", "errorDetails", "errors", "detail"],
    this.detailStringifier,
  });

  @override
  String? extractErrorMessage({required Map<String, dynamic> errorJson}) {
    // 1. Search at the root level.
    String? message = _findFirstString(errorJson, messageKeys);

    // 2. If you still can't find it, try searching one level deeper
    //  (Handling Template Nested Objects)
    if (message == null) {
      for (String key in ["error", "innerError", "response"]) {
        dynamic subJson = errorJson[key];
        if (subJson is Map<String, dynamic>) {
          message = _findFirstString(subJson, messageKeys);
          if (message != null) break;
        }
      }
    }
    return message;
  }

  @override
  List<String>? extractErrorDetails({required Map<String, dynamic> errorJson}) {
    for (String key in detailKeys) {
      dynamic value = errorJson[key];
      if (value == null) continue;

      // Case 1: The data is a list
      if (value is List) {
        return value.map((item) => _stringifyDetail(item)).toList();
      }
      // Case 2: Data is a Map (Handling Template Validation Summary in Laravel/.NET style)
      else if (value is Map<String, dynamic>) {
        return value.entries
            .map((e) => _stringifyMapEntry(e.key, e.value))
            .toList();
      }
      // Case 3: The data is a single string
      else if (value is String) {
        return [value];
      }
    }
    return null;
  }

  /// Convert any error item into a display string
  String _stringifyDetail(dynamic item) {
    if (detailStringifier != null) return detailStringifier!(item);

    if (item is Map<String, dynamic>) {
      // Prioritize finding the field pair: message (Template 1)
      String? msg = _findFirstString(item, [
        "message",
        "msg",
        "error",
        "description",
      ]);
      String? field = _findFirstString(item, [
        "field",
        "property",
        "key",
        "pointer",
      ]);

      if (field != null && msg != null) return "$field: $msg";
      if (msg != null) return msg;

      // If it's any Map, return it as key:value
      return item.entries.map((e) => "${e.key}: ${e.value}").join(", ");
    }
    return item.toString();
  }

  /// Handle each entry in a Map error (Key type: [msg1, msg2])
  String _stringifyMapEntry(String key, dynamic value) {
    if (value is List) {
      return "$key: ${value.join(', ')}";
    }
    return "$key: $value";
  }

  /// Find the first string that matches the provided list of keys
  String? _findFirstString(Map<String, dynamic> json, List<String> keys) {
    for (String key in keys) {
      dynamic val = json[key];
      if (val is String) return val;
    }
    return null;
  }
}

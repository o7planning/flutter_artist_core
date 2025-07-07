part of '../../flutter_artist_core.dart';

class JsonUtils {
  static final _encoder = const JsonEncoder.withIndent("   ");

  static String? jsonEncodeMap({
    required Map<String, dynamic> map,
    String? defaultString,
  }) {
    try {
      return jsonEncode(map);
    } catch (e) {
      return defaultString;
    }
  }

  static String? toBeautifulJson(Object jsonObj) {
    try {
      return _encoder.convert(jsonObj);
    } catch (e) {
      return null;
    }
  }

  static bool deepJsonCompare({
    required Object? jsonObj1,
    required Object? jsonObj2,
  }) {
    if (jsonObj1 == null && jsonObj2 == null) {
      return true;
    } else if (jsonObj1 == null && jsonObj2 != null) {
      return false;
    } else if (jsonObj1 != null && jsonObj2 == null) {
      return false;
    }
    if (jsonObj1 is Map) {
      if (jsonObj2 is List) {
        return false;
      } else if (jsonObj2 is Map) {
        Set<dynamic> keys =
            {}
              ..addAll(jsonObj1.keys)
              ..addAll(jsonObj2.keys);
        for (dynamic key in keys) {
          dynamic v1 = jsonObj1[key];
          dynamic v2 = jsonObj1[key];
          bool eq = deepJsonCompare(jsonObj1: v1, jsonObj2: v2);
          if (!eq) {
            return false;
          }
        }
        return true;
      } else {
        return false;
      }
    } else if (jsonObj1 is List) {
      if (jsonObj2 is List) {
        if (jsonObj1.length != jsonObj2.length) {
          return false;
        }
        for (int i = 0; i < jsonObj1.length; i++) {
          bool eq = deepJsonCompare(
            jsonObj1: jsonObj1[i],
            jsonObj2: jsonObj2[i],
          );
          if (!eq) {
            return false;
          }
        }
        return true;
      } else if (jsonObj2 is Map) {
        return false;
      } else {
        return false;
      }
    } else {
      if (jsonObj2 is List) {
        return false;
      } else if (jsonObj2 is Map) {
        return false;
      } else {
        return jsonObj1 == jsonObj2;
      }
    }
  }
}

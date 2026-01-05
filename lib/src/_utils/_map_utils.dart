part of '../../flutter_artist_core.dart';

class MapUtils {
  static bool isIdenticalValues({
    required Map<String, dynamic> map1,
    required Map<String, dynamic> map2,
  }) {
    var keys =
        <String>{}
          ..addAll(map1.keys)
          ..addAll(map2.keys);
    for (String key in keys) {
      dynamic v1 = map1[key];
      dynamic v2 = map2[key];
      if (!identical(v1, v2)) {
        return false;
      }
    }
    return true;
  }

  static String toOneLevelJson({
    required Map<String, dynamic> map,
    int indent = 3,
  }) {
    final String indentString = " " * indent;
    String json;
    try {
      json = jsonEncode(map, toEncodable: (obj) => obj.toString());
      Map<String, dynamic> m2 = jsonDecode(json);
      JsonEncoder encoder = JsonEncoder.withIndent(indentString);
      String s = encoder.convert(m2);
      return s;
    } catch (e) {
      return "Error convert to JSON: $e";
    }
  }

  static String toJson({
    required Map<String, dynamic> map,
    int indent = 3,
  }) {
    final String indentString = " " * indent;
    String json;
    try {
      json = jsonEncode(map, toEncodable: (obj) => obj.toString());
      Map<String, dynamic> m2 = jsonDecode(json);
      JsonEncoder encoder = JsonEncoder.withIndent(indentString);
      String s = encoder.convert(m2);
      return s;
    } catch (e) {
      return "Error convert to JSON: $e";
    }
  }
}

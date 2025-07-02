part of '../../flutter_artist_core.dart';

class JsonUtils {
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
}

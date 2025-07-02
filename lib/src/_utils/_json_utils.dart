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
}

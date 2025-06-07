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
}

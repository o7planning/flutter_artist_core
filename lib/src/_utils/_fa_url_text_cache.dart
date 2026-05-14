import 'package:http/http.dart' as http;

class FaUrlTextCache {
  static final FaUrlTextCache _instance = FaUrlTextCache._internal();

  FaUrlTextCache._internal();

  static FaUrlTextCache get instance => _instance;

  final Map<String, String> _cache = {};

  Future<String> getText({required String url}) async {
    if (_cache.containsKey(url)) {
      return _cache[url]!;
    }
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final body = response.body;
        _cache[url] = body;
        return body;
      }
      throw Exception("Failed to load content: ${response.statusCode}");
    } catch (e) {
      rethrow;
    }
  }

  void clearCache() => _cache.clear();
}

import '../../flutter_artist_core.dart';

class DevUtils {
  static String getDraftUrl(FaDocument doc) {
    if (doc.langCode == "en") {
      return doc.url.replaceAll(
        "https://o7planning.org/",
        "http://51.195.44.134:8080/en/",
      );
    }
    return doc.url.replaceAll(
      "https://openplanning.net/",
      "http://51.195.44.134:8080/vi/",
    );
  }
}

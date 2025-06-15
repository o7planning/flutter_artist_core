part of '../../flutter_artist_core.dart';

interface class TokenStorage {
  Future<String?> readAccessToken() async {
    return "";
  }

  Future<void> saveAccessToken(String newAccessToken) async {
    return;
  }

  Future<void> clearTokens() async {
    //
  }
}

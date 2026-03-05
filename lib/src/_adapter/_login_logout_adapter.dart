import 'package:flutter_artist_core/flutter_artist_core.dart';

interface class FlutterArtistLoginLogoutAdapter {
  String toJson(ILoggedInUser loggedInUser) {
    throw UnimplementedError();
  }

  ILoggedInUser? fromJson(String json) {
    throw UnimplementedError();
  }

  void addThirdPartyLogicOnLogin(ILoggedInUser loggedInUser) {
    throw UnimplementedError();
  }

  void addThirdPartyLogicOnLogout() {
    throw UnimplementedError();
  }
}

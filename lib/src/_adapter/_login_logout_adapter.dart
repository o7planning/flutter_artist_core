import 'package:flutter_artist_core/flutter_artist_core.dart';

interface class FlutterArtistLoginLogoutAdapter {
  /// Convert the user object to a JSON string for local storage.
  String toJson(ILoggedInUser loggedInUser) {
    throw UnimplementedError();
  }

  /// Restore the user object from a JSON string upon application restart.
  ILoggedInUser? fromJson(String json) {
    throw UnimplementedError();
  }

  ///
  /// Implementation Example (Use with fresh_dio library):
  ///
  /// ```
  /// LoggedInUserData token = loggedInUser as LoggedInUserData;
  /// fresh.setToken(token);
  /// ```
  ///
  void addThirdPartyLogicOnLogin(ILoggedInUser loggedInUser) {
    throw UnimplementedError();
  }

  ///
  /// Implementation Example (Use with fresh_dio library):
  ///
  /// ```
  /// fresh.setToken(null);
  /// ```
  ///
  void addThirdPartyLogicOnLogout() {
    throw UnimplementedError();
  }
}

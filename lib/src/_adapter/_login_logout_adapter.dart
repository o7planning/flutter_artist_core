import 'package:flutter_artist_core/flutter_artist_core.dart';

interface class FlutterArtistLoginLogoutAdapter<USER extends ILoggedInUser> {
  ///
  /// If user information was previously stored on a local device and successfully recovered at application startup,
  /// this method will be automatically invoked to retrieve the latest information from the server.
  ///
  Future<USER> performReloadLoggedInUser({required USER loggedInUser}) async {
    throw UnimplementedError();
  }

  /// Convert the user object to a JSON string for local storage.
  String toJson(USER loggedInUser) {
    throw UnimplementedError();
  }

  /// Restore the user object from a JSON string upon application restart.
  USER? fromJson(String json) {
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
  void addThirdPartyLogicOnLogin(USER loggedInUser) {
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

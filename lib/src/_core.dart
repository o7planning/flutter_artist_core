part of '../flutter_artist_core.dart';

class FlutterArtistCore {
  /// The central navigation key for the entire framework.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Access the current BuildContext safely.
  static BuildContext get context {
    final ctx = navigatorKey.currentContext;
    if (ctx == null) {
      throw Exception(
        "FlutterArtistCore: navigatorKey is not attached. Check your MaterialApp.",
      );
    }
    return ctx;
  }
}

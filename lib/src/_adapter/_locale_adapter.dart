import 'package:flutter/material.dart';

///
/// Docs: [14883]
///
interface class FlutterArtistLocaleAdapter {
  List<Locale> supportedLocales() {
    throw UnimplementedError();
  }

  ///
  /// Use this local, for example in GETX:
  /// ```dart
  ///  Get.updateLocale(locale);
  /// ```
  ///
  Future<void> updateLocale(Locale locale) {
    throw UnimplementedError();
  }
}

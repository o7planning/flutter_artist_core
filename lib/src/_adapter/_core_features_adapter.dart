import 'package:flutter/material.dart';

// Docs: [14863].
abstract interface class ICoreFeaturesAdapter {
  BuildContext getCurrentContext();

  Future<dynamic> showOverlay({
    double opacity = 0,
    required Future<dynamic> Function() asyncFunction,
  });

  bool isOverlaysOpen();

  void closeAllDialogs();

  void showMessageSnackBar({
    required String message,
    required List<String>? details,
  });

  void showWarningSnackBar({
    required String message,
    required List<String>? details,
  });

  void showErrorSnackBar({
    required String message,
    required List<String>? details,
  });

  void showSavedSnackBar({Duration duration = const Duration(seconds: 2)});

  void showDeletedSnackBar({
    String? customMessage,
    Duration duration = const Duration(seconds: 2),
  });
}

/// An abstract core layout gateway interface governing asynchronous processing masks,
/// global modal sheets lifecycles, and multi-state contextual status SnackBars.
///
/// This interface isolates the framework's presentation layer from strict runtime
/// UI dependencies, supporting complete component decoupling and seamless custom implementations.
// Docs: [14863].
abstract interface class FlutterArtistOverlayAdapter {
  /// Executes an asynchronous block execution sequence bounded inside a modal loading overlay mask.
  ///
  /// This method locks user interaction on the viewport during the lifetime of [asyncFunction],
  /// automatically cleaning up the overlay container when the execution terminates or fails.
  ///
  /// Parameters:
  /// * [opacity] Background alpha transparency for the overlay shield (defaults to 0).
  /// * [asyncFunction] The target transactional processing loop to perform under the shield mask.
  Future<dynamic> runWithOverlay({
    double opacity = 0,
    required Future<dynamic> Function() asyncFunction,
  });

  /// Evaluates whether a global loading presentation mask or operational modal layer is currently active.
  bool get isOverlayOpen;

  /// Instantly dismisses all active, open modal dialogue frameworks or custom sheets on the current navigator stack.
  void closeAllDialogs();

  /// Dispatches a global informational status notification banner (SnackBar).
  ///
  /// Parameters:
  /// * [message] The primary semantic status description string.
  /// * [details] Optional bulleted or structured sub-level logs for extra context.
  void showInfoSnackBar({
    required String message,
    required List<String>? details,
  });

  /// Dispatches a global warning alert banner (SnackBar) using high-contrast intent tokens.
  ///
  /// Parameters:
  /// * [message] The core warning or risk evaluation statement.
  /// * [details] List of operational parameters causing the warning state.
  void showWarningSnackBar({
    required String message,
    required List<String>? details,
  });

  /// Dispatches a destructive or critical failure alert banner (SnackBar) bound to danger tokens.
  ///
  /// Parameters:
  /// * [message] The fundamental root-cause error exception message.
  /// * [details] Nested technical verification telemetry or server error summaries.
  void showErrorSnackBar({
    required String message,
    required List<String>? details,
  });

  /// Displays a localized success notification confirming a data persist or save operation completed.
  ///
  /// Parameters:
  /// * [duration] The display window visibility lifetime before auto-dismissal (defaults to 2 seconds).
  void showSavedSnackBar({Duration duration = const Duration(seconds: 2)});

  /// Displays a localized transactional notification confirming an entity deletion or erasure completed.
  ///
  /// Parameters:
  /// * [customMessage] Overrides the default erasure description template string.
  /// * [duration] The presentation visibility lifecycle lifetime (defaults to 2 seconds).
  void showDeletedSnackBar({
    String? customMessage,
    Duration duration = const Duration(seconds: 2),
  });
}

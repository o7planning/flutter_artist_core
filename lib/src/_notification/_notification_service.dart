import '../_adapter/_notification_adapter.dart';

/// Base notification service to manage the lifecycle of different notification types.
abstract class FlutterArtistNotificationService<
  T extends FlutterArtistNotificationAdapter
> {
  final T adapter;

  FlutterArtistNotificationService(this.adapter);

  /// Called automatically during FlutterArtist.config() to set up the service.
  Future<void> initialize();

  /// Optional: Cleans up resources when the service is no longer needed.
  void dispose();
}

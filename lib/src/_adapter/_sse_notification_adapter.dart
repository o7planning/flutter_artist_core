import '../../flutter_artist_core.dart';

/// Interface for Adapters that support Server-Sent Events (SSE).
abstract class SSENotificationAdapter extends FlutterArtistNotificationAdapter {
  /// The data stream listens directly from the server.
  /// Each time the server "pours" data, this stream will emit an INotification.
  Stream<INotification> get sseStream;

  /// Method to close SSE connection when not needed.
  Future<void> closeStream();
}

import 'package:flutter_artist_core/flutter_artist_core.dart';

/// The Ancestor Interface
abstract class FlutterArtistNotificationAdapter {
  Future<void> connect();
  
  String toJson(INotificationSummary summary);

  INotificationSummary? fromJson(String json);

  void handleNotificationClick(INotification notification);
}

abstract class SimpleNotificationAdapter
    extends FlutterArtistNotificationAdapter { 

  @override
  Future<void> connect() async {
   // Do nothing.
  } 

  /// Actively pulls the latest notification summary (counts, icons) from the server.
  Future<ApiResult<INotificationSummary>> performLoadSummary();

  /// Sends a request to mark a specific notification or all notifications as read.
  Future<ApiResult<void>> performMarkAsRead({String? notificationId});
}

abstract class FirebaseNotificationAdapter
    extends FlutterArtistNotificationAdapter {


  @override
  Future<void> connect() async {
    // Do nothing.
  }


  /// Stream that emits a new notification when the app is in the foreground.
  Stream<INotification> get onNotificationReceived;

  /// Logic to handle the app state and navigation when a user taps a notification from the tray.
  Future<void> onNotificationOpened(Map<String, dynamic> data);

  /// Subscribes the device to a specific notification topic.
  Future<void> subscribeToTopic(String topic);

  /// Unsubscribes the device from a specific notification topic.
  Future<void> unsubscribeFromTopic(String topic);

  /// Retrieves the unique FCM registration token for this device to be stored on the backend.
  Future<String?> getDeviceToken();
}

abstract class SocketNotificationAdapter
    extends FlutterArtistNotificationAdapter {


  @override
  Future<void> connect() async {
    // Do nothing.
  }


  /// Gracefully closes the persistent connection.
  Future<void> disconnect();

  /// Returns the current connection status of the socket.
  bool get isConnected;

  /// Registers a listener for specific events emitted by the server.
  void listen(String eventName, Function(dynamic data) onData);

  /// Emits data or an event back to the server over the active connection.
  void emit(String eventName, dynamic data);
}

abstract class LocalNotificationAdapter
    extends FlutterArtistNotificationAdapter {


  @override
  Future<void> connect() async {
    // Do nothing.
  }


  /// Immediately triggers a system notification on the device.
  Future<void> showImmediately({
    required String title,
    required String body,
    String? payload,
  });

  /// Schedules a notification to appear at a specific date and time in the future.
  Future<void> schedule({
    required DateTime scheduledDate,
    required String title,
    required String body,
  });

  /// Cancels a specific scheduled notification by its ID.
  Future<void> cancel(int id);

  /// Clears all scheduled local notifications.
  Future<void> cancelAll();
}

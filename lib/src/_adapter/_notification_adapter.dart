import 'package:flutter_artist_core/flutter_artist_core.dart';

///
///
interface class FlutterArtistNotificationAdapter {
  Future<ApiResult<INotificationSummary>> performLoadNotificationSummary() {
    throw UnimplementedError();
  }

  Future<ApiResult<INotification>> performLoadNotifications() {
    throw UnimplementedError();
  }

  String toJson(INotificationSummary notificationSummary) {
    throw UnimplementedError();
  }

  INotificationSummary? fromJson(String json) {
    throw UnimplementedError();
  }
}

part of '../../flutter_artist_core.dart';

// docs: [14683]
interface class ILoggedInUser {
  String? get accessToken {
    throw UnimplementedError();
  }

  String get userName {
    throw UnimplementedError();
  }

  String get email {
    throw UnimplementedError();
  }

  bool get isSystemUser {
    throw UnimplementedError();
  }
}

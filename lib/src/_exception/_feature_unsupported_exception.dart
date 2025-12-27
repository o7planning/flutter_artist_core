class FeatureUnsupportedException implements Exception {
  factory FeatureUnsupportedException([String? message]) =>
      _FeatureUnsupportedException(message);
}

class _FeatureUnsupportedException implements FeatureUnsupportedException {
  final String? message;

  _FeatureUnsupportedException([this.message]);

  @override
  String toString() {
    String? msg = message;
    if (msg == null) return "FeatureUnsupportedException";
    return "FeatureUnsupportedException: $msg";
  }
}

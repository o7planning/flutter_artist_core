part of '../../flutter_artist_core.dart';

class LogSummary {
  final int recentErrorCount;
  final int recentWarningCount;

  final int totalErrorCount;
  final int totalWarningCount;

  final bool viewed;

  int get recentLogCount => recentErrorCount + recentWarningCount;

  int get totalLogCount => totalErrorCount + totalWarningCount;

  LogSummary({
    required this.recentErrorCount,
    required this.recentWarningCount,
    required this.totalErrorCount,
    required this.totalWarningCount,
    required this.viewed,
  });
}

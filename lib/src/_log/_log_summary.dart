part of '../../flutter_artist_core.dart';

class LogSummary {
  final int recentErrorCount;
  final int recentWarningCount;

  final int totalErrorCount;
  final int totalWarningCount;

  int get recentLogCount => recentErrorCount + recentWarningCount;

  int get totalLogCount => totalErrorCount + totalWarningCount;

  bool get hasRecentLogEntries => recentErrorCount != 0 || recentWarningCount!= 0;

  LogSummary({
    required this.recentErrorCount,
    required this.recentWarningCount,
    required this.totalErrorCount,
    required this.totalWarningCount,
  });
}

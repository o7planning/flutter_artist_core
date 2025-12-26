part of '../../flutter_artist_core.dart';

int _logEntrySequence = 0;

class LogEntry {
  final int id;
  final LogEntryType logEntryType;
  final String? shelfName;
  final String? methodName;

  final ErrorInfo? errorInfo;
  final WarningInfo? warningInfo;

  LogEntry.warning({
    required this.shelfName,
    required this.methodName,
    required WarningInfo this.warningInfo,
  }) : id = _logEntrySequence++,
       logEntryType = LogEntryType.warning,
       errorInfo = null;

  LogEntry.error({
    required this.shelfName,
    required this.methodName,
    required ErrorInfo this.errorInfo,
  }) : id = _logEntrySequence++,
       logEntryType = LogEntryType.error,
       warningInfo = null;
}

part of '../../flutter_artist_core.dart';

int _logEntrySequence = 1;

class LogEntry {
  final int id;
  final LogEntryType logEntryType;
  final String? shelfName;
  final String? methodName;
  final Object? tipDocument;

  final ErrorInfo? errorInfo;
  final WarningInfo? warningInfo;

  LogEntry.warning({
    required this.shelfName,
    required this.methodName,
    required WarningInfo this.warningInfo,
    this.tipDocument,
  }) : id = _logEntrySequence++,
       logEntryType = LogEntryType.warning,
       errorInfo = null;

  LogEntry.error({
    required this.shelfName,
    required this.methodName,
    required ErrorInfo this.errorInfo,
    this.tipDocument,
  }) : id = _logEntrySequence++,
       logEntryType = LogEntryType.error,
       warningInfo = null;
}

import 'package:flutter/material.dart';

enum LogEntryType {
  error,
  warning;

  Color get bgColor {
    switch (this) {
      case LogEntryType.error:
        return Colors.red;
      case LogEntryType.warning:
        return Colors.amber;
    }
  }

  Color get textColor {
    switch (this) {
      case LogEntryType.error:
        return Colors.white;
      case LogEntryType.warning:
        return Colors.white;
    }
  }
}

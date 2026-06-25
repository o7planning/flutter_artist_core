part of '../../flutter_artist_core.dart';

/// A centralized utility ledger repository containing pre-built, production-grade
/// [FaJsonConverter] implementations for extracting primitive keys from root JSON Objects.
class FaJsonConverters {
  FaJsonConverters._();

  /// Extracts a primitive [String] value from a specific root JSON object key.
  /// Returns null if the targeted key is missing or null and [isOptional] is true.
  ///
  /// ### Expected Root JSON Payload Layout:
  /// ```json
  /// {
  ///   "message": "Hello World"
  /// }
  /// ```
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<String?> result = await flutterArtistDio.jsonGet(
  ///   "/api/v1/system/status-message",
  ///   converter: FaJsonConverters.toStringConverter(jsonKey: "message"),
  /// );
  /// ```
  static FaJsonConverter<String?> toStringConverter({
    required String jsonKey,
    bool isOptional = true,
  }) {
    // ignore: prefer_function_declarations_over_variables
    final FaJsonConverter<String?> converter = (Map<String, dynamic> data) {
      final dynamic value = data[jsonKey];
      if (value == null) {
        if (isOptional) return null;
        throw ApiError(
          errorType: ApiErrorType.conversion,
          errorMessage:
              "Ecosystem Mapping Failure: The targeted JSON key '$jsonKey' is missing or null.",
        );
      }
      return value.toString();
    };
    return converter;
  }

  /// Extracts a primitive [int] value from a specific root JSON object key.
  /// Safely processes numeric strings and raw integer representations.
  ///
  /// ### Expected Root JSON Payload Layout:
  /// ```json
  /// {
  ///   "value": 123
  /// }
  /// ```
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<int?> result = await flutterArtistDio.jsonGet(
  ///   "/api/v1/analytics/count",
  ///   converter: FaJsonConverters.toIntConverter(jsonKey: "value"),
  /// );
  /// ```
  static FaJsonConverter<int?> toIntConverter({
    required String jsonKey,
    bool isOptional = true,
  }) {
    // ignore: prefer_function_declarations_over_variables
    final FaJsonConverter<int?> converter = (Map<String, dynamic> data) {
      final dynamic value = data[jsonKey];
      if (value == null) {
        if (isOptional) return null;
        throw ApiError(
          errorType: ApiErrorType.conversion,
          errorMessage:
              "Ecosystem Mapping Failure: The targeted JSON key '$jsonKey' is missing or null.",
        );
      }
      if (value is num) {
        return value.toInt();
      }
      if (value is String) {
        final int? parsed =
            int.tryParse(value) ?? double.tryParse(value)?.toInt();
        if (parsed != null) return parsed;
      }
      throw ApiError(
        errorType: ApiErrorType.conversion,
        errorMessage:
            "Ecosystem Mapping Failure: Cannot safely resolve key '$jsonKey' of type '${value.runtimeType}' to int.",
      );
    };
    return converter;
  }

  /// Extracts a primitive [double] value from a specific root JSON object key.
  /// Safely processes standard integers and numeric decimal string values.
  ///
  /// ### Expected Root JSON Payload Layout:
  /// ```json
  /// {
  ///   "ratio": 0.85
  /// }
  /// ```
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<double?> result = await flutterArtistDio.jsonGet(
  ///   "/api/v1/analytics/ratio",
  ///   converter: FaJsonConverters.toDoubleConverter(jsonKey: "ratio"),
  /// );
  /// ```
  static FaJsonConverter<double?> toDoubleConverter({
    required String jsonKey,
    bool isOptional = true,
  }) {
    // ignore: prefer_function_declarations_over_variables
    final FaJsonConverter<double?> converter = (Map<String, dynamic> data) {
      final dynamic value = data[jsonKey];
      if (value == null) {
        if (isOptional) return null;
        throw ApiError(
          errorType: ApiErrorType.conversion,
          errorMessage:
              "Ecosystem Mapping Failure: The targeted JSON key '$jsonKey' is missing or null.",
        );
      }
      if (value is num) {
        return value.toDouble();
      }
      if (value is String) {
        final double? parsed = double.tryParse(value);
        if (parsed != null) return parsed;
      }
      throw ApiError(
        errorType: ApiErrorType.conversion,
        errorMessage:
            "Ecosystem Mapping Failure: Cannot safely resolve key '$jsonKey' of type '${value.runtimeType}' to double.",
      );
    };
    return converter;
  }

  /// Extracts a primitive [bool] value from a specific root JSON object key.
  /// Supports native booleans, numeric configurations (1/0), and string values ("true"/"false").
  ///
  /// ### Expected Root JSON Payload Layout Variations:
  /// ```json
  /// { "maintenance": true }
  /// { "maintenance": 1 }
  /// { "maintenance": "true" }
  /// ```
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<bool?> result = await flutterArtistDio.jsonGet(
  ///   "/api/v1/system/maintenance",
  ///   converter: FaJsonConverters.toBoolConverter(jsonKey: "maintenance"),
  /// );
  /// ```
  static FaJsonConverter<bool?> toBoolConverter({
    required String jsonKey,
    bool isOptional = true,
  }) {
    // ignore: prefer_function_declarations_over_variables
    final FaJsonConverter<bool?> converter = (Map<String, dynamic> data) {
      final dynamic value = data[jsonKey];
      if (value == null) {
        if (isOptional) return null;
        throw ApiError(
          errorType: ApiErrorType.conversion,
          errorMessage:
              "Ecosystem Mapping Failure: The targeted JSON key '$jsonKey' is missing or null.",
        );
      }
      if (value is bool) {
        return value;
      }
      if (value is num) {
        if (value == 1) return true;
        if (value == 0) return false;
      }
      if (value is String) {
        final String standardized = value.trim().toLowerCase();
        if (standardized == 'true' || standardized == '1') return true;
        if (standardized == 'false' || standardized == '0') return false;
      }
      throw ApiError(
        errorType: ApiErrorType.conversion,
        errorMessage:
            "Ecosystem Mapping Failure: Cannot safely resolve key '$jsonKey' of type '${value.runtimeType}' to bool.",
      );
    };
    return converter;
  }

  /// Extracts a [DateTime] instance from a specific root JSON object key.
  ///
  /// Supports native ISO 8601 parsing, Unix epoch milliseconds timestamps,
  /// and highly customized pattern layouts. If [isOptional] is set to true,
  /// encountering a null value will return null legally without throwing an exception.
  ///
  /// ### Expected Root JSON Payload Layout Variations:
  /// ```json
  /// { "completedAt": "2026-06-25T14:30:00Z" }       // Case 1: ISO 8601 Standard
  /// { "completedAt": 1782397800000 }                // Case 2: Epoch Milliseconds
  /// { "completedAt": "25/06/2026 14:30:00" }        // Case 3: Custom Layout Pattern
  /// { "completedAt": null }                         // Case 4: Nullable Optional Field
  /// ```
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<DateTime?> result = await flutterArtistDio.jsonGet(
  ///   "/api/v1/projects/status",
  ///   converter: FaJsonConverters.toDateTimeConverter(
  ///     jsonKey: "completedAt",
  ///     pattern: "dd/MM/yyyy HH:mm:ss",
  ///   ),
  /// );
  /// ```
  static FaJsonConverter<DateTime?> toDateTimeConverter({
    required String jsonKey,
    String? pattern,
    bool isOptional = true,
  }) {
    // ignore: prefer_function_declarations_over_variables
    final FaJsonConverter<DateTime?> converter = (Map<String, dynamic> data) {
      final dynamic value = data[jsonKey];
      if (value == null) {
        if (isOptional) return null;
        throw ApiError(
          errorType: ApiErrorType.conversion,
          errorMessage:
              "Ecosystem Mapping Failure: The targeted JSON key '$jsonKey' is missing or null.",
        );
      }

      if (value is int) {
        return DateTime.fromMillisecondsSinceEpoch(value);
      }

      if (value is String) {
        final String standardized = value.trim();
        if (standardized.isEmpty) {
          if (isOptional) return null;
          throw ApiError(
            errorType: ApiErrorType.conversion,
            errorMessage:
                "Ecosystem Mapping Failure: Cannot parse an empty string from key '$jsonKey' into DateTime.",
          );
        }

        if (pattern != null && pattern.isNotEmpty) {
          try {
            return DateFormat(pattern).parse(standardized);
          } catch (e) {
            throw ApiError(
              errorType: ApiErrorType.conversion,
              errorMessage:
                  "Ecosystem Mapping Failure: Failed to parse key '$jsonKey' with string '$standardized' using pattern '$pattern'. Details: $e",
            );
          }
        }

        final DateTime? parsedNative = DateTime.tryParse(standardized);
        if (parsedNative != null) return parsedNative;
      }

      throw ApiError(
        errorType: ApiErrorType.conversion,
        errorMessage:
            "Ecosystem Mapping Failure: Cannot safely resolve key '$jsonKey' of type '${value.runtimeType}' to DateTime.",
      );
    };
    return converter;
  }

  /// Extracts a specialized date-only [DateTime] instance from a specific root JSON object key,
  /// stripping out time metrics and normalizing the value to midnight (00:00:00.000).
  ///
  /// ### Expected Root JSON Payload Layout:
  /// ```json
  /// {
  ///   "expiredDate": "2026-06-25"
  /// }
  /// ```
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<DateTime?> result = await flutterArtistDio.jsonGet(
  ///   "/api/v1/contracts/milestone",
  ///   converter: FaJsonConverters.toDateConverter(jsonKey: "expiredDate", pattern: "yyyy-MM-dd"),
  /// );
  /// ```
  static FaJsonConverter<DateTime?> toDateConverter({
    required String jsonKey,
    String? pattern,
    bool isOptional = true,
  }) {
    final FaJsonConverter<DateTime?> baseDateTimeConverter =
        toDateTimeConverter(
          jsonKey: jsonKey,
          pattern: pattern,
          isOptional: isOptional,
        );
    // ignore: prefer_function_declarations_over_variables
    final FaJsonConverter<DateTime?> converter = (Map<String, dynamic> data) {
      final DateTime? fullDateTime = baseDateTimeConverter(data);
      if (fullDateTime == null) return null;
      return DateTime(fullDateTime.year, fullDateTime.month, fullDateTime.day);
    };
    return converter;
  }
}

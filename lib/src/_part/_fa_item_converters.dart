part of '../../flutter_artist_core.dart';

/// A centralized utility ledger repository containing pre-built, production-grade
/// [FaItemConverter] implementations for primitive Dart types and dynamic mapping layouts.
class FaItemConverters {
  FaItemConverters._();

  /// A strict primitive [String] data converter instance.
  /// Throws an [ApiError] if the incoming data payload is null or cannot be stringified.
  ///
  /// ### Expected JSON Payload Layout (When used via jsonGet):
  /// ```json
  /// "Ecosystem Active"
  /// ```
  ///
  /// ### Expected JSON Payload Layout (When used via jsonGetList):
  /// ```json
  /// {
  ///   "items": ["USD", "EUR", "JPY"]
  /// }
  /// ```
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<ListData<String>> result = await flutterArtistDio.jsonGetList(
  ///   "/api/v1/projects/tags",
  ///   converter: FaItemConverters.toStringConverter,
  /// );
  /// ```
  // ignore: prefer_function_declarations_over_variables
  static final FaItemConverter<String> toStringConverter = (dynamic data) {
    if (data == null) {
      throw ApiError(
        errorType: ApiErrorType.conversion,
        errorMessage:
            "Primitive Conversion Failure: Encountered null payload while mapping String.",
      );
    }
    return data.toString();
  };

  /// A primitive [int] data converter instance supporting strict integer conversions.
  /// Safely processes numeric strings, decimals (via truncation), and raw integers.
  ///
  /// ### Expected JSON Payload Layout (When used via jsonGet):
  /// ```json
  /// 1024
  /// ```
  ///
  /// ### Expected JSON Payload Layout (When used via jsonGetPage):
  /// ```json
  /// {
  ///   "pagination": {
  ///     "currentPage": 1,
  ///     "pageSize": 20,
  ///     "totalItems": 3,
  ///     "totalPages": 1
  ///   },
  ///   "items": [1024, 2048, 4096]
  /// }
  /// ```
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<PageData<int>> result = await flutterArtistDio.jsonGetPage(
  ///   "/api/v1/systems/active-ids",
  ///   converter: FaItemConverters.toIntConverter,
  /// );
  /// ```
  // ignore: prefer_function_declarations_over_variables
  static final FaItemConverter<int> toIntConverter = (dynamic data) {
    if (data == null) {
      throw ApiError(
        errorType: ApiErrorType.conversion,
        errorMessage:
            "Primitive Conversion Failure: Encountered null payload while mapping int.",
      );
    }
    if (data is num) {
      return data.toInt();
    }
    if (data is String) {
      final int? parsed = int.tryParse(data) ?? double.tryParse(data)?.toInt();
      if (parsed != null) return parsed;
    }
    throw ApiError(
      errorType: ApiErrorType.conversion,
      errorMessage:
          "Primitive Conversion Failure: Cannot safely map runtime type '${data.runtimeType}' to int.",
    );
  };

  /// A primitive [double] data converter instance supporting accurate decimal operations.
  /// Safely handles standard integers and numeric string values.
  ///
  /// ### Expected JSON Payload Layout (When used via jsonGet):
  /// ```json
  /// 0.85
  /// ```
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<double> result = await flutterArtistDio.jsonGet(
  ///   "/api/v1/analytics/ratio",
  ///   converter: FaItemConverters.toDoubleConverter,
  /// );
  /// ```
  // ignore: prefer_function_declarations_over_variables
  static final FaItemConverter<double> toDoubleConverter = (dynamic data) {
    if (data == null) {
      throw ApiError(
        errorType: ApiErrorType.conversion,
        errorMessage:
            "Primitive Conversion Failure: Encountered null payload while mapping double.",
      );
    }
    if (data is num) {
      return data.toDouble();
    }
    if (data is String) {
      final double? parsed = double.tryParse(data);
      if (parsed != null) return parsed;
    }
    throw ApiError(
      errorType: ApiErrorType.conversion,
      errorMessage:
          "Primitive Conversion Failure: Cannot safely map runtime type '${data.runtimeType}' to double.",
    );
  };

  /// A primitive [bool] data converter instance backing system flag operations.
  /// Recognizes native booleans, strict numeric configurations (1/0), and string values ("true"/"false").
  ///
  /// ### Expected JSON Payload Layout Variations (When used via jsonGet):
  /// ```json
  /// true
  /// 1
  /// "true"
  /// ```
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<bool> result = await flutterArtistDio.jsonGet(
  ///   "/api/v1/system/maintenance-mode",
  ///   converter: FaItemConverters.toBoolConverter,
  /// );
  /// ```
  // ignore: prefer_function_declarations_over_variables
  static final FaItemConverter<bool> toBoolConverter = (dynamic data) {
    if (data == null) {
      throw ApiError(
        errorType: ApiErrorType.conversion,
        errorMessage:
            "Primitive Conversion Failure: Encountered null payload while mapping bool.",
      );
    }
    if (data is bool) {
      return data;
    }
    if (data is num) {
      if (data == 1) return true;
      if (data == 0) return false;
    }
    if (data is String) {
      final String standardized = data.trim().toLowerCase();
      if (standardized == 'true' || standardized == '1') return true;
      if (standardized == 'false' || standardized == '0') return false;
    }
    throw ApiError(
      errorType: ApiErrorType.conversion,
      errorMessage:
          "Primitive Conversion Failure: Cannot safely map runtime type '${data.runtimeType}' to bool.",
    );
  };

  /// A flexible [DateTime] data converter factory.
  /// Supports native ISO 8601 parsing, Unix epoch milliseconds timestamps,
  /// and customized pattern layouts matching specific remote server configurations.
  ///
  /// ### Expected JSON Payload Layout Variations (When used via jsonGet):
  /// ```json
  /// "2026-06-25T14:30:00Z"       // Case 1: ISO 8601 Standard Plain Value
  /// 1782397800000                // Case 2: Epoch Milliseconds Plain Value
  /// "25/06/2026 14:30:00"        // Case 3: Custom Layout Pattern Plain Value
  /// ```
  ///
  /// ### Example 1: ISO 8601 or Native Parsing
  /// ```dart
  /// ApiResult<DateTime> result = await flutterArtistDio.jsonGet(
  ///   "/api/v1/system/server-time",
  ///   converter: FaItemConverters.toDateTimeConverter(),
  /// );
  /// ```
  ///
  /// ### Example 2: Custom Date Pattern (Requires 'intl' package rules)
  /// ```dart
  /// ApiResult<DateTime> result = await flutterArtistDio.jsonGet(
  ///   "/api/v1/legacy/created-at",
  ///   converter: FaItemConverters.toDateTimeConverter(pattern: "dd/MM/yyyy HH:mm:ss"),
  /// );
  /// ```
  static FaItemConverter<DateTime> toDateTimeConverter({String? pattern}) {
    return (dynamic data) {
      if (data == null) {
        throw ApiError(
          errorType: ApiErrorType.conversion,
          errorMessage:
              "DateTime Conversion Failure: Encountered null payload while mapping DateTime.",
        );
      }

      if (data is int) {
        return DateTime.fromMillisecondsSinceEpoch(data);
      }

      if (data is String) {
        final String standardized = data.trim();
        if (standardized.isEmpty) {
          throw ApiError(
            errorType: ApiErrorType.conversion,
            errorMessage:
                "DateTime Conversion Failure: Cannot parse an empty string into a valid DateTime.",
          );
        }

        if (pattern != null && pattern.isNotEmpty) {
          try {
            return DateFormat(pattern).parse(standardized);
          } catch (e) {
            throw ApiError(
              errorType: ApiErrorType.conversion,
              errorMessage:
                  "DateTime Conversion Failure: Failed to parse string '$standardized' "
                  "using the customized pattern layout '$pattern'. Details: $e",
            );
          }
        }

        final DateTime? parsedNative = DateTime.tryParse(standardized);
        if (parsedNative != null) {
          return parsedNative;
        }
      }

      throw ApiError(
        errorType: ApiErrorType.conversion,
        errorMessage:
            "DateTime Conversion Failure: Cannot safely resolve runtime type '${data.runtimeType}' "
            "to a valid DateTime container instance.",
      );
    };
  }

  /// A specialized date-only [DateTime] converter factory that strips out time elements,
  /// normalizing the transaction instance to midnight (00:00:00.000).
  ///
  /// ### Expected JSON Payload Layout (When used via jsonGetPage):
  /// ```json
  /// {
  ///   "pagination": {
  ///     "currentPage": 1,
  ///     "pageSize": 2,
  ///     "totalItems": 3,
  ///     "totalPages": 2
  ///   },
  ///   "items": ["2026-06-25", "2026-06-26"]
  /// }
  /// ```
  ///
  /// ### Expected JSON Payload Layout (When used via jsonGetList):
  /// ```json
  /// {
  ///   "items": ["2026-06-25", "2026-06-26"]
  /// }
  /// ```
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<PageData<DateTime>> result = await flutterArtistDio.jsonGetPage(
  ///   "/api/v1/reports/available-days",
  ///   converter: FaItemConverters.toDateConverter(pattern: "yyyy-MM-dd"),
  /// );
  /// ```
  static FaItemConverter<DateTime> toDateConverter({String? pattern}) {
    final FaItemConverter<DateTime> baseDateTimeConverter = toDateTimeConverter(
      pattern: pattern,
    );
    return (dynamic data) {
      final DateTime fullDateTime = baseDateTimeConverter(data)!;
      return DateTime(fullDateTime.year, fullDateTime.month, fullDateTime.day);
    };
  }

  /// Safely transforms a standard [FaJsonConverter] into a production-grade [FaItemConverter]
  /// with defensive runtime validation boundaries.
  ///
  /// This method bridges complex object parsers (such as `json_serializable` factory contexts)
  /// into the universal pipeline architecture. It intercepts type errors cleanly before structural
  /// downcasting defects cause runtime app crashes.
  ///
  /// ### Target Data Model Configuration:
  /// ```dart
  /// @JsonSerializable()
  /// class CurrencyInfo implements Identifiable<String> {
  ///   @override
  ///   @JsonKey(name: 'id')
  ///   String id;
  ///
  ///   @JsonKey(name: 'symbol')
  ///   String symbol;
  ///
  ///   @JsonKey(name: 'name')
  ///   String name;
  ///
  ///   CurrencyInfo(this.id, this.symbol, this.name);
  ///
  ///   factory CurrencyInfo.fromJson(Map<String, dynamic> json) => _$CurrencyInfoFromJson(json);
  ///   Map<String, dynamic> toJson() => _$CurrencyInfoToJson(this);
  /// }
  /// ```
  ///
  /// ### Expected JSON Payload Layout (Paginated Example via jsonGetPage):
  /// ```json
  /// {
  ///   "pagination": {
  ///     "currentPage": 1,
  ///     "pageSize": 2,
  ///     "totalItems": 3,
  ///     "totalPages": 2
  ///   },
  ///   "items": [
  ///     {
  ///       "id": "USD",
  ///       "symbol": "$",
  ///       "name": "US Dollar"
  ///     }
  ///   ]
  /// }
  /// ```
  ///
  /// ### Expected JSON Payload Layout (Flat Collection Example via jsonGetList):
  /// ```json
  /// {
  ///   "items": [
  ///     {
  ///       "id": "USD",
  ///       "symbol": "$",
  ///       "name": "US Dollar"
  ///     }
  ///   ]
  /// }
  /// ```
  ///
  /// ### User Integration Options:
  ///
  /// Developers have two distinct approaches to execute data conversions depending on
  /// their architectural preferences and IDE Autocomplete Intelligence support:
  ///
  /// #### Approach 1: Using the Centralized Static Factory Method
  /// *Wraps the function reference directly. Highly recommended for immediate IDE code completion suggestions.*
  /// ```dart
  /// ApiResult<PageData<CurrencyInfo>> result = await flutterArtistDio.jsonGetPage(
  ///   "/rest/page/currency-info/search",
  ///   queryParameters: queryParameters,
  ///   converter: FaItemConverters.fromJsonConverter(CurrencyInfo.fromJson),
  /// );
  /// ```
  ///
  /// #### Approach 2: Using the Explicit Extension Utility Macro
  /// *Invokes the method directly via constructor tear-off extensions.*
  /// ```dart
  /// // Option A: Via constant assignments (IDE Autocomplete works perfectly)
  /// const FaJsonConverter<CurrencyInfo> currencyInfoConverter = CurrencyInfo.fromJson;
  ///
  /// ApiResult<CurrencyInfo> result = await flutterArtistDio.jsonGet(
  ///   "/rest/record/currency-data/USD",
  ///   converter: currencyInfoConverter.toItemConverter(),
  /// );
  ///
  /// // Option B: Via direct inline call (Compilation succeeds, but IDE Autocomplete might vary)
  /// ApiResult<CurrencyInfo> result = await flutterArtistDio.jsonGet(
  ///   "/rest/record/currency-data/USD",
  ///   converter: CurrencyInfo.fromJson.toItemConverter(),
  /// );
  /// ```
  static FaItemConverter<D?> fromJsonConverter<D>(
    FaJsonConverter<D> jsonConverter,
  ) {
    // ignore: prefer_function_declarations_over_variables
    final FaItemConverter<D?> converter = (data) {
      // FIX: Safe boundary shortcut shield for null payloads
      if (data == null) return null;
      if (data is! Map<String, dynamic>) {
        throw ApiError(
          errorType: ApiErrorType.invalidJson,
          errorMessage:
              "Ecosystem Structural Transformation Exception: Expected a "
              "Map<String, dynamic> object layout schema, but encountered runtime type: ${data.runtimeType}",
        );
      }
      return jsonConverter(data);
    };
    return converter;
  }
}

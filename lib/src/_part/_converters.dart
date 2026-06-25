part of '../../flutter_artist_core.dart';

typedef FaDataConverter<D> = D? Function(dynamic);

typedef FaJsonConverter<D> = D? Function(Map<String, dynamic> json);

extension FaDataConverterX<D> on FaJsonConverter<D> {
  /// Safely wraps a standard [FaJsonConverter] into a global [FaDataConverter]
  /// by verifying the concrete payload configuration signature at runtime.
  FaDataConverter<D> toDataConverter() {
    return (data) {
      if (data is! Map<String, dynamic>) {
        throw ApiError(
          errorType: ApiErrorType.invalidJson,
          errorMessage:
              "Ecosystem Structural Transformation Exception: Expected a "
              "Map<String, dynamic> object layout schema, but encountered runtime type: ${data.runtimeType}",
        );
      }
      return this(data);
    };
  }
}

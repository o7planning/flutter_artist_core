import '../_docs/fa_documents.dart';

class FlutterArtistDocSystem {
  static const String allDocsJSON =
      "https://o7planning.github.io/static/docs/all-docs.json";
  static final FlutterArtistDocSystem instance = FlutterArtistDocSystem._();

  FaDocuments? _faDocuments;

  FlutterArtistDocSystem._();

  Future<FaDocuments> get faDocuments async {
    if (_faDocuments != null && _faDocuments!.documents.isNotEmpty) {
      return _faDocuments!;
    }
    _faDocuments = await FaDocuments.fromUrl(url: allDocsJSON);
    return _faDocuments!;
  }
}

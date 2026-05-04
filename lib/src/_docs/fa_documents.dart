import 'dart:convert';

import 'package:flutter/services.dart';

import 'fa_document.dart';

class FaDocuments {
  final List<FaDocument> documents;

  FaDocuments._({required this.documents});

  /// Parse from raw JSON string.
  /// If an item is invalid, it will be silently skipped.
  factory FaDocuments.fromJson({required String json}) {
    List<FaDocument> validDocuments = [];
    try {
      final dynamic decoded = jsonDecode(json);
      if (decoded is List) {
        for (var item in decoded) {
          try {
            if (item is Map<String, dynamic>) {
              validDocuments.add(FaDocument.fromMap(item));
            }
          } catch (e) {
            // Skip invalid document items silently to maintain stability
            print('FlutterArtist Warning: Skipping invalid document item: $e');
          }
        }
      }
    } catch (e) {
      print('FlutterArtist Error: Failed to parse FaDocuments JSON: $e');
    }
    return FaDocuments._(documents: validDocuments);
  }

  /// Load documents from a local assets path.
  static Future<FaDocuments> fromAssetsPath({
    required String fullPathWithPkgName,
  }) async {
    try {
      final String jsonContent = await rootBundle.loadString(
        fullPathWithPkgName,
      );
      return FaDocuments.fromJson(json: jsonContent);
    } catch (e, stackTrace) {
      print("ERROR: $e\n$stackTrace");
      return FaDocuments._(documents: []);
    }
  }

  /// NEW: Load documents from a remote URL.
  /// Useful for dynamic updates without re-building the app.
  // static Future<FaDocuments> fromUrl({required String url}) async {
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       return FaDocuments.fromJson(json: response.body);
  //     } else {
  //       print(
  //         'FlutterArtist Error: Remote docs returned status ${response.statusCode}',
  //       );
  //       return FaDocuments._(documents: []);
  //     }
  //   } catch (e) {
  //     print('FlutterArtist Error: Failed to fetch remote docs: $e');
  //     return FaDocuments._(documents: []);
  //   }
  // }
}

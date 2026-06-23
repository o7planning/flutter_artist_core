part of '../../flutter_artist_core.dart';

/// Defines the structural mapping layout for paginated JSON payloads.
class PageMapping {
  final String itemsKey;
  final String paginationKey;
  final PaginationDetailKeys paginationDetailKeys;

  const PageMapping({
    this.itemsKey = 'items',
    this.paginationKey = 'pagination',
    this.paginationDetailKeys = const PaginationDetailKeys(),
  });
}

part of '../../flutter_artist_core.dart';

/// Explicitly maps the internal primitive fields of the pagination object.
class PaginationDetailKeys {
  final String currentPage;
  final String pageSize;
  final String totalItems;
  final String totalPages;

  const PaginationDetailKeys({
    this.currentPage = 'currentPage',
    this.pageSize = 'pageSize',
    this.totalItems = 'totalItems',
    this.totalPages = 'totalPages',
  });
}

part of '../../flutter_artist_core.dart';

interface class PaginationData {
  final int _currentPage;
  final int _pageSize;
  final int _totalItems;
  final int _totalPages;

  PaginationData({
    required int currentPage,
    required int pageSize,
    required int totalItems,
    required int totalPages,
  }) : _currentPage = currentPage,
       _pageSize = pageSize,
       _totalItems = totalItems,
       _totalPages = totalPages;

  PaginationData.empty()
    : _currentPage = 1,
      _pageSize = 0,
      _totalItems = 0,
      _totalPages = 0;

  int get currentPage => _currentPage;

  int get pageSize => _pageSize;

  int get totalItems => _totalItems;

  int get totalPages => _totalPages;

  static PaginationData? copy(PaginationData? source) {
    return source == null
        ? null
        : PaginationData(
          currentPage: source.currentPage,
          pageSize: source.pageSize,
          totalItems: source.totalItems,
          totalPages: source.totalPages,
        );
  }

  @override
  String toString() {
    return "${runtimeType.toString()}[$currentPage,$pageSize,$totalItems,$totalPages]";
  }
}

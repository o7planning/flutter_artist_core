part of '../../flutter_artist_core.dart';

interface class PaginationInfo {
  final int _currentPage;
  final int _pageSize;
  final int _totalItems;
  final int _totalPages;

  int get currentPage => _currentPage;

  int get pageSize => _pageSize;

  int get totalItems => _totalItems;

  int get totalPages => _totalPages;

  PaginationInfo({
    required int currentPage,
    required int pageSize,
    required int totalItems,
    required int totalPages,
  }) : _currentPage = currentPage,
       _pageSize = pageSize,
       _totalItems = totalItems,
       _totalPages = totalPages;

  PaginationInfo.empty()
    : _currentPage = 1,
      _pageSize = 0,
      _totalItems = 0,
      _totalPages = 0;

  static PaginationInfo? copy(PaginationInfo? source) {
    return source == null
        ? null
        : PaginationInfo(
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

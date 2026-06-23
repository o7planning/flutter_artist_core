part of '../../flutter_artist_core.dart';

class PaginationInfo {
  final int currentPage;
  final int pageSize;
  final int totalItems;
  final int totalPages;

  PaginationInfo({
    required this.currentPage,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
  });

  PaginationInfo.empty()
    : currentPage = 1,
      pageSize = 0,
      totalItems = 0,
      totalPages = 0;

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

part of '../../flutter_artist_core.dart';

// Docs: 14739/15a
class Pageable {
  final int page;
  final int? pageSize;

  const Pageable({this.page = 1, required this.pageSize}) : assert(page > 0);

  Pageable copy() {
    return Pageable(page: page, pageSize: pageSize);
  }

  Pageable next() {
    return Pageable(page: page + 1, pageSize: pageSize);
  }

  Pageable? previous() {
    if (page < 2) {
      return null;
    }
    return Pageable(page: page - 1, pageSize: pageSize);
  }

  @override
  String toString() {
    return "PageableData[page: $page, pageSize: $pageSize]";
  }
}

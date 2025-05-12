part of '../../flutter_artist_core.dart';

class PageableData {
  final int page;
  final int? pageSize;

  const PageableData({
    this.page = 1,
    required this.pageSize,
  }) : assert(page > 0);

  PageableData copy() {
    return PageableData(page: page, pageSize: pageSize);
  }

  PageableData next() {
    return PageableData(page: page + 1, pageSize: pageSize);
  }

  PageableData? previous() {
    if (page < 2) {
      return null;
    }
    return PageableData(page: page - 1, pageSize: pageSize);
  }

  @override
  String toString() {
    return "PageableData[page: $page, pageSize: $pageSize]";
  }
}

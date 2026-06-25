part of '../../flutter_artist_core.dart';


class PageData<ITEM> {
  final List<ITEM> items;
  final PaginationInfo? paginationInfo;

  // PageData( ): items: [] ,paginationInfo: PaginationInfo.empty() ) ;

  const PageData({required this.items, required this.paginationInfo});

  factory PageData.empty() =>
      PageData(items: const [], paginationInfo: PaginationInfo.empty());

  factory PageData.calculate({
    required int currentPage,
    required int pageSize,
    required List<ITEM> allItems,
  }) {
    currentPage = currentPage < 1 ? 1 : currentPage;
    //
    final int totalItems = allItems.length;

    PaginationInfo paginationInfo;
    int totalPages;
    List<ITEM> items;
    if (pageSize <= 0) {
      totalPages = 1;
      if (currentPage > 1) {
        items = [];
      } else {
        items = allItems;
      }
      paginationInfo = PaginationInfo(
        currentPage: currentPage,
        pageSize: pageSize,
        totalItems: totalItems,
        totalPages: totalPages,
      );
    } else {
      if (totalItems % pageSize == 0) {
        totalPages = totalItems ~/ pageSize;
      } else {
        totalPages = totalItems ~/ pageSize + 1;
      }
      paginationInfo = PaginationInfo(
        currentPage: currentPage,
        pageSize: pageSize,
        totalItems: totalItems,
        totalPages: totalPages,
      );
      int start = (currentPage - 1) * pageSize;
      int end = currentPage * pageSize;
      if (start > allItems.length - 1) {
        items = [];
      } else {
        items = allItems.sublist(start, min(allItems.length, end));
      }
    }
    //
    return PageData(paginationInfo: paginationInfo, items: items);
  }

  factory PageData.ofItem(ITEM item) {
    final items = [item];
    final paginationInfo = PaginationInfo(
      currentPage: 1,
      pageSize: 1,
      totalItems: 1,
      totalPages: 1,
    );
    return PageData(items: items, paginationInfo: paginationInfo);
  }

  factory PageData.ofItems(List<ITEM> items) {
    final paginationInfo = PaginationInfo(
      currentPage: 1,
      pageSize: items.length,
      totalItems: items.length,
      totalPages: 1,
    );
    return PageData(items: items, paginationInfo: paginationInfo);
  }

  PageData<F> convert<F>({required F Function(ITEM data) converter}) {
    List<F> fItems = items.map((item) => converter(item)).toList();
    return PageData(paginationInfo: paginationInfo, items: fItems);
  }

  ListData<ITEM> toListData() => ListData<ITEM>(items: items);
}

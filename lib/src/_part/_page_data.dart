part of '../../flutter_artist_core.dart';

abstract class PageData<ITEM> {
  List<ITEM> get items;

  PaginationInfo? get paginationInfo;

  PageData();

  factory PageData.calculate({
    required int currentPage,
    required int pageSize,
    required List<ITEM> allItems,
  }) {
    return DefaultPageData.calculate(
      currentPage: currentPage,
      pageSize: pageSize,
      allItems: allItems,
    );
  }

  factory PageData.empty() {
    return DefaultPageData.items(items: []);
  }

  factory PageData.ofItem(ITEM item) {
    return DefaultPageData.item(item: item);
  }

  factory PageData.ofItems(List<ITEM> items) {
    return DefaultPageData.items(items: items);
  }

  PageData<F> convert<F>({required F Function(ITEM data) converter}) {
    List<F> fItems = items.map((item) => converter(item)).toList();
    return DefaultPageData(paginationInfo: paginationInfo, items: fItems);
  }
}

class DefaultPageData<I> extends PageData<I> {
  final List<I> _items;
  final PaginationInfo? _paginationInfo;

  @override
  List<I> get items => [..._items];

  @override
  PaginationInfo? get paginationInfo => _paginationInfo;

  DefaultPageData({
    required List<I> items,
    required PaginationInfo? paginationInfo,
  }) : _items = items,
       _paginationInfo = paginationInfo;

  DefaultPageData.items({required List<I> items})
    : _items = items,
      _paginationInfo = PaginationInfo(
        currentPage: 1,
        pageSize: items.length,
        totalItems: items.length,
        totalPages: 1,
      );

  DefaultPageData.item({required I item})
    : _items = [item],
      _paginationInfo = PaginationInfo(
        currentPage: 1,
        pageSize: 1,
        totalItems: 1,
        totalPages: 1,
      );

  DefaultPageData.empty()
    : _items = [],
      _paginationInfo = PaginationInfo(
        currentPage: 1,
        pageSize: 1,
        totalItems: 0,
        totalPages: 0,
      );

  factory DefaultPageData.calculate({
    required int currentPage,
    required int pageSize,
    required List<I> allItems,
  }) {
    currentPage = currentPage < 1 ? 1 : currentPage;
    //
    final int totalItems = allItems.length;
    int totalPages;
    if (totalItems % pageSize == 0) {
      totalPages = totalItems ~/ pageSize;
    } else {
      totalPages = totalItems ~/ pageSize + 1;
    }
    //
    PaginationInfo paginationInfo = PaginationInfo(
      currentPage: currentPage,
      pageSize: pageSize,
      totalItems: totalItems,
      totalPages: totalPages,
    );
    int start = (currentPage - 1) * pageSize;
    int end = currentPage * pageSize;
    List<I> items;
    if (start > allItems.length - 1) {
      items = [];
    } else {
      items = allItems.sublist(start, min(allItems.length, end));
    }

    return DefaultPageData(paginationInfo: paginationInfo, items: items);
  }
}

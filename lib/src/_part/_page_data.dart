part of '../../flutter_artist_core.dart';

abstract class PageData<ITEM> {
  List<ITEM> get items;

  PaginationInfo? get paginationInfo;

  PageData();

  factory PageData.empty() {
    return DefaultPageData.items(items: []);
  }

  factory PageData.ofItem(ITEM item) {
    return DefaultPageData.item(item: item);
  }

  factory PageData.ofItems(List<ITEM> items) {
    return DefaultPageData.items(items: items);
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
}

part of '../../flutter_artist_core.dart';

abstract class PageData<ITEM> {
  List<ITEM> get items;

  PaginationData? get pagination;

  static PageData<ITEM> empty<ITEM>() {
    return DefaultPageData.items(items: []);
  }

  static PageData<ITEM> ofItem<ITEM>(ITEM item) {
    return DefaultPageData.item(item: item);
  }

  static PageData<ITEM> ofItems<ITEM>(List<ITEM> items) {
    return DefaultPageData.items(items: items);
  }
}

class DefaultPageData<I> extends PageData<I> {
  final List<I> _items;
  final PaginationData? _pagination;

  @override
  List<I> get items => [..._items];

  @override
  PaginationData? get pagination => _pagination;

  DefaultPageData({required List<I> items, required PaginationData? pagination})
    : _items = items,
      _pagination = pagination;

  DefaultPageData.items({required List<I> items})
    : _items = items,
      _pagination = PaginationData(
        currentPage: 1,
        pageSize: items.length,
        totalItems: items.length,
        totalPages: 1,
      );

  DefaultPageData.item({required I item})
    : _items = [item],
      _pagination = PaginationData(
        currentPage: 1,
        pageSize: 1,
        totalItems: 1,
        totalPages: 1,
      );

  DefaultPageData.empty()
    : _items = [],
      _pagination = PaginationData(
        currentPage: 1,
        pageSize: 1,
        totalItems: 0,
        totalPages: 0,
      );
}

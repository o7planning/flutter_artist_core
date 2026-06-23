part of '../../flutter_artist_core.dart';

/// The foundational contract representing a flat collection of items from the server.
class ListData<ITEM> {
  final List<ITEM> items;

  const ListData({required this.items});

  factory ListData.empty() => ListData(items: const []);

  factory ListData.ofItem(ITEM item) {
    return ListData(items: [item]);
  }

  PageData<ITEM> toPageData() => PageData<ITEM>.calculate(
    currentPage: 1,
    pageSize: items.length,
    allItems: items,
  );
}

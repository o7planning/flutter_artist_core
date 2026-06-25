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

  ListData<F> convert<F>({required F Function(ITEM data) converter}) {
    List<F> fItems = items.map((item) => converter(item)).toList();
    return ListData(items: fItems);
  }

  /// Filters the underlying items collection using a predictive verification [test] constraint,
  /// then wraps the filtered results into a clean, new [ListData<ITEM>] envelope.
  ///
  /// This mirrors the native Dart [Iterable.where] behavior but eagerly materializes
  /// the collections boundary into an enterprise-grade contract wrapper.
  ///
  /// ### Example:
  /// ```dart
  /// ListData<EmployeeInfo> employees = getActiveEmployees();
  /// ListData<EmployeeInfo> managers = employees.where((emp) => emp.role == 'MANAGER');
  /// ```
  ListData<ITEM> where(bool Function(ITEM element) test) {
    final List<ITEM> foundItems = items.where(test).toList();
    return ListData<ITEM>(items: foundItems);
  }
}

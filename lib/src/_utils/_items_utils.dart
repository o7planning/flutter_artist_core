part of '../../flutter_artist_core.dart';

class ItemsUtils {
  static int getFirstIndexOfItemById<ITEM, ID>({
    required ID? itemId,
    required List<ITEM> targetList,
    required ID Function(ITEM item) getItemId,
  }) {
    if (itemId == null) {
      return -1;
    }
    int idx = targetList.indexWhere((it) => getItemId(it) == itemId);
    return idx;
  }

  static bool swapPositionsByIds<ITEM, ID>({
    required ID itemId1,
    required ID itemId2,
    required List<ITEM> targetList,
    required ID Function(ITEM item) getItemId,
  }) {
    int idx1 = getFirstIndexOfItemById(
      itemId: itemId1,
      targetList: targetList,
      getItemId: getItemId,
    );
    int idx2 = getFirstIndexOfItemById(
      itemId: itemId2,
      targetList: targetList,
      getItemId: getItemId,
    );
    if (idx1 == -1 || idx2 == -1 || idx1 == idx2) {
      return false;
    }
    ITEM item1 = targetList[idx1];
    ITEM item2 = targetList[idx2];
    targetList[idx1] = item2;
    targetList[idx2] = item1;
    return true;
  }

  static bool moveItemToNewIndexPosition<ITEM, ID>({
    required ITEM item,
    required int newIndexPosition,
    required List<ITEM> targetList,
    required ID Function(ITEM item) getItemId,
  }) {
    if (newIndexPosition < 0 || newIndexPosition > targetList.length - 1) {
      return false;
    }
    ID itemId = getItemId(item);
    int idx = getFirstIndexOfItemById(
      itemId: itemId,
      targetList: targetList,
      getItemId: getItemId,
    );
    if (idx < 0 || idx == newIndexPosition) {
      return false;
    }
    ITEM it = targetList.removeAt(idx);
    targetList.insert(newIndexPosition, it);
    return true;
  }

  static bool moveItemByIndexPosition<ITEM, ID>({
    required int oldIndexPosition,
    required int newIndexPosition,
    required List<ITEM> targetList,
    required ID Function(ITEM item) getItemId,
  }) {
    if (oldIndexPosition < 0 ||
        oldIndexPosition > targetList.length - 1 ||
        newIndexPosition < 0 ||
        newIndexPosition > targetList.length - 1) {
      return false;
    }
    if (oldIndexPosition == newIndexPosition) {
      return false;
    }
    ITEM it = targetList.removeAt(oldIndexPosition);
    targetList.insert(newIndexPosition, it);
    return true;
  }

  static ITEM? findItemInListById<ITEM, ID>({
    required ID? id,
    required List<ITEM> targetList,
    required ID Function(ITEM item) getItemId,
  }) {
    if (id == null) {
      return null;
    }
    for (ITEM item in targetList) {
      if (getItemId(item) == id) {
        return item;
      }
    }
    return null;
  }

  static ITEM? findItemInList<ITEM, ID>({
    required ITEM? item,
    required List<ITEM> targetList,
    required ID Function(ITEM item) getItemId,
  }) {
    if (item == null) {
      return null;
    }
    ID id = getItemId(item);
    return findItemInListById(
      id: id,
      targetList: targetList,
      getItemId: getItemId,
    );
  }

  static List<ITEM> findItemsInList<ITEM, ID>({
    required List<ITEM?>? items,
    required List<ITEM> targetList,
    required ID Function(ITEM item) getItemId,
  }) {
    List<ITEM> ret = [];
    for (ITEM? item in items ?? []) {
      if (item == null) {
        continue;
      }
      ITEM? found = findItemInList(
        item: item,
        targetList: targetList,
        getItemId: getItemId,
      );
      if (found != null) {
        ret.add(found);
      }
    }
    return ret;
  }

  static List<ITEM> findItemsInListByIds<ITEM, ID>({
    required List<ID?>? itemIds,
    required List<ITEM> targetList,
    required ID Function(ITEM item) getItemId,
  }) {
    List<ITEM> ret = [];
    for (ID? itemId in itemIds ?? []) {
      if (itemId == null) {
        continue;
      }
      ITEM? found = findItemInListById(
        id: itemId,
        targetList: targetList,
        getItemId: getItemId,
      );
      if (found != null) {
        ret.add(found);
      }
    }
    return ret;
  }

  static List<ITEM> findItemsInListByDynamics<ITEM, ID>({
    required List<dynamic>? dynamicValues,
    required List<ITEM> targetList,
    required ID Function(ITEM item) getItemId,
  }) {
    if (dynamicValues == null) {
      return [];
    }
    List<ITEM> items = dynamicValues.whereType<ITEM>().toList();
    return findItemsInList(
      items: items,
      targetList: targetList,
      getItemId: getItemId,
    );
  }

  static void removeItemsFromList<ITEM, ID>({
    required List<ITEM> removeItems,
    required List<ITEM> targetList,
    required ID Function(ITEM item) getItemId,
  }) {
    for (ITEM removeItem in removeItems) {
      removeItemFromList(
        removeItem: removeItem,
        targetList: targetList,
        getItemId: getItemId,
      );
    }
  }

  static void removeItemFromList<ITEM, ID>({
    required ITEM removeItem,
    required List<ITEM> targetList,
    required ID Function(ITEM item) getItemId,
  }) {
    int idx = targetList.indexWhere((it) {
      return getItemId(it) == getItemId(removeItem);
    });
    if (idx != -1) {
      targetList.removeAt(idx);
    }
  }

  static void insertOrReplaceItemInList<ITEM, ID>({
    required ITEM item,
    required List<ITEM> targetList,
    required ID Function(ITEM item) getItemId,
  }) {
    int idx = targetList.indexWhere((it) {
      return getItemId(it) == getItemId(item);
    });
    if (idx == -1) {
      targetList.insert(0, item);
    } else {
      targetList[idx] = item;
    }
  }

  static void insertOrReplaceItemsInList<ITEM, ID>({
    required List<ITEM> items,
    required List<ITEM> targetList,
    required ID Function(ITEM item) getItemId,
  }) {
    for (ITEM item in items) {
      insertOrReplaceItemInList(
        item: item,
        targetList: targetList,
        getItemId: getItemId,
      );
    }
  }

  static void replaceItemInList<ITEM, ID>({
    required ITEM replacementItem,
    required List<ITEM> targetList,
    required ID Function(ITEM item) getItemId,
  }) {
    int idx = targetList.indexWhere((it) {
      return getItemId(it) == getItemId(replacementItem);
    });
    if (idx != -1) {
      targetList[idx] = replacementItem;
    }
  }

  static void replaceItemsInList<ITEM, ID>({
    required List<ITEM> replacementItems,
    required List<ITEM> targetList,
    required ID Function(ITEM item) getItemId,
  }) {
    for (ITEM replacementItem in replacementItems) {
      replaceItemInList(
        replacementItem: replacementItem,
        targetList: targetList,
        getItemId: getItemId,
      );
    }
  }

  static ITEM? findNextSiblingItemInList<ITEM, ID>({
    required List<ITEM> targetList,
    required ITEM item,
    required ID Function(ITEM item) getItemId,
  }) {
    int idx = targetList.indexWhere((e) {
      return getItemId(e) == getItemId(item);
    });
    if (idx == -1) {
      return null;
    } else {
      if (idx + 1 < targetList.length) {
        return targetList[idx + 1];
      }
      return null;
    }
  }

  static ITEM? findPreviousSiblingItemInList<ITEM, ID>({
    required List<ITEM> targetList,
    required ITEM item,
    required ID Function(ITEM item) getItemId,
  }) {
    int idx = targetList.indexWhere((e) {
      return getItemId(e) == getItemId(item);
    });
    if (idx == -1) {
      return null;
    } else {
      if (idx - 1 >= 0) {
        return targetList[idx - 1];
      }
      return null;
    }
  }

  static ITEM? findSiblingItemInList<ITEM, ID>({
    required List<ITEM> targetList,
    required ITEM item,
    required ID Function(ITEM item) getItemId,
  }) {
    int idx = targetList.indexWhere((e) {
      return getItemId(e) == getItemId(item);
    });
    if (idx == -1) {
      if (targetList.isNotEmpty) {
        return targetList[0];
      }
      return null;
    } else {
      if (idx + 1 < targetList.length) {
        return targetList[idx + 1];
      } else if (idx - 1 >= 0) {
        return targetList[idx - 1];
      }
      return null;
    }
  }

  ///
  /// Append items to targetList.
  ///
  static void appendItemsToList<ITEM, ID>({
    required List<ITEM> appendItems,
    required List<ITEM> targetList,
    required ID Function(ITEM item) getItemId,
  }) {
    List<ITEM> all = [];
    List<ITEM> tailItems = [...appendItems];
    for (ITEM item in targetList) {
      ITEM? it = findItemInList(
        targetList: appendItems,
        item: item,
        getItemId: getItemId,
      );
      if (it != null) {
        all.add(it);
        tailItems.remove(it);
      } else {
        all.add(item);
      }
    }
    all.addAll(tailItems);
    //
    targetList
      ..clear()
      ..addAll(all);
  }

  static bool isListContainItem<ITEM, ID>({
    required ITEM item,
    required List<ITEM> targetList,
    required ID Function(ITEM it) getItemId,
  }) {
    ID itemId = getItemId(item);
    return findItemInListById(
          id: itemId,
          targetList: targetList,
          getItemId: getItemId,
        ) !=
        null;
  }

  static bool isListContainItems<ITEM, ID>({
    required List<ITEM> items,
    required List<ITEM> targetList,
    required ID Function(ITEM it) getItemId,
  }) {
    for (ITEM item in items) {
      bool contains = isListContainItem(
        item: item,
        targetList: targetList,
        getItemId: getItemId,
      );
      if (!contains) {
        return false;
      }
    }
    return true;
  }

  static bool isSame<ITEM, ID>({
    required ITEM? item1,
    required ITEM? item2,
    required ID Function(ITEM it) getItemId,
  }) {
    if (item1 == null && item2 == null) {
      return true;
    } else if (item1 == null && item2 != null) {
      return false;
    } else if (item1 != null && item2 == null) {
      return false;
    } else {
      return getItemId(item1!) == getItemId(item2!);
    }
  }

  static void addItemIfNotExists<ITEM, ID>({
    required ITEM item,
    required List<ITEM> targetList,
    required ID Function(ITEM it) getItemId,
  }) {
    int idx = targetList.indexWhere((it) {
      return getItemId(it) == getItemId(item);
    });
    if (idx == -1) {
      targetList.add(item);
    }
  }

  static void replaceOrInsertItem<ITEM, ID>({
    required ITEM newItem,
    required List<ITEM> targetList,
    required ID Function(ITEM it) getItemId,
  }) {
    int idx = targetList.indexWhere((item) {
      return getItemId(item) == getItemId(newItem);
    });
    if (idx != -1) {
      targetList[idx] = newItem;
    } else {
      targetList.insert(0, newItem);
    }
  }

  static void removeItemById<ITEM, ID>({
    required ID id,
    required List<ITEM> targetList,
    required ID Function(ITEM it) getItemId,
  }) {
    targetList.removeWhere((it) => getItemId(it) == id);
  }

  static List<ITEM> removeDuplicatedItems<ITEM, ID>({
    required List<ITEM> items,
    required ID Function(ITEM it) getItemId,
  }) {
    Map<ID, ITEM> map = {};
    for (ITEM it in items) {
      map[getItemId(it)] = it;
    }
    return [...map.values];
  }
}

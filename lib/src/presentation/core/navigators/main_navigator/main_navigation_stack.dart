import 'dart:collection';
import 'package:flutter/widgets.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/presentation/core/navigators/main_navigator/main_navigation_stack_item.dart';

final mainNavigationStackProvider = ChangeNotifierProvider((ref) => MainNavigationStack([
  MainNavigationStackItem.usersList()
]));

class MainNavigationStack with ChangeNotifier {
  List<MainNavigationStackItem> _items;
  MainNavigationStack(List<MainNavigationStackItem> items) : _items = List.of(items); 

  UnmodifiableListView<MainNavigationStackItem> get items => UnmodifiableListView(_items);
  set items(List<MainNavigationStackItem> newItems) {
    _items = List.from(newItems);
    notifyListeners();
  }

  void push(MainNavigationStackItem item) {
    _items.add(item);
    notifyListeners();
  }

  MainNavigationStackItem? pop() {
    try {
      final poppedItem = _items.removeLast();
      notifyListeners();
      return poppedItem;
    } catch (e) {
      return null;
    }
  }
}
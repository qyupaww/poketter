import 'package:flutter/material.dart';

import 'paging_state.dart';

/// A controller for managing paging state in a Flutter application.
///
/// This controller extends [ValueNotifier] to notify listeners about changes
/// in the paging state. It provides various methods to manipulate the paging
/// state, such as adding, removing, or updating items, and handling loading
/// and error states.
///
/// Example:
///
/// ```dart
/// final pagingController = PagingController<int>();
///
/// pagingController.addListener(() {
///   print('Paging state updated: ${pagingController.value}');
/// });
///
/// pagingController.appendItems([1, 2, 3]);
/// ```
class PagingController<T> extends ValueNotifier<PagingState<T>> {
  /// Creates a [PagingController] with an initial loading state.
  PagingController() : super(PagingState(increment: 1, isLoading: true));

  bool _disposed = false;

  /// Resets the paging state, incrementing the page counter.
  void reset() {
    value = PagingState(increment: value.increment + 1);
  }

  /// Sets the loading state to true.
  void setLoading() {
    value = value.copyWith(isLoading: true);
  }

  /// Updates an existing item in the list with a new item.
  ///
  /// [oldItem] is the item to be replaced, and [newItem] is the item to replace it with.
  void updateItem({required T oldItem, required T newItem}) {
    final indexOfItem = value.items.indexOf(oldItem);
    final List<T> list = List.from(value.items);
    list[indexOfItem] = newItem;
    value = value.copyWith(items: list);
  }

  /// Removes an item from the list.
  ///
  /// [item] is the item to be removed.
  void removeItem({required T item}) {
    final List<T> list = List.from(value.items)..remove(item);
    value = value.copyWith(items: list);
  }

  /// Replaces the current list of items with a new list.
  ///
  /// [items] is the new list of items. [nextPage] indicates if the next page
  /// should be loaded, and [isLastPage] indicates if this is the last page.
  void replaceItems({
    required List<T> items,
    bool nextPage = false,
    bool? isLastPage,
  }) {
    value = value.copyWith(
      items: items,
      isLoading: false,
      page: nextPage && !(isLastPage ?? false) ? value.page + 1 : value.page,
      isLastPage: isLastPage,
    );
  }

  /// Inserts an item at the beginning of the list.
  ///
  /// [item] is the item to be inserted.
  void insertItemAtFirst(T item) {
    value = value.copyWith(isLoading: false, items: [item, ...value.items]);
  }

  /// Inserts an item at the end of the list.
  ///
  /// [item] is the item to be inserted.
  void insertItemAtLast(T item) {
    value = value.copyWith(isLoading: false, items: [...value.items, item]);
  }

  /// Appends a list of items to the current list and increments the page counter.
  ///
  /// [items] is the list of items to be appended.
  void appendItems(List<T> items) {
    value = value.copyWith(
      page: value.page + 1,
      isLoading: false,
      items: [...value.items, ...items],
    );
  }

  /// Appends a list of items to the current list and marks it as the last page.
  ///
  /// [items] is the list of items to be appended.
  void appendLastItems(List<T> items) {
    value = value.copyWith(
      isLastPage: true,
      isLoading: false,
      items: [...value.items, ...items],
    );
  }

  /// Sets an error state with the provided error.
  ///
  /// [error] is the error to be set.
  void setError(dynamic error) {
    value = value.copyWith(isLoading: false, error: error);
  }

  @override
  void dispose() {
    if (!_disposed) {
      super.dispose();
    }
    _disposed = true;
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void addListener(VoidCallback listener) {
    if (!_disposed) {
      super.addListener(listener);
    }
  }

  @override
  bool get hasListeners => !_disposed && super.hasListeners;
}

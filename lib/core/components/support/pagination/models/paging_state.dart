import 'package:flutter/foundation.dart';

/// A class representing the state of a paginated list.
///
/// This class is used to manage the state of pagination, including the current
/// page, whether more pages can be loaded, and any errors that may have occurred.
///
/// Example:
/// ```dart
/// final pagingState = PagingState<String>(
///   increment: 10,
///   page: 1,
///   isLastPage: false,
///   isLoading: true,
///   items: ['Item1', 'Item2'],
///   error: null,
/// );
/// ```
class PagingState<T> {
  /// Creates a new instance of [PagingState].
  ///
  /// The [increment] parameter is required and specifies the number of items
  /// to load per page. The [page] parameter defaults to 1, indicating the
  /// first page. The [isLastPage] parameter indicates whether the current
  /// page is the last one. The [isLoading] parameter indicates whether a
  /// loading operation is in progress. The [items] parameter is a list of
  /// items of type [T], defaulting to an empty list. The [error] parameter
  /// can hold any error information.
  PagingState({
    required this.increment,
    this.page = 1,
    this.isLastPage = false,
    this.isLoading = false,
    this.items = const [],
    this.error,
  });

  /// The number of items to load per page.
  final int increment;

  /// The current page number.
  final int page;

  /// Whether the current page is the last page.
  final bool isLastPage;

  /// Whether a loading operation is in progress.
  final bool isLoading;

  /// The list of items of type [T].
  final List<T> items;

  /// Any error information.
  final dynamic error;

  /// Whether more pages can be loaded.
  bool get canLoadMore => !isLastPage && !isLoading && error == null;

  /// Whether the first page is currently loading.
  bool get isFirstLoading => isLoading && items.isEmpty;

  /// Whether a subsequent page is currently loading.
  bool get isPagingLoading => isLoading && items.isNotEmpty;

  /// Whether there are any items loaded.
  bool get hasItems => items.isNotEmpty;

  /// Whether there was an error loading the first page.
  bool get hasErrorLoad => error != null && items.isEmpty;

  /// Whether there was an error loading a subsequent page.
  bool get hasErrorPagingLoad => error != null && items.isNotEmpty;

  /// Whether there are no items and no loading or error is present.
  bool get hasEmpty => error == null && items.isEmpty && !isLoading;

  /// Creates a copy of this [PagingState] but with the given fields replaced
  /// with the new values.
  ///
  /// Example:
  /// ```dart
  /// final newState = pagingState.copyWith(page: 2, isLoading: false);
  /// ```
  PagingState<T> copyWith({
    int? increment,
    int? page,
    bool? isLastPage,
    bool? isLoading,
    List<T>? items,
    dynamic error,
  }) {
    return PagingState<T>(
      increment: increment ?? this.increment,
      page: page ?? this.page,
      isLastPage: isLastPage ?? this.isLastPage,
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PagingState<T> &&
        other.increment == increment &&
        other.page == page &&
        other.isLastPage == isLastPage &&
        other.isLoading == isLoading &&
        listEquals(other.items, items) &&
        other.error == error;
  }

  @override
  int get hashCode {
    return increment.hashCode ^
        page.hashCode ^
        isLastPage.hashCode ^
        isLoading.hashCode ^
        items.hashCode ^
        error.hashCode;
  }
}

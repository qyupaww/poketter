import 'package:flutter/material.dart';

/// A delegate class for building paginated content with various states.
///
/// This class provides builders for different states of pagination such as
/// loading, empty, error, and more. It allows customization of how each state
/// should be displayed.
///
/// Example usage:
/// ```dart
/// PaginationBuilderDelegate<MyItem>(
///   builder: (context, item, index) => ListTile(title: Text(item.name)),
///   firstLoadingBuilder: (context) => CircularProgressIndicator(),
///   loadingBuilder: (context) => CircularProgressIndicator(),
///   emptyBuilder: (context) => Text('No items found.'),
///   errorBuilder: (context, error) => Text('Error: $error'),
///   errorPagingBuilder: (context, error) => Text('Paging Error: $error'),
/// )
/// ```
class PaginationBuilderDelegate<T> {
  /// Creates a [PaginationBuilderDelegate] with the specified builders.
  ///
  /// The [builder] parameter is required and is used to build each item in the
  /// paginated list. Other builders are optional and can be used to customize
  /// the appearance of different pagination states.
  PaginationBuilderDelegate({
    required this.builder,
    this.firstLoadingBuilder,
    this.loadingBuilder,
    this.emptyBuilder,
    this.errorBuilder,
    this.errorPagingBuilder,
    this.endOfListBuilder,
  });

  /// A builder function for creating each item in the paginated list.
  final Widget Function(BuildContext context, T item, int index) builder;

  /// A builder function for the initial loading state.
  final Widget Function(BuildContext context)? firstLoadingBuilder;

  /// A builder function for the loading state during pagination.
  final Widget Function(BuildContext context)? loadingBuilder;

  /// A builder function for the empty state when no items are available.
  final Widget Function(BuildContext context)? emptyBuilder;

  /// A builder function for the error state when an error occurs.
  final Widget Function(BuildContext context, dynamic error)? errorBuilder;

  /// A builder function for the error state during pagination.
  final Widget Function(BuildContext context, dynamic error)?
  errorPagingBuilder;

  /// A builder function for the end of list state.
  final Widget Function(BuildContext context)? endOfListBuilder;
}

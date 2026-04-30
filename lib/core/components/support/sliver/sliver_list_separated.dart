import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A [SliverListSeparated] is a widget that displays a list of items
/// separated by a separator widget. It is useful for creating lists
/// with separators between each item.
///
/// The list is built lazily using the [itemBuilder] and [separatorBuilder]
/// callbacks.
///
/// Example:
/// ```dart
/// SliverListSeparated(
///   itemCount: 10,
///   itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
///   separatorBuilder: (context, index) => Divider(),
/// )
/// ```
class SliverListSeparated extends StatelessWidget {
  /// Creates a sliver list with separators.
  ///
  /// The [itemCount] parameter must be non-null and specifies the number
  /// of items in the list.
  ///
  /// The [itemBuilder] is a required callback that returns a widget for
  /// each item in the list.
  ///
  /// The [separatorBuilder] is a required callback that returns a widget
  /// to be used as a separator between items.
  ///
  /// The [padding] parameter is optional and specifies the padding around
  /// the sliver list.
  const SliverListSeparated({
    required this.itemCount,
    required this.itemBuilder,
    required this.separatorBuilder,
    super.key,
    this.padding,
  });

  /// The number of items in the list.
  final int itemCount;

  /// A builder function that returns a widget for each item in the list.
  final IndexedWidgetBuilder itemBuilder;

  /// A builder function that returns a widget to be used as a separator
  /// between items.
  final IndexedWidgetBuilder separatorBuilder;

  /// The amount of space by which to inset the sliver list.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding ?? EdgeInsets.zero,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final int itemIndex = index ~/ 2;
            if (index.isEven) {
              return itemBuilder(context, itemIndex);
            }
            return separatorBuilder(context, itemIndex ~/ 2);
          },
          semanticIndexCallback: (Widget widget, int localIndex) {
            if (localIndex.isEven) {
              return localIndex ~/ 2;
            }
            return null;
          },
          childCount: math.max(0, itemCount * 2 - 1),
        ),
      ),
    );
  }
}

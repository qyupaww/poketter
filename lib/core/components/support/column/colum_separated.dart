import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A [ColumnSeparated] widget that arranges its children in a vertical
/// sequence with separators between each item.
///
/// This widget is useful when you want to display a list of items with
/// a separator between each item, similar to a ListView.separated but
/// in a column layout.
///
/// The [itemBuilder] is used to build the items, and the [separatorBuilder]
/// is used to build the separators. The [itemCount] specifies the number
/// of items in the column.
///
/// Example usage:
/// ```dart
/// ColumnSeparated(
///   itemCount: 5,
///   itemBuilder: (context, index) => Text('Item $index'),
///   separatorBuilder: (context, index) => Divider(),
/// )
/// ```
class ColumnSeparated extends StatelessWidget {
  /// Creates a [ColumnSeparated] widget.
  ///
  /// The [itemBuilder], [separatorBuilder], and [itemCount] parameters
  /// must not be null.
  ///
  /// The [mainAxisSize], [mainAxisAlignment], [crossAxisAlignment],
  /// and [verticalDirection] parameters allow customization of the
  /// column's layout.
  const ColumnSeparated({
    required this.itemBuilder,
    required this.separatorBuilder,
    required this.itemCount,
    super.key,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.verticalDirection = VerticalDirection.down,
    this.textDirection,
    this.textBaseline,
  });

  /// Called to build children for the column.
  final IndexedWidgetBuilder itemBuilder;

  /// Called to build separators for the column.
  final IndexedWidgetBuilder separatorBuilder;

  /// The number of items in the column.
  final int itemCount;

  /// How much space should be occupied in the main axis.
  final MainAxisSize mainAxisSize;

  /// How the children should be placed along the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// How the children should be placed along the cross axis.
  final CrossAxisAlignment crossAxisAlignment;

  /// The vertical direction of the children.
  final VerticalDirection verticalDirection;

  /// The text direction to use for the column.
  final TextDirection? textDirection;

  /// The text baseline to use for aligning text.
  final TextBaseline? textBaseline;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      textDirection: textDirection,
      children: List.generate(math.max(0, itemCount * 2 - 1), (index) {
        final int itemIndex = index ~/ 2;
        if (index.isEven) {
          return itemBuilder(context, itemIndex);
        }
        return separatorBuilder(context, itemIndex ~/ 2);
      }),
    );
  }
}

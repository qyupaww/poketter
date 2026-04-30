import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A [RowSeparated] widget is a custom [Row] that intersperses its children
/// with separators. It takes an [itemBuilder] to build the main items and a
/// [separatorBuilder] to build the separators between them.
///
/// The number of items is determined by [itemCount]. The separators are placed
/// between each item, so there will be one less separator than the number of items.
///
/// Example usage:
/// ```dart
/// RowSeparated(
///   itemCount: 5,
///   itemBuilder: (context, index) => Text('Item $index'),
///   separatorBuilder: (context, index) => Divider(),
/// )
/// ```
class RowSeparated extends StatelessWidget {
  /// Creates a [RowSeparated] widget.
  ///
  /// The [itemBuilder] and [separatorBuilder] must not be null.
  /// The [itemCount] must be a non-negative integer.
  ///
  /// [mainAxisSize], [mainAxisAlignment], [crossAxisAlignment],
  /// [verticalDirection], [textDirection], and [textBaseline] are optional
  /// parameters that control the layout of the row.
  const RowSeparated({
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

  /// Called to build children for the row.
  ///
  /// The [itemBuilder] is called with the context and the index of the item.
  final IndexedWidgetBuilder itemBuilder;

  /// Called to build separators between the children.
  ///
  /// The [separatorBuilder] is called with the context and the index of the separator.
  final IndexedWidgetBuilder separatorBuilder;

  /// The number of items in the row.
  ///
  /// This must be a non-negative integer.
  final int itemCount;

  /// Determines the size of the main axis.
  ///
  /// Defaults to [MainAxisSize.max].
  final MainAxisSize mainAxisSize;

  /// How the children should be placed along the main axis.
  ///
  /// Defaults to [MainAxisAlignment.start].
  final MainAxisAlignment mainAxisAlignment;

  /// How the children should be placed along the cross axis.
  ///
  /// Defaults to [CrossAxisAlignment.center].
  final CrossAxisAlignment crossAxisAlignment;

  /// The vertical direction of the row.
  ///
  /// Defaults to [VerticalDirection.down].
  final VerticalDirection verticalDirection;

  /// The text direction to use for the row.
  ///
  /// This is optional and can be null.
  final TextDirection? textDirection;

  /// The text baseline to use for aligning text.
  ///
  /// This is optional and can be null.
  final TextBaseline? textBaseline;

  @override
  Widget build(BuildContext context) {
    return Row(
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

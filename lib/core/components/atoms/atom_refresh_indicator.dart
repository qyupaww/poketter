import 'package:flutter/material.dart';

class AtomRefreshIndicator extends StatelessWidget {
  const AtomRefreshIndicator({
    required this.child,
    required this.onRefresh,
    super.key,
    this.canRefresh = true,
    this.isChildScrollable = true,
  });

  final bool canRefresh;

  final Widget child;

  final bool isChildScrollable;

  final RefreshCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    if (!canRefresh) return child;

    if (!isChildScrollable) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return RefreshIndicator(
            onRefresh: onRefresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: child,
              ),
            ),
          );
        },
      );
    }

    return RefreshIndicator(onRefresh: onRefresh, child: child);
  }
}

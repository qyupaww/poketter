import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:poketter/core/themes/morpheme_colors/src/morpheme_color.dart';
import 'package:poketter/core/components/atoms/atom_refresh_indicator.dart';
import 'package:poketter/core/components/molecules/molecule_empty_state.dart';
import 'package:poketter/core/components/support/pagination/models/pagination_builder_delegate.dart';
import 'package:poketter/core/components/support/pagination/models/paging_controller.dart';
import 'package:poketter/core/components/support/pagination/models/paging_state.dart';
import 'package:poketter/core/utils/init_after_layout.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GridViewPagination<T> extends StatefulWidget {
  const GridViewPagination({
    required this.pagingController,
    required this.onPagingLoad,
    required this.paginationBuilderDelegate,
    required this.gridDelegate,
    super.key,
    this.initialLoad = true,
    this.padding,
    this.shrinkWrap = false,
    this.onRefresh,
    this.childrenDelegate,
    this.semanticChildCount,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.firstLoadingLenght = 1,
    this.canRefresh = true,
  });

  GridViewPagination.count({
    required int crossAxisCount,
    required this.pagingController,
    required this.onPagingLoad,
    required this.paginationBuilderDelegate,
    super.key,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    double childAspectRatio = 1.0,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.padding,
    this.shrinkWrap = false,
    this.onRefresh,
    this.childrenDelegate,
    this.semanticChildCount,
    this.initialLoad = true,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.firstLoadingLenght = 1,
    this.canRefresh = true,
  }) : gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount: crossAxisCount,
         mainAxisSpacing: mainAxisSpacing,
         crossAxisSpacing: crossAxisSpacing,
         childAspectRatio: childAspectRatio,
       );

  final bool initialLoad;

  final PagingController<T> pagingController;

  final void Function(int page) onPagingLoad;

  final PaginationBuilderDelegate<T> paginationBuilderDelegate;

  final EdgeInsetsGeometry? padding;

  final bool shrinkWrap;

  final Future<void> Function()? onRefresh;

  final ScrollPhysics? physics;

  final SliverGridDelegate gridDelegate;

  final SliverChildDelegate? childrenDelegate;

  final int? semanticChildCount;

  final bool addAutomaticKeepAlives;

  final bool addRepaintBoundaries;

  final bool addSemanticIndexes;

  final int firstLoadingLenght;

  final bool canRefresh;

  @override
  State<GridViewPagination<T>> createState() => _GridViewPaginationState<T>();
}

class _GridViewPaginationState<T> extends State<GridViewPagination<T>> {
  @override
  void initState() {
    super.initState();
    if (widget.initialLoad) {
      widget.pagingController.setLoading();
      widget.onPagingLoad(widget.pagingController.value.page);
    }
    initAfterFirstLayout(
      () async => widget.pagingController.addListener(watchPagingController),
    );
  }

  @override
  void dispose() {
    widget.pagingController.removeListener(watchPagingController);
    super.dispose();
  }

  void watchPagingController() {
    if (widget.pagingController.value.page == 1 &&
        widget.pagingController.value.canLoadMore &&
        widget.pagingController.value.items.isEmpty) {
      _pagingLoad();
    }
  }

  void _pagingLoad() {
    if (widget.pagingController.value.isLoading) return;
    widget.pagingController.setLoading();
    widget.onPagingLoad(widget.pagingController.value.page);
  }

  bool _onNotification(ScrollNotification notification, PagingState state) {
    final nextPageTrigger = 0.8 * notification.metrics.maxScrollExtent;
    if (notification.metrics.pixels > nextPageTrigger && state.canLoadMore) {
      _pagingLoad();
    }
    return true;
  }

  Widget _getItemBuilder(BuildContext context, PagingState state, int index) {
    if (state.hasErrorPagingLoad && index == state.items.length) {
      return widget.paginationBuilderDelegate.errorPagingBuilder?.call(
            context,
            state.error,
          ) ??
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: IconButton(
                onPressed: _pagingLoad,
                icon: Icon(Icons.refresh, color: context.color.primary),
              ),
            ),
          );
    }

    if (state.isPagingLoading && index == state.items.length) {
      return widget.paginationBuilderDelegate.loadingBuilder?.call(context) ??
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
    }

    if (state.isLastPage &&
        widget.paginationBuilderDelegate.endOfListBuilder != null &&
        index == state.items.length) {
      return widget.paginationBuilderDelegate.endOfListBuilder!.call(context);
    }

    return widget.paginationBuilderDelegate.builder(
      context,
      state.items[index],
      index,
    );
  }

  Future<void> onRefresh() async {
    widget.pagingController.reset();
    await widget.onRefresh?.call();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PagingState<T>>(
      valueListenable: widget.pagingController,
      builder: (context, value, child) {
        if (widget.firstLoadingLenght > 1 &&
            value.isFirstLoading &&
            widget.paginationBuilderDelegate.firstLoadingBuilder != null) {
          return Skeletonizer(
            enabled: true,
            child: GridView.custom(
              physics: widget.physics,
              padding: widget.padding,
              shrinkWrap: widget.shrinkWrap,
              semanticChildCount:
                  widget.semanticChildCount ?? value.items.length,
              gridDelegate: widget.gridDelegate,
              childrenDelegate: SliverChildListDelegate(
                List.generate(
                  widget.firstLoadingLenght,
                  (index) => widget
                      .paginationBuilderDelegate
                      .firstLoadingBuilder!
                      .call(context),
                ),
                addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
                addRepaintBoundaries: widget.addRepaintBoundaries,
                addSemanticIndexes: widget.addSemanticIndexes,
              ),
            ),
          );
        } else if (value.isFirstLoading) {
          return Padding(
            padding: widget.padding ?? EdgeInsets.zero,
            child:
                widget.paginationBuilderDelegate.firstLoadingBuilder?.call(
                  context,
                ) ??
                const Center(child: CircularProgressIndicator()),
          );
        }
        if (value.hasEmpty) {
          return AtomRefreshIndicator(
            canRefresh: widget.canRefresh,
            onRefresh: onRefresh,
            isChildScrollable: false,
            child:
                widget.paginationBuilderDelegate.emptyBuilder?.call(context) ??
                const MoleculeEmptyState(),
          );
        } else if (value.hasErrorLoad) {
          return AtomRefreshIndicator(
            canRefresh: widget.canRefresh,
            onRefresh: onRefresh,
            isChildScrollable: false,
            child:
                widget.paginationBuilderDelegate.errorBuilder?.call(
                  context,
                  value.error,
                ) ??
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(child: Text(value.error.toString())),
                ),
          );
        }
        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) =>
              _onNotification(notification, value),
          child: AtomRefreshIndicator(
            canRefresh: widget.canRefresh,
            onRefresh: onRefresh,
            child: GridView.custom(
              physics: widget.physics,
              padding: widget.padding,
              shrinkWrap: widget.shrinkWrap,
              semanticChildCount:
                  widget.semanticChildCount ?? value.items.length,
              gridDelegate: widget.gridDelegate,
              childrenDelegate: SliverChildListDelegate(
                value.items
                    .mapIndexed(
                      (index, e) => _getItemBuilder(context, value, index),
                    )
                    .toList(),
                addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
                addRepaintBoundaries: widget.addRepaintBoundaries,
                addSemanticIndexes: widget.addSemanticIndexes,
              ),
            ),
          ),
        );
      },
    );
  }
}

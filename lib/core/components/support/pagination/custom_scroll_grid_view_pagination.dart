import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:poketter/core/themes/morpheme_colors/src/morpheme_color.dart';
import 'package:poketter/core/components/atoms/atom_refresh_indicator.dart';
import 'package:poketter/core/components/molecules/molecule_empty_state.dart';
import 'package:poketter/core/components/support/pagination/models/pagination_builder_delegate.dart';
import 'package:poketter/core/components/support/pagination/models/paging_controller.dart';
import 'package:poketter/core/components/support/pagination/models/paging_state.dart';
import 'package:poketter/core/utils/init_after_layout.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomScrollGridViewPagination<T> extends StatefulWidget {
  const CustomScrollGridViewPagination.count({
    required this.pagingController,
    required this.onPagingLoad,
    required this.paginationBuilderDelegate,
    required this.crossAxisCount,
    super.key,
    this.slivers = const [],
    this.contentPadding,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.scrollBehavior,
    this.shrinkWrap = false,
    this.center,
    this.anchor = 0.0,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.onRefresh,
    this.initialLoad = true,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.childAspectRatio = 1.0,
    this.firstLoadingLenght = 1,
    this.canRefresh = true,
  });

  final bool initialLoad;

  final PagingController<T> pagingController;

  final void Function(int page) onPagingLoad;

  final PaginationBuilderDelegate<T> paginationBuilderDelegate;

  final List<Widget> slivers;

  final EdgeInsetsGeometry? contentPadding;

  final int crossAxisCount;

  final double mainAxisSpacing;

  final double crossAxisSpacing;

  final double childAspectRatio;

  final int firstLoadingLenght;

  final Axis scrollDirection;

  final bool reverse;

  final ScrollController? controller;

  final bool? primary;

  final ScrollPhysics? physics;

  final ScrollBehavior? scrollBehavior;

  final bool shrinkWrap;

  final Key? center;

  final double anchor;

  final double? cacheExtent;

  final int? semanticChildCount;

  final DragStartBehavior dragStartBehavior;

  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  final String? restorationId;

  final Clip clipBehavior;

  final Future<void> Function()? onRefresh;

  final bool canRefresh;

  @override
  State<CustomScrollGridViewPagination<T>> createState() =>
      _CustomScrollGridViewPaginationState<T>();
}

class _CustomScrollGridViewPaginationState<T>
    extends State<CustomScrollGridViewPagination<T>> {
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

  Future<void> onRefresh() async {
    widget.pagingController.reset();
    await widget.onRefresh?.call();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PagingState<T>>(
      valueListenable: widget.pagingController,
      builder: (context, value, child) {
        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) =>
              _onNotification(notification, value),
          child: AtomRefreshIndicator(
            canRefresh: widget.canRefresh,
            onRefresh: onRefresh,
            child: CustomScrollView(
              scrollDirection: widget.scrollDirection,
              reverse: widget.reverse,
              controller: widget.controller,
              primary: widget.primary,
              physics: widget.physics,
              scrollBehavior: widget.scrollBehavior,
              shrinkWrap: widget.shrinkWrap,
              center: widget.center,
              anchor: widget.anchor,
              cacheExtent: widget.cacheExtent,
              slivers: [
                ...widget.slivers,
                if (widget.firstLoadingLenght > 1 &&
                    value.isFirstLoading &&
                    widget.paginationBuilderDelegate.firstLoadingBuilder !=
                        null)
                  SliverFillRemaining(
                    child: Skeletonizer(
                      enabled: true,
                      child: GridView.custom(
                        padding: widget.contentPadding,
                        physics: widget.physics,
                        shrinkWrap: widget.shrinkWrap,
                        semanticChildCount:
                            widget.semanticChildCount ?? value.items.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: widget.crossAxisCount,
                          mainAxisSpacing: widget.mainAxisSpacing,
                          crossAxisSpacing: widget.crossAxisSpacing,
                          childAspectRatio: widget.childAspectRatio,
                        ),
                        childrenDelegate: SliverChildListDelegate(
                          List.generate(
                            widget.firstLoadingLenght,
                            (index) => widget
                                .paginationBuilderDelegate
                                .firstLoadingBuilder!
                                .call(context),
                          ),
                        ),
                      ),
                    ),
                  )
                else if (value.isFirstLoading)
                  widget.paginationBuilderDelegate.firstLoadingBuilder?.call(
                        context,
                      ) ??
                      const SliverFillRemaining(
                        fillOverscroll: false,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                if (value.hasEmpty)
                  widget.paginationBuilderDelegate.emptyBuilder?.call(
                        context,
                      ) ??
                      const SliverFillRemaining(
                        fillOverscroll: false,
                        child: MoleculeEmptyState(),
                      )
                else if (value.hasErrorLoad)
                  widget.paginationBuilderDelegate.errorBuilder?.call(
                        context,
                        value.error,
                      ) ??
                      SliverFillRemaining(
                        fillOverscroll: false,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(child: Text(value.error.toString())),
                        ),
                      )
                else if (value.hasItems)
                  SliverPadding(
                    padding: widget.contentPadding ?? EdgeInsets.zero,
                    sliver: SliverGrid.count(
                      crossAxisCount: widget.crossAxisCount,
                      mainAxisSpacing: widget.mainAxisSpacing,
                      crossAxisSpacing: widget.crossAxisSpacing,
                      childAspectRatio: widget.childAspectRatio,
                      children: widget.pagingController.value.items.mapIndexed((
                        index,
                        element,
                      ) {
                        return widget.paginationBuilderDelegate.builder(
                          context,
                          widget.pagingController.value.items[index],
                          index,
                        );
                      }).toList(),
                    ),
                  ),
                if (value.hasErrorPagingLoad)
                  widget.paginationBuilderDelegate.errorPagingBuilder?.call(
                        context,
                        value.error,
                      ) ??
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: IconButton(
                              onPressed: _pagingLoad,
                              icon: Icon(
                                Icons.refresh,
                                color: context.color.primary,
                              ),
                            ),
                          ),
                        ),
                      )
                else if (value.isPagingLoading)
                  widget.paginationBuilderDelegate.loadingBuilder?.call(
                        context,
                      ) ??
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                if (value.isLastPage &&
                    widget.paginationBuilderDelegate.endOfListBuilder != null)
                  widget.paginationBuilderDelegate.endOfListBuilder!.call(
                    context,
                  ),
              ],
              semanticChildCount: widget.semanticChildCount,
              dragStartBehavior: widget.dragStartBehavior,
              keyboardDismissBehavior: widget.keyboardDismissBehavior,
              restorationId: widget.restorationId,
              clipBehavior: widget.clipBehavior,
            ),
          ),
        );
      },
    );
  }
}

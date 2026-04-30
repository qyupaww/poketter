import 'package:flutter/material.dart';
import 'package:poketter/core/themes/morpheme_colors/src/morpheme_color.dart';
import 'package:poketter/core/components/atoms/atom_refresh_indicator.dart';
import 'package:poketter/core/components/molecules/molecule_empty_state.dart';
import 'package:poketter/core/components/support/pagination/models/pagination_builder_delegate.dart';
import 'package:poketter/core/components/support/pagination/models/paging_controller.dart';
import 'package:poketter/core/components/support/pagination/models/paging_state.dart';
import 'package:poketter/core/utils/init_after_layout.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListViewPagination<T> extends StatefulWidget {
  const ListViewPagination({
    required this.pagingController,
    required this.onPagingLoad,
    required this.paginationBuilderDelegate,
    super.key,
    this.separatorBuilder,
    this.padding,
    this.shrinkWrap = false,
    this.onRefresh,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.scrollDirection = Axis.vertical,
    this.initialLoad = true,
    this.firstLoadingLenght = 1,
    this.canRefresh = true,
  });

  final bool initialLoad;

  final PagingController<T> pagingController;

  final void Function(int page) onPagingLoad;

  final PaginationBuilderDelegate<T> paginationBuilderDelegate;

  final IndexedWidgetBuilder? separatorBuilder;

  final EdgeInsetsGeometry? padding;

  final bool shrinkWrap;

  final Future<void> Function()? onRefresh;

  final ScrollPhysics? physics;

  final Axis scrollDirection;

  final int firstLoadingLenght;

  final bool canRefresh;

  @override
  State<ListViewPagination<T>> createState() => _ListViewPaginationState<T>();
}

class _ListViewPaginationState<T> extends State<ListViewPagination<T>> {
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

  void _pagingLoad() {
    if (widget.pagingController.value.isLoading) return;
    widget.pagingController.setLoading();
    widget.onPagingLoad(widget.pagingController.value.page);
  }

  void watchPagingController() {
    if (widget.pagingController.value.page == 1 &&
        widget.pagingController.value.canLoadMore &&
        widget.pagingController.value.items.isEmpty) {
      _pagingLoad();
    }
  }

  bool _onNotification(ScrollNotification notification, PagingState state) {
    final nextPageTrigger = 0.8 * notification.metrics.maxScrollExtent;
    if (notification.metrics.pixels > nextPageTrigger && state.canLoadMore) {
      _pagingLoad();
    }
    return true;
  }

  int _getLength(PagingState state) {
    int length = state.items.length;

    if (state.hasErrorPagingLoad ||
        state.isPagingLoading ||
        (state.isLastPage &&
            widget.paginationBuilderDelegate.endOfListBuilder != null)) {
      length++;
    }

    return length;
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
            child: widget.separatorBuilder == null
                ? ListView.builder(
                    physics: widget.physics,
                    padding: widget.padding,
                    scrollDirection: widget.scrollDirection,
                    shrinkWrap: widget.shrinkWrap,
                    itemBuilder: (context, index) => widget
                        .paginationBuilderDelegate
                        .firstLoadingBuilder!
                        .call(context),
                    itemCount: widget.firstLoadingLenght,
                  )
                : ListView.separated(
                    physics: widget.physics,
                    padding: widget.padding,
                    scrollDirection: widget.scrollDirection,
                    shrinkWrap: widget.shrinkWrap,
                    itemBuilder: (context, index) => widget
                        .paginationBuilderDelegate
                        .firstLoadingBuilder!
                        .call(context),
                    separatorBuilder: widget.separatorBuilder!,
                    itemCount: widget.firstLoadingLenght,
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
        } else if (value.hasEmpty) {
          return AtomRefreshIndicator(
            canRefresh:
                widget.canRefresh && widget.scrollDirection == Axis.vertical,
            onRefresh: onRefresh,
            isChildScrollable: false,
            child:
                widget.paginationBuilderDelegate.emptyBuilder?.call(context) ??
                const MoleculeEmptyState(),
          );
        } else if (value.hasErrorLoad) {
          return AtomRefreshIndicator(
            canRefresh:
                widget.canRefresh && widget.scrollDirection == Axis.vertical,
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
            canRefresh:
                widget.canRefresh && widget.scrollDirection == Axis.vertical,
            onRefresh: onRefresh,
            child: widget.separatorBuilder == null
                ? ListView.builder(
                    physics: widget.physics,
                    padding: widget.padding,
                    scrollDirection: widget.scrollDirection,
                    shrinkWrap: widget.shrinkWrap,
                    itemBuilder: (context, index) =>
                        _getItemBuilder(context, value, index),
                    itemCount: _getLength(value),
                  )
                : ListView.separated(
                    physics: widget.physics,
                    padding: widget.padding,
                    scrollDirection: widget.scrollDirection,
                    shrinkWrap: widget.shrinkWrap,
                    itemBuilder: (context, index) =>
                        _getItemBuilder(context, value, index),
                    separatorBuilder: widget.separatorBuilder!,
                    itemCount: _getLength(value),
                  ),
          ),
        );
      },
    );
  }
}

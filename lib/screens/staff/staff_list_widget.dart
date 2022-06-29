import 'package:app04/screens/helper_widgets/vertical_item_widget.dart';
import 'package:app04/screens/helper_widgets/vertical_shimmer.dart';
import 'package:app04/screens/staff/staff_widget.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../models/low_data_item.dart';
import '../../models/properties_model.dart';

class StaffScrollListWidget extends StatefulWidget {
  final Function _function;
  final bool _isStaff;

  StaffScrollListWidget(this._function, this._isStaff);

  @override
  State<StaffScrollListWidget> createState() => _StaffScrollListWidgetState();
}

class _StaffScrollListWidgetState extends State<StaffScrollListWidget> {
  static const _pageSize = 12;
  bool _showBackToTopButton = false;

  final PagingController<int, Staff> _pagingController =
      PagingController(firstPageKey: 1);

  late ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    _scrollController = ScrollController()
      ..addListener(() {
        if (_showBackToTopButton == false && _scrollController.offset >= 500) {
          setState(() {
            _showBackToTopButton = true;
          });
        } else if (_showBackToTopButton == true &&
            _scrollController.offset < 500) {
          setState(() {
            _showBackToTopButton = false;
          });
        }
      });

    super.initState();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await widget._function(pageKey);
      if (newItems == null) {
        _pagingController.appendLastPage([]);
        return;
      }
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(() => _pagingController.refresh()),
      child: Stack(
        children: [
          PagedListView<int, Staff>.separated(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            pagingController: _pagingController,
            scrollController: _scrollController,
            builderDelegate: PagedChildBuilderDelegate<Staff>(
              itemBuilder: (context, item, index) => StaffWidget(item, widget._isStaff),
              firstPageProgressIndicatorBuilder: (_) => SingleChildScrollView(
                child: Column(
                  children: [
                    VerticalShimmer(),
                    VerticalShimmer(),
                    VerticalShimmer(),
                    VerticalShimmer(),
                    VerticalShimmer(),
                    VerticalShimmer(),
                    VerticalShimmer(),
                  ],
                ),
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 1),
          ),
          if (_showBackToTopButton)
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 30),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: _scrollToTop,
                  child: const Icon(Icons.arrow_upward),
                ),
              ),
            )
        ],
      ),
    );
  }
}

import 'package:app04/models/low_data_item.dart';
import 'package:app04/screens/helper_widgets/vertical_item_widget.dart';
import 'package:flutter/material.dart';

class ScrollListWidget extends StatefulWidget {
  final Function _function;

  const ScrollListWidget(this._function, {Key? key}) : super(key: key);

  @override
  State<ScrollListWidget> createState() => _ScrollListWidgetState();
}

class _ScrollListWidgetState extends State<ScrollListWidget> {
  int _page = 1;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  bool _showBackToTopButton = false;
  late ScrollController _controller;

  List<LowDataItem> movies = [];

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await widget._function(1);
      setState(() {
        movies = res ?? [];
      });
    } catch (err) {
      print('Something went wrong');
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      _page += 1;
      try {
        final res = await widget._function(_page);
        final fetchedMovies = res ?? [];
        if (fetchedMovies.isNotEmpty) {
          setState(() {
            movies.addAll(fetchedMovies);
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        print('Something went wrong!');
      }
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  @override
  void initState() {
    _controller = ScrollController()
      ..addListener(_loadMore)
      ..addListener(() {
        setState(() =>
            _showBackToTopButton = (_controller.offset >= 600) ? true : false);
      });
    _firstLoad();
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  void _scrollToTop() {
    _controller.animateTo(0,
        duration: const Duration(milliseconds: 100), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return _isFirstLoadRunning
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        controller: _controller,
                        itemCount: movies.length,
                        itemBuilder: (_, int index) {
                          return VerticalItemWidget(movies[index]);
                        }),
                  ),
                  if (_hasNextPage == false)
                    Container(
                      color: Colors.amber,
                      child: const Center(
                        child: Text('You have fetched all of the content'),
                      ),
                    ),
                  if (_isLoadMoreRunning == true)
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 8),
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(strokeWidth: 3),
                        ),
                      ),
                    ),
                ],
              ),
              if (_showBackToTopButton == false)
                const SizedBox()
              else
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: FloatingActionButton(
                        onPressed: _scrollToTop,
                        child: const Icon(Icons.arrow_upward),
                      ),
                    ),
                  ),
                ),
            ],
          );
  }
}

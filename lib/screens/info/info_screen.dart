import 'package:app04/utilities/consts.dart';
import 'package:app04/utilities/http_helper.dart';
import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import '../../utilities/cache_image.dart';
import 'download_buttons_widget.dart';
import 'info_section_widget.dart';

class InfoScreen extends StatefulWidget {
  static const routeName = '/info-screen';
  final Map<String, String?>? args;
  const InfoScreen({Key? key, this.args}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late ScrollController _scrollViewController;
  bool _showAppbar = false;
  bool isScrollingDown = false;
  late bool isMovie;
  final GlobalKey _widgetKey = GlobalKey();

  void _scrollDown() {
    final RenderBox renderBox = _widgetKey.currentContext?.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
      if (_scrollViewController.hasClients) {
        _scrollViewController.animateTo(
          offset.dy,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
  }


  @override
  void initState() {

      isMovie = widget.args!['type']!.contains('movie');
    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if(_showAppbar && _scrollViewController.offset >= screenWidth){
        setState(() {
          _showAppbar = false;
        });
      }

      if(!_showAppbar && _scrollViewController.offset <= screenWidth){
        setState(() {
          _showAppbar = true;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollViewController.removeListener(() {});
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color4,
      extendBodyBehindAppBar: true,
      appBar: ScrollAppBar(
        elevation: 0,
        backgroundColor: color4,
        toolbarHeight: 40,
        controller: _scrollViewController,
        title: const Text("info"),
      ),

      body: Snap(
        controller: _scrollViewController.appBar,
        child: SafeArea(
          child: RefreshIndicator(
            color: Colors.red,
            onRefresh: () async {
              isMovie
                  ? await getMovieInfo(widget.args!['id']!)
                  : await getSerialInfo(widget.args!['id']!);
              setState(() {});
            },
            child: FutureBuilder(
                future: isMovie
                    ? getMovieInfo(widget.args!['id']!)
                    : getSerialInfo(widget.args!['id']!),
                //todo simple way
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                      child: SingleChildScrollView(
                        controller: _scrollViewController,

                        child: Column(
                          //reverse: true,
                          //shrinkWrap: true,
                          children: [
                            InfoSectionWidget(snapshot.data, _scrollDown),
                            SizedBox(key: _widgetKey, height: 1),
                            (isMovie)
                                ? DownloadMovieWidget(snapshot.data.posters.isNotEmpty ? snapshot.data.posters[0].url : '',
                                    snapshot.data.qualities)
                                : DownloadSeasonsWidget(snapshot.data),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                      child: SizedBox(
                          width: screenWidth,
                          height: screenWidth,
                          child: FittedBox(
                              child: CacheImage(widget.args!['url']??''),
                              fit: BoxFit.fill)),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}


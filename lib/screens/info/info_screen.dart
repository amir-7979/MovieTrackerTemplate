import 'package:app04/utilities/consts.dart';
import 'package:app04/utilities/http_helper.dart';
import 'package:flutter/material.dart';
import '../../utilities/cache_image.dart';
import 'download_buttons_widget.dart';
import 'download_movie_section.dart';
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
      appBar: AppBar(
        elevation: 5,
        backgroundColor: color5,
        toolbarHeight: 40,
        title: const Text("info"),
      ),

      body: SafeArea(
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
                              ? DownloadMovieSection(context, dio, snapshot.data)
                              : DownloadSeasonsSection(snapshot.data),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                    child: Column(
                      children: [
                        SizedBox(
                            width: screenWidth,
                            height: screenWidth,
                            child: FittedBox(
                                child: CacheImage(widget.args!['url']??''),
                                fit: BoxFit.fill)),
                        SizedBox(height: 10,),
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}


import 'package:app04/utilities/consts.dart';
import 'package:app04/utilities/http_helper.dart';
import 'package:flutter/material.dart';
import '../../utilities/cache_image.dart';
import 'download_buttons_widget.dart';
import 'info_section_widget.dart';

class InfoScreen extends StatefulWidget {
  static const routeName = '/info-screen';
  final Map<String, String?>? args;

  InfoScreen({this.args});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late bool isMovie;
  @override
  void initState() {
    isMovie = widget.args!['type']!.contains('movie');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info')
      ),
      body: FutureBuilder(
          future: isMovie ? getMovieInfo(widget.args!['id']!) : getSerialInfo(widget.args!['id']!),
          //todo simple way
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  InfoSectionWidget(snapshot.data),
                  (isMovie) ? DownloadMovieWidget(snapshot.data.posters[0].url ,snapshot.data.qualities) : DownloadSeasonsWidget(snapshot.data),
                ],
              );
            } else {
              return Padding(
                padding: const EdgeInsets.fromLTRB(2, 10, 2, 0),
                child: SizedBox(
                    width: screenWidth,
                    height: screenWidth,
                    child: FittedBox(child: CacheImage(widget.args!['url']),
                    fit: BoxFit.fill)),
              );
            }
          }),
    );
  }

}

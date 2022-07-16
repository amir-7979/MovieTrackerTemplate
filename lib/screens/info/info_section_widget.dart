import 'package:app04/screens/info/part.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../icons/my_flutter_app_icons.dart';
import '../../models/properties_model.dart';
import '../../utilities/cache_image.dart';
import '../../utilities/consts.dart';
import '../../utilities/function_helper.dart';
import '../../utilities/http_helper.dart';
import '../helper_widgets/trailer_part_widget.dart';

class InfoSectionWidget extends StatefulWidget {
  final dynamic _infoModel;
  final Function _function;

  InfoSectionWidget(this._infoModel, this._function);

  @override
  State<InfoSectionWidget> createState() => _InfoSectionWidgetState();
}

class _InfoSectionWidgetState extends State<InfoSectionWidget> {
  bool summery = true;
  bool isReadMore = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  width: screenWidth,
                  height: screenWidth,
                  child: InkWell(
                    onDoubleTap: () async {
                      UserStats userStats = widget._infoModel.userStats;
                      setState(() => widget._infoModel.userStats =
                          disLikeMovie(widget._infoModel.userStats));
                      int res = await likeOrDislike(
                          'dislike_movie',
                          widget._infoModel.id!,
                          (widget._infoModel.userStats.dislikeMovie)
                              ? false
                              : true);
                      if (res != 200) {
                        setState(() {
                          widget._infoModel.userStats = userStats;
                        });
                      }
                    },
                    child: FittedBox(
                      child: CacheImage(widget._infoModel.posters.isNotEmpty
                          ? widget._infoModel.posters[0].url
                          : 'assets/images/no_image.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  height: 30,
                ),
              ],
            ),
            Positioned(
              bottom: -0.1,
              child: Container(
                decoration: BoxDecoration(
                  color: color1,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            splashRadius: 0.1,
                            onPressed: () async {
                              UserStats userStats = widget._infoModel.userStats;
                              setState(() => widget._infoModel.userStats =
                                  likeMovie(widget._infoModel.userStats));
                              int res = await likeOrDislike(
                                  'like_movie',
                                  widget._infoModel.id!,
                                  (widget._infoModel.userStats.likeMovie)
                                      ? false
                                      : true);
                              if (res != 200) {
                                setState(() {
                                  widget._infoModel.userStats = userStats;
                                });
                              }else{
                                setState((){});
                              }
                            },
                            icon: Icon(
                              MyFlutterApp.thumbs_up,
                              color: (widget._infoModel.userStats.likeMovie)
                                  ? Colors.green
                                  : Colors.grey,
                            )),
                        Text(
                            '${widget._infoModel.userStats.likeMovieCount}  -  ${widget._infoModel.userStats.dislikeMovieCount}'),
                        IconButton(
                            splashRadius: 0.1,
                            onPressed: () async {
                              UserStats userStats = widget._infoModel.userStats;
                              setState(() => widget._infoModel.userStats =
                                  disLikeMovie(widget._infoModel.userStats));
                              int res = await likeOrDislike(
                                  'dislike_movie',
                                  widget._infoModel.id!,
                                  (widget._infoModel.userStats.dislikeMovie)
                                      ? false
                                      : true);
                              if (res != 200) {
                                setState(() {
                                  widget._infoModel.userStats = userStats;
                                });
                              }else{
                                setState((){});
                              }
                            },
                            icon: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                              child: Icon(
                                MyFlutterApp.thumbs_down,
                                color:
                                    (widget._infoModel.userStats.dislikeMovie)
                                        ? Colors.red
                                        : Colors.grey,
                              ),
                            )),
                      ],
                    ),
                    IconButton(
                        splashRadius: 0.1,
                        onPressed: () async {
                          setState(() => widget._infoModel.userStats.save =
                              !widget._infoModel.userStats.save);
                          int res = await likeOrDislike(
                              'save',
                              widget._infoModel.id!,
                              (widget._infoModel.userStats.save)
                                  ? false
                                  : true);
                          if (res != 200) {
                            setState(() {});
                          }else{
                            setState((){});
                          }
                        },
                        icon: Icon(
                          Icons.bookmark,
                          color: (widget._infoModel.userStats.save)
                              ? Colors.blue
                              : Colors.grey,
                        )),
/*
                    IconButton(
                      splashRadius: 0.1,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.play_arrow,
                        color: Colors.grey,
                      ),
                    ),
*/
                    IconButton(
                      splashRadius: 0.1,
                      onPressed: () => Share.share(
                          widget._infoModel.posters.isNotEmpty
                              ? widget._infoModel.posters[0].url
                              : '',
                          subject: widget._infoModel.title),
                      icon: const Icon(
                        Icons.share_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(
                      splashRadius: 0.1,
                      onPressed: () {
                        widget._function();
                      },
                      icon: const Icon(
                        Icons.download_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 25, 0, 20),
          child: Text(
            widget._infoModel.rawTitle ?? '',
            style: const TextStyle(color: yellow1, fontSize: 21.0),
          ),
        ),

        SizedBox(
          height: 25,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Text(
                widget._infoModel.type,
                style: const TextStyle(fontSize: 18),
              ),
              if (widget._infoModel.year != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Container(
                    width: 1,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
              if (widget._infoModel.year != null)
                Text(
                  widget._infoModel.year,
                  style: const TextStyle(fontSize: 18),
                ),
              if (widget._infoModel.duration != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Container(
                    width: 1,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
              if (widget._infoModel.duration != null)
                Text(
                  widget._infoModel.duration.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              if (widget._infoModel.rating.imdb != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Container(
                    width: 1,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
              if (widget._infoModel.rating.imdb != null)
                Row(
                  children: [
                    SizedBox(
                        width: 45,
                        height: 30,
                        child: Image.asset('assets/images/imdb.jpg')),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        widget._infoModel.rating.imdb.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),

        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            const Text(
              'PLOT',
              style: TextStyle(color: Colors.red, fontSize: 20.0),
            ),
            (widget._infoModel.trailers != null)
                ? ((widget._infoModel.trailers[0].url != null)
                    ? TextButton(
                        onPressed: () async {
                          _bottomSheet(context);
                        },
                        child: const Text('watch trailer'),
                      )
                    : const SizedBox(height: 50))
                : const SizedBox(height: 50),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        Row(
          children: [
            TextButton(
                onPressed: () => setState(() => summery = true),
                child: const Text('English')),
            TextButton(
                onPressed: () => setState(() => summery = false),
                child: const Text('Persian'))
          ],
        ),
        (summery == true)
            ? buildText(widget._infoModel.summary?.english ?? '')
            : buildText(widget._infoModel.summary?.persian ?? ''),
        Center(
          child: TextButton(
              onPressed: () {
                setState(() {
                  // toggle the bool variable true or false
                  isReadMore = !isReadMore;
                });
              },
              child: Text((isReadMore ? 'Read Less' : 'Read More'))),
        ),
        const SizedBox(height: 20),

        const Text('INFO', style: TextStyle(color: Colors.red, fontSize: 20.0)),

        const SizedBox(height: 10),

        Part("Rated", widget._infoModel.rated),
        const SizedBox(height: 10),

        Part("Country", widget._infoModel.country),
        const SizedBox(height: 10),

        Part("Language", widget._infoModel.movieLang),
        const SizedBox(height: 10),

        //Part("Directors", widget._infoModel.directors.toString().substring(1, widget._infoModel.directors.toString().length-1)),

        //Part("Writers", widget._infoModel.writers.toString().substring(1, widget._infoModel.writers.toString().length-1)),

        Part(
            "Genre",
            widget._infoModel.genres
                .toString()
                .substring(1, widget._infoModel.genres.toString().length - 1)),

        const SizedBox(height: 10),

        const Text('Update',
            style: TextStyle(color: Colors.red, fontSize: 20.0)),

        const SizedBox(height: 10),

        Part("Quality", widget._infoModel.latestData?.quality),

        const SizedBox(height: 10),

        Part("HardSub", widget._infoModel.latestData?.hardSub),

        const SizedBox(height: 10),

        Part("Dubbed", widget._infoModel.latestData?.dubbed),

        const SizedBox(height: 10),

        const Text('Download',
            style: TextStyle(color: Colors.red, fontSize: 20.0)),
      ],
    );
  }

  Widget buildText(String text) {
    final lines = isReadMore ? null : 5;
    return Text(
      text,
      maxLines: lines,
      overflow: isReadMore ? TextOverflow.visible : TextOverflow.ellipsis,
      style: TextStyle(fontSize: 15),
    );
  }

  void _bottomSheet(ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        context: ctx,
        backgroundColor: color5,
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        builder: (BuildContext context) {
          return Padding(
              padding: const EdgeInsets.fromLTRB(5, 2, 5, 5),
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Trailer',
                          style: TextStyle(fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                child: Icon(Icons.close, size: 30),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  shape: BoxShape.circle,

                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  //ShowOnlineTrailerWidget(_trailerModel.trailers![0].url ?? ''),
                  ChewiePlayer(widget._infoModel.trailers![0].url!),
                  SizedBox(height: 15),
                  Divider(),
                  textInfo('title', widget._infoModel.title),
                  Divider(),
                  SizedBox(height: 15),
                  textInfo(
                      'genres',
                      widget._infoModel.genres.toString().substring(
                          1, widget._infoModel.genres.toString().length - 1)),
                  Divider(),
                  SizedBox(height: 15),
                  textInfo('type', widget._infoModel.type),
                  Divider(),
                  SizedBox(height: 15),
                  textInfo('status', widget._infoModel.status),
                  Divider(),
                  SizedBox(height: 15),
                  textInfo('summary', widget._infoModel.summary!.english),
                  SizedBox(height: 10),
                ],
              ));
        });
  }

  Widget textInfo(String key, String? value) {
    if (value != null && value != '')
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            key + " : ",
            style: const TextStyle(color: Colors.cyan, fontSize: 17),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              value,
              maxLines: 5,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      );
    else
      return const SizedBox(width: 1);
  }
}

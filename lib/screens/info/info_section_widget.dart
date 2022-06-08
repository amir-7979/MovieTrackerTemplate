import 'package:app04/screens/info/part.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../icons/my_flutter_app_icons.dart';
import '../../utilities/cache_image.dart';
import '../../utilities/consts.dart';
import '../../utilities/http_helper.dart';
import '../helper_widgets/trailer_widget_widget.dart';

class InfoSectionWidget extends StatefulWidget {
  final dynamic _infoModel;

  const InfoSectionWidget(this._infoModel, {Key? key}) : super(key: key);

  @override
  State<InfoSectionWidget> createState() => _InfoSectionWidgetState();
}

class _InfoSectionWidgetState extends State<InfoSectionWidget> {
  bool summery = true;
  bool isReadmore = false;

  bool bookmark = false;

  @override
  Widget build(BuildContext context) {
    print('like : ${widget._infoModel.likeOrDislike}');
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
                  child: FittedBox(
                    child: CacheImage(
                        widget._infoModel.posters.isNotEmpty ? widget._infoModel
                            .posters[0].url : 'assets/images/no_image.jpg'),
                    fit: BoxFit.fill,
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
                              setState(() {
                                if (widget._infoModel.likeOrDislike == 'like') {
                                  widget._infoModel.likeOrDislike = '';
                                  widget._infoModel.likesCount--;
                                } else if (widget._infoModel.likeOrDislike ==
                                    'dislike') {
                                  widget._infoModel.likeOrDislike = 'like';
                                  widget._infoModel.likesCount++;
                                  widget._infoModel.dislikesCount--;
                                } else {
                                  widget._infoModel.likeOrDislike = 'like';
                                  widget._infoModel.likesCount++;
                                }
                              });
                              int res = await likeOrDislikeMovie(
                                  'like',
                                  widget._infoModel.id!,
                                  (widget._infoModel.likeOrDislike == 'like')
                                      ? false
                                      : true);
                              if (res == 200) {
                                setState(() {});
                              } else {
                                Fluttertoast.showToast(
                                    msg: "No Connection !",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 14.0
                                );
                              }

                            },
                            icon: Icon(
                              MyFlutterApp.thumbs_up,
                              color: (widget._infoModel.likeOrDislike == 'like')
                                  ? Colors.green
                                  : Colors.grey,
                            )),
                        Text(
                            '${widget._infoModel.likesCount
                                .toString()}  -  ${widget._infoModel
                                .dislikesCount.toString()}'),
                        IconButton(
                            splashRadius: 0.1,
                            onPressed: () async {
                              setState(() {
                                if (widget._infoModel.likeOrDislike ==
                                    'dislike') {
                                  widget._infoModel.likeOrDislike = '';
                                  widget._infoModel.dislikesCount--;
                                } else if (widget._infoModel.likeOrDislike ==
                                    'like') {
                                  widget._infoModel.likeOrDislike = 'dislike';
                                  widget._infoModel.dislikesCount++;
                                  widget._infoModel.likesCount--;
                                } else {
                                  widget._infoModel.likeOrDislike = 'dislike';
                                  widget._infoModel.dislikesCount++;
                                }
                              });
                              int res = await likeOrDislikeMovie(
                                  'dislike',
                                  widget._infoModel.id!,
                                  (widget._infoModel.likeOrDislike == 'dislike')
                                      ? false
                                      : true);
                              if (res == 200) {
                                setState(() {});
                              } else {
                                Fluttertoast.showToast(
                                    msg: "No Connection !",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 14.0
                                );
                              }
                            },
                            icon: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                              child: Icon(
                                MyFlutterApp.thumbs_down,
                                color: (widget._infoModel.likeOrDislike ==
                                    'dislike')
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            )),
                      ],
                    ),
                    IconButton(
                        splashRadius: 0.1,
                        onPressed: () => setState(() => bookmark = !bookmark),
                        icon: Icon(
                          Icons.bookmark,
                          color: (bookmark) ? Colors.blue : Colors.grey,
                        )),
                    IconButton(
                      splashRadius: 0.1,

                      onPressed: () {},
                      icon: const Icon(
                        Icons.share_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(
                      splashRadius: 0.1,

                      onPressed: () {},
                      icon: const Icon(
                        Icons.download_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(
                      splashRadius: 0.1,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.play_arrow,
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
          width: screenWidth,
          height: 25,
          child: ListView(scrollDirection: Axis.horizontal, children: [
            Text(
              widget._infoModel.type,
              style: const TextStyle(fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: 1,
                height: 20,
                color: Colors.white,
              ),
            ),
            Text(
              widget._infoModel.year,
              style: const TextStyle(fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: 1,
                height: 20,
                color: Colors.white,
              ),
            ),
            Text(
              widget._infoModel.rated,
              style: const TextStyle(fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: 1,
                height: 20,
                color: Colors.white,
              ),
            ),
            Text(
              widget._infoModel.duration.toString(),
              style: const TextStyle(fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: 1,
                height: 20,
                color: Colors.white,
              ),
            ),
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
          ]),
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
                showDialog(
                    context: context,
                    useSafeArea: false,
                    barrierDismissible: false,
                    builder: (BuildContext context) =>
                        TrailerWidget(
                            widget._infoModel.trailers[0].url));
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
                  isReadmore = !isReadmore;
                });
              },
              child: Text((isReadmore ? 'Read Less' : 'Read More'))),
        ),
        const SizedBox(height: 20),

        const Text('INFO', style: TextStyle(color: Colors.red, fontSize: 20.0)),

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
                .substring(1, widget._infoModel.genres
                .toString()
                .length - 1)),

        const SizedBox(height: 10),

        const Text('Update',
            style: TextStyle(color: Colors.red, fontSize: 20.0)),

        const SizedBox(height: 10),

        Part("Quality", widget._infoModel.latestData?.quality),

        Part("HardSub", widget._infoModel.latestData?.hardSub),

        Part("Dubbed", widget._infoModel.latestData?.dubbed),

        const SizedBox(height: 10),

        const Text('Download',
            style: TextStyle(color: Colors.red, fontSize: 20.0)),
      ],
    );
  }

  Widget buildText(String text) {
    // if read more is false then show only 3 lines from text
    // else show full text
    final lines = isReadmore ? null : 5;
    return Text(
      text,
      maxLines: lines,
      // overflow properties is used to show 3 dot in text widget
      // so that user can understand there are few more line to read.
      overflow: isReadmore ? TextOverflow.visible : TextOverflow.ellipsis,
    );
  }
}

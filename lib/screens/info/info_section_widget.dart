import 'package:app04/screens/info/part.dart';
import 'package:flutter/material.dart';
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
  bool isReadmore= false;


  @override
  Widget build(BuildContext context) {
    print('like : ${widget._infoModel.likeOrDislike}');
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 10, 2, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: screenWidth,
            height: screenWidth,
            child: FittedBox(
              child: CacheImage(widget._infoModel.posters?[0].url),
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () async {
                      setState(() {
                        (widget._infoModel.likeOrDislike != 'like') ? widget._infoModel.likeOrDislike = 'like' : widget._infoModel.likeOrDislike ='';
                      });
                      await likeOrDislikeMovie('like', widget._infoModel.id!, (widget._infoModel.likeOrDislike == 'like') ? false : true);
                    },
                    icon: Icon(
                      MyFlutterApp.thumbs_up,
                      color: (widget._infoModel.likeOrDislike == 'like') ? Colors.green : Colors.grey ,
                    )),
                Text('${widget._infoModel.likesCount.toString()}   -   ${widget._infoModel.dislikesCount.toString()}'),

                IconButton(
                    onPressed: () async {
                      setState(() {
                        (widget._infoModel.likeOrDislike != 'dislike') ? widget._infoModel.likeOrDislike = 'dislike' : widget._infoModel.likeOrDislike ='';
                      });
                      await likeOrDislikeMovie('dislike', widget._infoModel.id!, (widget._infoModel.likeOrDislike == 'dislike') ? false : true);
                    },
                    icon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                      child: Icon(
                        MyFlutterApp.thumbs_down,
                        color: (widget._infoModel.likeOrDislike == 'dislike') ? Colors.red : Colors.grey ,
                      ),
                    )),
              ],
            ),
          ),

          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: screenWidth,
            child: Text(
              widget._infoModel.rawTitle ?? '',
              style: const TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
          Row(
            children: [
              const Text(
                'PLOT',
                style: TextStyle(color: Colors.red, fontSize: 20.0),
              ),

              (widget._infoModel.trailers != null) ? ((widget._infoModel.trailers[0].url != null) ? TextButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        useSafeArea: false,
                        barrierDismissible: false,
                        builder: (BuildContext context) => TrailerWidget(widget._infoModel.trailers[0].url));
                    },
                  child: const Text('watch trailer'),) : const SizedBox(height: 50)) :  const SizedBox(height: 50) ,
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
            child: TextButton(onPressed: (){
              setState(() {
                // toggle the bool variable true or false
                isReadmore = !isReadmore;
              });
            }, child: Text((isReadmore?'Read Less' : 'Read More'))),
          ),
          const SizedBox(height: 20),

          const Text('INFO',
              style: TextStyle(color: Colors.red, fontSize: 20.0)),

          const SizedBox(height: 20),

          Part("Type", widget._infoModel.type),

          const SizedBox(height: 10),

          Part("Duration", widget._infoModel.duration.toString()),
          const SizedBox(height: 10),

          Part("Year", widget._infoModel.year),
          const SizedBox(height: 10),

          Part("Country", widget._infoModel.country),
          const SizedBox(height: 10),

          Part("Language", widget._infoModel.movieLang),
          const SizedBox(height: 10),

          Part("Rate", widget._infoModel.rated),
          const SizedBox(height: 10),

          //Part("Directors", widget._infoModel.directors.toString().substring(1, widget._infoModel.directors.toString().length-1)),

          //Part("Writers", widget._infoModel.writers.toString().substring(1, widget._infoModel.writers.toString().length-1)),

          Part(
              "Genre",
              widget._infoModel.genres.toString().substring(
                  1, widget._infoModel.genres.toString().length - 1)),

          const SizedBox(height: 10),

          const Text('Update',
              style: TextStyle(color: Colors.red, fontSize: 20.0)),

          const SizedBox(height: 10),

          Part("Quality", widget._infoModel.latestData?.quality),

          Part("HardSub", widget._infoModel.latestData?.hardSub),

          Part("Dubbed", widget._infoModel.latestData?.dubbed),

          const SizedBox(height: 10),

          const Text('Download Links',
              style: TextStyle(color: Colors.red, fontSize: 20.0)),
        ],
      ),
    );
  }
  Widget buildText(String text){

    // if read more is false then show only 3 lines from text
    // else show full text
    final lines = isReadmore ? null : 5;
    return Text(
      text,
      maxLines: lines,
      // overflow properties is used to show 3 dot in text widget
      // so that user can understand there are few more line to read.
      overflow: isReadmore ? TextOverflow.visible: TextOverflow.ellipsis,
    );
  }
}


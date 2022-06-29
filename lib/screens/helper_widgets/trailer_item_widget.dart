import 'package:app04/screens/helper_widgets/trailer_part_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../models/trailer_model.dart';
import '../../utilities/cache_image.dart';
import '../../utilities/consts.dart';

class ShortTrailerItemWidget extends StatelessWidget {
  TrailerModel _trailerModel;
  final double width = 180.0;

  ShortTrailerItemWidget(this._trailerModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
      child: InkWell(
          onTap: () async => _trailerModel.trailers![0].url != null ? _bottomSheet(context) : (){},
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 150,
                    width: width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: CacheImage(_trailerModel.posters![0].url),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    width: width,
                    child: Center(
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.play_arrow,
                          size: 45,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    height: 150,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 30,
                        height: 30,
                        child: Center(
                            child: Text(_trailerModel.rating!.imdb.toString())),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ThemeData().primaryColor),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: width,
                child: Text(
                  _trailerModel.title!,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Icon(
                      Icons.circle,
                      size: 12,
                    ),
                  ),
                  Text(
                    _trailerModel.type!,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  void _bottomSheet(ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
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
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close),
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(5, 5),
                              shape: const CircleBorder(),
                              elevation: 5,
                              primary: Colors.redAccent),
                        )
                      ],
                    ),
                  ),
                  //ShowOnlineTrailerWidget(_trailerModel.trailers![0].url ?? ''),
                  ChewiePlayer(_trailerModel.trailers![0].url!),
                  SizedBox(height: 15),
                  Divider(),

                  textInfo('title', _trailerModel.title),
                  Divider(),
                  SizedBox(height: 15),
                  textInfo(
                      'genres',
                      _trailerModel.genres.toString().substring(
                          1, _trailerModel.genres.toString().length - 1)),
                  Divider(),
                  SizedBox(height: 15),
                  textInfo('type', _trailerModel.type),
                  Divider(),
                  SizedBox(height: 15),
                  textInfo('status', _trailerModel.status),
                  Divider(),
                  SizedBox(height: 15),
                  textInfo('summary', _trailerModel.summary!.english),
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
            style: const TextStyle(color: Colors.cyan, fontSize: 18),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              value,
              maxLines: 5,
              style: const TextStyle(color: Colors.white, fontSize: 18),
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

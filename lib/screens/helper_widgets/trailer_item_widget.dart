import 'package:app04/screens/helper_widgets/trailer_part_widget.dart';
import 'package:flutter/material.dart';
import '../../models/trailer_model.dart';
import '../../utilities/cache_image.dart';
import '../../utilities/consts.dart';
import '../info/info_screen.dart';

class ShortTrailerItemWidget extends StatelessWidget {
  TrailerModel _trailerModel;
  final double width = 180.0;

  ShortTrailerItemWidget(this._trailerModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => InfoScreen(args: {'id': _trailerModel.sId, 'url': _trailerModel.posters!.isNotEmpty ? _trailerModel.posters![0].url ?? '' : 'assets/images/no_image.jpg', 'type': _trailerModel.type}))),
                child: SizedBox(
                  height: 150,
                  width: width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: CacheImage(_trailerModel.posters![0].url),
                  ),
                ),
              ),
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () async => _trailerModel.trailers![0].url != null ? _bottomSheet(context) : (){},
                  icon: const Icon(
                    Icons.play_arrow,
                    size: 30,
                    color: Colors.white,
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
      ),
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
                    padding: const EdgeInsets.only(left: 8),
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
/*
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close, size: 5),
                          style: ElevatedButton.styleFrom(
                            alignment: Alignment.center,
                            fixedSize: const Size(1, 1),
                              shape: const CircleBorder(),
                              elevation: 5,

                              primary: Colors.redAccent),
                        )
*/
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
          SizedBox(width: 3,),
          Text(
            key + " : ",
            style: const TextStyle(color: Colors.cyan, fontSize: 17),
          ),
          const SizedBox(
            width: 2,
          ),
          Expanded(
            child: Text(
              value,
              maxLines: 4,
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

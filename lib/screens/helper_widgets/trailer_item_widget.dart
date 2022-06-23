import 'package:app04/screens/helper_widgets/trailer_part_widget.dart';
import 'package:flutter/material.dart';
import '../../utilities/cache_image.dart';

class ShortTrailerItemWidget extends StatelessWidget {
  String name, type;
  String? imageUrl, trailerUrl;
  double? rate;
  final double width = 180.0;

  ShortTrailerItemWidget(
      this.name, this.type, this.rate, this.imageUrl, this.trailerUrl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
      child: InkWell(
          onTap: () async {
              showDialog(
                  context: context,
                  useSafeArea: false,
                  barrierDismissible: false,
                  builder: (BuildContext context) => TrailerPartWidget(trailerUrl ?? ''));
          },
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 150,
                    width: width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),

                      child:FittedBox(
                      child: (imageUrl != null && imageUrl != '')
                          ? CacheImage(imageUrl)
                          : const Padding(
                              padding: EdgeInsets.fromLTRB(7, 1, 7, 1),
                              child: Text('No Image'),
                            ),
                      fit: BoxFit.fill,
                    ),
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
                        child: Center(child: Text(rate.toString())),
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
                  name,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Icon(Icons.circle, size: 12,),
                  ),
                  Text(type ,
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
}

import 'package:flutter/material.dart';
import '../../utilities/cache_image.dart';
import '../../utilities/consts.dart';
import '../../utilities/http_helper.dart';
import '../more/more_screen.dart';

class GenreItemWidget extends StatelessWidget {
  String id;
  int count;
  String? url;

  GenreItemWidget(this.id, this.count, this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: GridTile(
              child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(MoreScreen.routeName, arguments: {'argName': id, 'function':getGenreItems});
                  },
                  child: FittedBox(child: CacheImage(url), fit: BoxFit.fill)),
              footer: SizedBox(
                height: 25,
                child: GridTileBar(
                  backgroundColor: const Color.fromARGB(180, 0, 0, 0),
                  title: Text(
                    id.replaceAll('_', ' '),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: -3,
            left: -3,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 4, 2),
                    child: Text(count.toString(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: redLable),),
                  ),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: color4,

                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}

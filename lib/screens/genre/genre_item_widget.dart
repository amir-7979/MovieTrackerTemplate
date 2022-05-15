import 'package:flutter/material.dart';

import '../../utilities/cache_image.dart';
import '../specific_genre/specific_genre_screen.dart';

class GenreItemWidget extends StatelessWidget {

   String id;
   int count;
   String? url;

   GenreItemWidget(this.id, this.count, this.url, {Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              SpecificGenreScreen.routeName,
              arguments: id,
            );
          },
          child: FittedBox(
            child:  CacheImage(url),
            fit: BoxFit.fill
          )
        ),

        footer: SizedBox(
          height: 25,
          child: GridTileBar(
            backgroundColor: const Color.fromARGB(180, 0, 0, 0),
            title: Text(id,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    ),
  );
}
}
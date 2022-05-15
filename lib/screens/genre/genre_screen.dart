import 'package:flutter/material.dart';
import '../../models/genre_model.dart';
import '../../utilities/http_helper.dart';
import 'genre_item_widget.dart';

class GenresScreen extends StatelessWidget {
  static const routeName = '/category-screen';

  const GenresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getGenres(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GenresList(snapshot.data);
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 4,
              ),
            );
          }
        });
  }
}

Widget GenresList(List<Genre> items) {
  return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: items.length,
      itemBuilder: (BuildContext ctx, index) {
        return GenreItemWidget(items[index].genre, items[index].count, items[index].poster.url);
      },
  );
}

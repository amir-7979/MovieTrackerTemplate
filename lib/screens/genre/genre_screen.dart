import 'package:app04/utilities/consts.dart';
import 'package:flutter/material.dart';
import '../../models/genre_model.dart';
import '../../utilities/http_helper.dart';
import '../helper_widgets/shimmer_custom_widget.dart';
import 'genre_item_widget.dart';

class GenresScreen extends StatelessWidget {
  static const routeName = '/category-screen';
  const GenresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: color4,
        appBar: AppBar(title: Text('Genre'),),
        body: FutureBuilder(
            future: getGenres(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return genresList(snapshot.data);
              } else {
                return genresListShimmer();
              }
            }),
      ),
    );
  }
}

Widget genresList(List<Genre> items) {
  return GridView.builder(
    padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
    gridDelegate:
    const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    itemCount: items.length,
    itemBuilder: (BuildContext ctx, index) {
      return GenreItemWidget(items[index].genre, items[index].count, items[index].poster.url);
    },
  );
}

Widget genresListShimmer() {
  return GridView.builder(
    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
    gridDelegate:
    const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    itemCount: 48,
    itemBuilder: (BuildContext ctx, index) {
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child:  CustomWidget.rectangular(
                    height: screenWidth /3 , width: screenWidth /3)),
          ),
        ],
      );
    },
  );
}

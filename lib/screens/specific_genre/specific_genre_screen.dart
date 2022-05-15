import 'package:app04/screens/specific_genre/specific-genre_item.dart';
import 'package:app04/utilities/http_helper.dart';
import 'package:flutter/material.dart';


class SpecificGenreScreen extends StatelessWidget {
  static const routeName = '/specific-genre-screen';


  @override
  Widget build(BuildContext context) {
    String name = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: FutureBuilder(
          future: getGenreItems(name),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SpecificGenreItem(snapshot.data[index].id, snapshot.data[index].rawTitle, snapshot.data[index].type, snapshot.data[index].rating.imdb, int.parse(snapshot.data[index].year), snapshot.data[index].posters[0].url);
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 4,
                ),
              );
            }
          }),
    );
  }
}

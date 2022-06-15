import 'package:app04/screens/helper_widgets/vertical_item_widget.dart';
import 'package:app04/screens/specific_genre/specific-genre_item.dart';
import 'package:app04/utilities/http_helper.dart';
import 'package:flutter/material.dart';
import '../../utilities/consts.dart';

class SpecificGenreScreen extends StatelessWidget {
  static const routeName = '/specific-genre-screen';


  @override
  Widget build(BuildContext context) {
    String name = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: color4,
      appBar: AppBar(title: Text(name)),
      body: FutureBuilder(
          future: getGenreItems(name),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return VerticalItemWidget(snapshot.data[index]);
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

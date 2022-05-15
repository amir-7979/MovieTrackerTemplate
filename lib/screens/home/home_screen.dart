import 'package:app04/screens/home/second_part_widget.dart';
import 'package:app04/screens/home/sorted_movies_widget.dart';
import 'package:app04/screens/home/third_part_widget.dart';
import 'package:app04/screens/home/tops_by_like_widget.dart';
import 'package:app04/screens/search/search_screen.dart';
import 'package:flutter/material.dart';

import 'first_part_widget.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? profileUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: const [
          Text('Movie Tracker'),
        ]),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SearchScreen.routeName);
            },
            icon: const Icon(
              Icons.search,
              size: 35,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          FirstPartWidget(),
          SecondPartWidget(),
          ThirdPartWidget(),
          TopsByLikeWidget(),
          SortedMoviesWidget(),
        ],
      ),
    );
  }
}

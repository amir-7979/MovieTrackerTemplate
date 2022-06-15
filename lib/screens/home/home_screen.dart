import 'package:app04/screens/home/second_part_widget.dart';
import 'package:app04/screens/home/sorted_movies_widget.dart';
import 'package:app04/screens/home/third_part_widget.dart';
import 'package:app04/screens/home/tops_by_like_widget.dart';
import 'package:app04/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import '../../utilities/consts.dart';
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
      backgroundColor: color4,
      appBar: AppBar(
        title: Row(children: [
          Text('Movie Tracker', style: Theme.of(context).textTheme.headline1,),
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
        padding: const EdgeInsets.only(left: 5),
        children: [
          const FirstPartWidget(),
          SecondPartWidget(),
          const ThirdPartWidget(),
          const TopsByLikeWidget(),
          const SortedMoviesWidget(),
        ],
      ),
    );
  }
}

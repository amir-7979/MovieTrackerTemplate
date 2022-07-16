import 'package:app04/screens/home/second_part_widget.dart';
import 'package:app04/screens/home/sorted_movies_widget.dart';
import 'package:app04/screens/home/tops_by_like_widget.dart';
import 'package:app04/screens/home/trailer_part.dart';
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
  bool init = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: color4,
        appBar: AppBar(
          title: Row(children: [
            Text(
              'Movie Tracker',
              style: Theme.of(context).textTheme.headline1,
            ),
          ]),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(5, 5, 2, 5),
          cacheExtent: 2000,
          children: [
            const MultiplePartWidget(),
            TimeLinePartWidget(),
            TrailerPart(),
            ThirdPartWidget(),
            SortedMovie('boxOffice'),
            SortedMovie('popular'),
            SortedMovie('top'),
            SortedMovie('animeTopAiring'),
            SortedMovie('animeTopComingSoon'),
          ],
        ),
      ),
    );
  }
}

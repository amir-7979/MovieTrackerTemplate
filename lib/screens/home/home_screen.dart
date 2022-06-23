import 'package:app04/screens/home/second_part_widget.dart';
import 'package:app04/screens/home/sorted_movies_widget.dart';
import 'package:app04/screens/home/tops_by_like_widget.dart';
import 'package:app04/screens/home/trailer_part.dart';
import 'package:app04/screens/profile/profile_page_screen.dart';
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
  bool init = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color4,
      appBar: AppBar(
        leading:  Padding(
          padding: const EdgeInsets.all(2.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 10,
            child: IconButton(icon: Icon(Icons.person) , onPressed: ()=> Navigator.push(context, MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ))),
          ),
        ),
        title: Row(children: [
          Text('Movie Tracker', style: Theme.of(context).textTheme.headline1,),
        ]),

      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(5, 5, 2, 5),
        children: [
          const MultiplePartWidget(),
          TimeLinePartWidget(),
          const TrailerPart(),
          const ThirdPartWidget(),
          SortedMovie('boxOffice'),
          SortedMovie('popular'),
          SortedMovie('top'),
          SortedMovie('animeTopAiring'),
          SortedMovie('animeTopComingSoon'),
        ],
      ),
    );
  }
}

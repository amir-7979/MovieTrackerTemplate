import 'package:app04/screens/bookmark/bookmark_screen.dart';
import 'package:app04/screens/home/home_screen.dart';
import 'package:app04/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import '../../utilities/consts.dart';
import '../genre/genre_screen.dart';
import '../helper_widgets/internet_alert_dialog_widget.dart';
import '../profile/profile_page_screen.dart';

const _kPages = <String, IconData>{
  'setting': Icons.settings,
  'genre': Icons.category,
  'home': Icons.home,
  'save': Icons.bookmark,
  'search': Icons.search,
};

class StartScreen extends StatefulWidget {
  static const routeName = '/start-screen';

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final TabStyle _tabStyle = TabStyle.textIn;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 2,
      child: Scaffold(
        backgroundColor: color4,
        body: (activeConnection == false) ? const InternetAlertDialogWidget() : Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  ProfileScreen(),
                  const GenresScreen(),
                  HomeScreen(),
                  const BookMarkScreen(),
                  SearchScreen(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: ConvexAppBar.badge(
          const <int, dynamic>{},
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 5,
          height: 42,
          style: _tabStyle,
          items: <TabItem>[
            for (final entry in _kPages.entries)
              TabItem(icon: entry.value, title: entry.key),
          ],
        ),
      ),
    );
  }
}

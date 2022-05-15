import 'package:app04/screens/download/download_screen.dart';
import 'package:flutter/material.dart';
import '../screens/active_session/active_sessions_screen.dart';
import '../screens/genre/genre_screen.dart';
import '../screens/info/info_screen.dart';
import '../screens/login_sgin_up/login_screen.dart';
import '../screens/login_sgin_up/sign_up_screen.dart';
import '../screens/more/more_screen.dart';
import '../screens/profile/profile_page_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/specific_genre/specific_genre_screen.dart';
import '../screens/start/start_screen.dart';
import 'http_helper.dart';

late double screenWidth;
late double screenHeight;
const double itemWidth = 120;
const double itemHeight = 180;
bool isLoggedIn = false;
bool activeConnection = false;
bool isLodding = true;

const color1 = Color(0xff5f1f46);
const color2 = Color(0xff321177);
const color3 = Color(0xff626aac);
const disabled = Color(0xff282a2c);
const active = Color(0xff20a311);
const color4 = Color(0xff21212d);



final darkThem = ThemeData(
  brightness: Brightness.dark,
  accentColor: color3,
  primaryColor: color1,
  appBarTheme: const AppBarTheme(
    color: color1,
    toolbarHeight: 45,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
    ),
  ),
// font
  fontFamily: 'Georgia',
//text style
  textTheme: const TextTheme(
    headline1:
    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    headline6:
    TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
    bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),

  ),
);

final routes = {
  StartScreen.routeName: (_) => StartScreen(),
  MoreScreen.routeName: (_) => MoreScreen(),
  LoginScreen.routeName: (_) => LoginScreen(),
  SignUpScreen.routeName: (_) => SignUpScreen(),
  SearchScreen.routeName: (_) => const SearchScreen(),
  ProfileScreen.routeName: (_) => const ProfileScreen(),
  InfoScreen.routeName: (_) => InfoScreen(),
  GenresScreen.routeName: (_) => const GenresScreen(),
  SpecificGenreScreen.routeName: (_) => SpecificGenreScreen(),
  ActiveSessionsScreen.routeName: (_) => const ActiveSessionsScreen(),
  DownloadScreen.routeName: (_) =>  const DownloadScreen(),
};

Future<void> initialize() async {
  await preInit();
  await checkUserConnection();
    if (activeConnection && isLoggedIn) await getToken();
  isLodding = false;

}


import 'package:app04/models/search_filter_model.dart';
import 'package:app04/screens/download/download_screen.dart';
import 'package:app04/screens/time_line/time_line_vertical.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/active_session/active_sessions_screen.dart';
import '../screens/genre/genre_screen.dart';
import '../screens/info/info_screen.dart';
import '../screens/login_sgin_up/login_screen.dart';
import '../screens/login_sgin_up/sign_up_screen.dart';
import '../screens/more/more_screen.dart';
import '../screens/person_info_screen/PersonInfoScreen.dart';
import '../screens/profile/profile_page_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/staff/staff_screen.dart';
import '../screens/start/start_screen.dart';
import 'http_helper.dart';

late double screenWidth;
const double itemWidth = 120;
const double itemHeight = 180;
bool isLoggedIn = false;
bool activeConnection = false;
bool isLodding = true;
//bool showShimmer = true;

const color1 = Color(0xff313144);
const color2 = Color(0xffdcd31a);
const color3 = Color(0xff626aac);
const disabled = Color(0xff282a2c);
const active = Color(0xff20a311);
const color4 = Color(0xff21212d);
const redLable = Color(0xffffcb00);
const yellow1 = Color(0xffffa600);
const black1 = Color(0x98000000);
const color5 = Color(0xff2d2d3d);

SearchFilter constSearchFilter = SearchFilter('movie-serial-anime_movie-anime_serial', '1990-2022', '0-10', '0-10');
String constSearchFilter2 = '/movie-serial-anime_movie-anime_serial/high/1990-2022/0-10/0-10/';

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
  textTheme: TextTheme(
    headline1:
      GoogleFonts.ubuntu(textStyle: const TextStyle(fontSize: 19.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic)),
    headline2:
    GoogleFonts.ubuntu(textStyle: const TextStyle(fontSize: 18.0, color: Colors.white)),
    bodyText2: const TextStyle(fontSize: 14.0, fontFamily: 'Hind'),

  ),
);

final routes = {
  StartScreen.routeName: (_) => StartScreen(),
  MoreScreen.routeName: (_) => MoreScreen(),
  LoginScreen.routeName: (_) => LoginScreen(),
  SignUpScreen.routeName: (_) => SignUpScreen(),
  SearchScreen.routeName: (_) => const SearchScreen(),
  ProfileScreen.routeName: (_) => const ProfileScreen(),
  InfoScreen.routeName: (_) => const InfoScreen(),
  GenresScreen.routeName: (_) => const GenresScreen(),
  ActiveSessionsScreen.routeName: (_) => const ActiveSessionsScreen(),
  DownloadScreen.routeName: (_) =>  const DownloadScreen(),
  VerticalTimeLine.routeName: (_) =>  const VerticalTimeLine(),
  PersonInfoScreen.routeName: (_) => const PersonInfoScreen(),
  StaffScreen.routeName: (_) => StaffScreen(),
};

Future<void> initialize() async {
  await preInit();
  await checkUserConnection();
    if (activeConnection && isLoggedIn) await getToken();
  isLodding = false;

}


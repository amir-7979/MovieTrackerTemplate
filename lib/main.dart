import 'package:app04/screens/splash/splash_screen.dart';
import 'package:app04/utilities/consts.dart';
import 'package:app04/utilities/file_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> main() async {
  _callFolderCreationMethod() async {
  }
  await FlutterDownloader.initialize(
      debug: true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl: true // option: set to false to disable working with http links (default: false)
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: [SystemUiOverlay.top]);

    return MaterialApp(
      theme: darkThem,
      debugShowCheckedModeBanner: false,
      routes: routes,
      builder: EasyLoading.init(),
      home: const SplashScreen(),
    );
  }
}

import 'package:app04/screens/splash/splash_screen.dart';
import 'package:app04/utilities/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkThem,
      debugShowCheckedModeBanner: false,
      routes: routes,
      builder: EasyLoading.init(),
      home: const SplashScreen(),
    );
  }
}

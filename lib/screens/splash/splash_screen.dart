import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../../utilities/consts.dart';
import '../login_sgin_up/login_screen.dart';
import '../start/start_screen.dart';

class SplashScreen extends StatelessWidget {
    const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: color4,
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: 300,
          width: 300,
          child: Column(
            children: [
              SizedBox(
                height: 150,
                width: 300,
                child: AnimatedSplashScreen.withScreenFunction(
                  backgroundColor: color4,
                  splash: SizedBox(
                    height: 150,
                    width: 150,
                    child: FittedBox(
                        fit: BoxFit.cover,
                        child: Image.asset('assets/images/splash.png')),
                  ),
                  screenFunction: () async {
                    await initialize();
                    //await Future.delayed(Duration(seconds: 1));
                    return (isLoggedIn) ? StartScreen() : LoginScreen();
                    //return SplitScreen();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TyperAnimatedText(
                      ' ',
                      speed: const Duration(milliseconds: 100),
                    ),

                    TyperAnimatedText('Movie Tracker',
                      curve: Curves.linear,
                      speed: const Duration(milliseconds: 100),
                      textStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

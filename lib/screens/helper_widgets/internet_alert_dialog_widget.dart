import 'package:app04/screens/start/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utilities/consts.dart';
import '../../utilities/http_helper.dart';

class InternetAlertDialogWidget extends StatelessWidget {
  const InternetAlertDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      title: const Text('No Internet Connection'),
      content: const Text('check your internet connection and try again later'),
      actions: [
        TextButton(
          onPressed: () {SystemNavigator.pop();},
          child: const Text('EXIT'),
        ),
        TextButton(
          onPressed: () async {
            await checkUserConnection();
            if(activeConnection == true) {
              Navigator.of(context).pushReplacementNamed(StartScreen.routeName);
            }
            },
          child: const Text('RETY'),
        ),
      ],
    );
  }
}


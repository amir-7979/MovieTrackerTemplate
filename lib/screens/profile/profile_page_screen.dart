import 'package:app04/screens/favorite/Favorite_screen.dart';
import 'package:app04/screens/login_sgin_up/login_screen.dart';
import 'package:flutter/material.dart';
import '../../models/profile_model.dart';
import '../../utilities/consts.dart';
import '../../utilities/http_helper.dart';
import '../active_session/active_sessions_screen.dart';
import 'field_widget.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile-screen';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color4,
      appBar: AppBar(title: Text('Profile'), actions: [
        IconButton(
            splashRadius: 0.1,
            onPressed: () async {
              //Navigator.of(context).pop();
              await logOutUser();

              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
            icon: const Icon(Icons.logout)),
      ]),
      body: FutureBuilder(
          future: myProfile(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ProfileWidget(snapshot.data, context);
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 4,
              ),
            );
          }),
    );
  }

  Widget ProfileWidget(Profile profile, BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: InkWell(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: Image.network(
                      profile.defaultProfile,
                      height: 120.0,
                      width: 120.0,
                    ),
                  )),
            ),
            const SizedBox(height: 20),
            FieldWidget('Name', profile.publicName),
            FieldWidget('Username', profile.publicName),
            (profile.emailVerified)
                ? FieldWidget('Email (verified)', profile.email)
                : FieldWidget('Email', profile.email),
            FieldWidget('Bio', profile.bio),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: () {}, child: const Text('Friends')),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavoriteScreen(),
                          ),
                        );
                      },
                      child: const Text('Liked')),
                  TextButton(onPressed: () {}, child: const Text('status')),
                  TextButton(onPressed: () {}, child: const Text('Favorites')),
                ],
              ),
            ),
            if (!profile.emailVerified)
              ElevatedButton(
                  onPressed: () {
                    sendVerifyEmail();
                    showDialog(
                        context: context,
                        useSafeArea: false,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Alert'),
                            content:
                                const Text('Please Check MailBox or SpamBox'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: const Text("verify Email")),
            ElevatedButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed(ActiveSessionsScreen.routeName),
                child: const Text("Devices")),
          ],
        ),
      ),
    );
  }
}

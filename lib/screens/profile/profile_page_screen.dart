import 'dart:ffi';
import 'dart:io';
import 'package:app04/screens/favorite/Favorite_screen.dart';
import 'package:app04/screens/login_sgin_up/login_screen.dart';
import 'package:app04/utilities/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/profile_model.dart';
import '../../utilities/consts.dart';
import '../../utilities/http_helper.dart';
import '../active_session/active_sessions_screen.dart';
import 'field_widget.dart';
import 'image_profile.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';

  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  bool  refresh = false;

  void refreshFunction(){
    setState((){
      refresh = true;
    });
    Future.delayed(Duration(microseconds: 80));
    setState((){
      refresh = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: color4,
        appBar: AppBar(title: Text('Setting'), actions: [
          IconButton(
              splashRadius: 0.1,
              onPressed: () async {
                //Navigator.of(context).pop();
                await logOutUser();
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName);
              },
              icon: const Icon(Icons.logout)),
        ]),
        body: FutureBuilder(
            future: myProfile(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && !refresh) {
                return ProfileScreenWidget(snapshot.data, context);
              } else
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 4,
                  ),
                );
            }),
      ),
    );
  }

  Widget ProfileScreenWidget(Profile profile, BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 160,
                  width: 160,
                  child: Stack(children: [
                    InkWell(
                      onTap: () => showProfilesPicturesDialog(context, profile),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(150)),
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: CacheImage(profile.profileImages.length == 0
                                ? profile.defaultProfile
                                : profile.profileImages[0]),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: addPhotoButton(profile),
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 5),
              FieldWidget('Name', profile.publicName),
              FieldWidget('Username', profile.publicName),
              (profile.emailVerified)
                  ? FieldWidget('Email (verified)', profile.email)
                  : FieldWidget('Email', profile.email),
              FieldWidget('Bio', profile.bio),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xff3f3e3e)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavoriteScreen(),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.favorite_border),
                          SizedBox(width: 10),
                          Text('Liked Movies')
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xff3f3e3e)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                      onTap: () => Navigator.of(context)
                          .pushNamed(ActiveSessionsScreen.routeName),
                      child: Row(
                        children: [
                          Icon(Icons.devices),
                          SizedBox(width: 10),
                          Text('Devices')
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (!profile.emailVerified)
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Color(0xff3f3e3e)),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: InkWell(
                        onTap: () {
                          sendVerifyEmail();
                          verifyDialog(context);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.verified),
                            SizedBox(width: 10),
                            Text('Verify Email')
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void showProfilesPicturesDialog(BuildContext context, Profile profile) {
    showDialog(
        context: context,
        useSafeArea: false,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: color5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: SizedBox(
                width: screenWidth * 3 / 4,
                height: screenWidth * 3 / 4,
                child: ImageProfile(context, profile, refreshFunction)),
          );
        });
  }

  Future<void> uploadImageFunction(
      ImageSource imageSource, Profile profile) async {
    print('*******************************************************');
    final XFile? image = await _picker.pickImage(source: imageSource, imageQuality: 40);
    final File file = File(image!.path);
    List<String> response = await addProfileImage(file);
    if (response.isNotEmpty) {
      setState(() => profile.profileImages = response);
    }
    print('*******************************************************');
    /*print('here1');
    print(imageTemp.absolute);
    print(imageTemp.lengthSync() / (1024 * 1024));
    print(imageTemp.toString());
    print(imageTemp.runtimeType);
    print(response);
    img.Image? newImage = img.decodeJpg(imageTemp.readAsBytesSync());
    img.Image thumbnail = img.copyResize(newImage!, width: 120);
    await imageTemp.writeAsBytes(img.encodeJpg(thumbnail));*//*
    //String response = await addProfileImage2(imageTemp);*/
  }

  Widget addPhotoButton(Profile profile) {
    return Container(
      height: 40,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Color(0xFF563B73)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 2, 2),
        child: IconButton(
          onPressed: () => showSourceImage(profile),
          icon: Icon(Icons.add_a_photo, size: 20),
        ),
      ),
    );
  }

  void showSourceImage(Profile person) {
    showDialog(
        context: context,
        builder: (ctx) => (person.profileImages.length == 20) ? SimpleDialog(
          backgroundColor: color5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          title: const Text('You reach maximum capacity of profile image'),
          children: <Widget>[

            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        )
            : SimpleDialog(
              backgroundColor: color5,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              title: const Text('Upload image From'),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () async {
                    uploadImageFunction(ImageSource.gallery, person);
                    Navigator.pop(context);
                  },
                  child: const Text('1_ Gallery'),
                ),
                SimpleDialogOption(
                  onPressed: () async {
                    uploadImageFunction(ImageSource.camera, person);
                    Navigator.pop(context);
                  },
                  child: const Text('2_ Camera'),
                ),
              ],
            ));
  }

  void verifyDialog(BuildContext context) {
    showDialog(
        context: context,
        useSafeArea: false,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: color5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            title: const Text('Verifying'),
            content: const Text(
                'Please check your mailBox or spamBox for verify email.'),
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
  }
}

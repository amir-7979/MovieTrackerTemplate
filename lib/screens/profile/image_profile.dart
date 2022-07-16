import 'package:flutter/material.dart';
import '../../models/profile_model.dart';
import '../../utilities/cache_image.dart';
import '../../utilities/consts.dart';
import '../../utilities/http_helper.dart';

class ImageProfile extends StatefulWidget {
  Profile profile;
  BuildContext context;
  Function function;

  ImageProfile(this.context, this.profile, this.function);

  @override
  State<ImageProfile> createState() => _ImageProfileState();
}

class _ImageProfileState extends State<ImageProfile> {
  int i = 0;
  bool refresh = false;

  Future<void> changeI(Profile profile, bool inc) async {
    setState(() {
      i = (inc ? (i + 1) : (i - 1)) % profile.profileImages.length;
      refresh = true;
    });
    await Future.delayed(Duration(microseconds: 100));
    setState(() => refresh = false);
  }

  Future<void> deletePhoto(Profile profile, int i) async {
    if(profile.profileImages.isEmpty)  return;
    List<String> response = await removeProfileImage(profile.profileImages[i].split('/').last);
    if (response.isNotEmpty)
        profile.profileImages = response;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //count like status watsapp
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: SizedBox(
              width: screenWidth * 3 / 4,
              height: screenWidth * 3 / 4,
              child: FittedBox(
                  fit: BoxFit.fill,
                  child: CacheImage(widget.profile.profileImages.isNotEmpty ? widget.profile.profileImages[i] : widget.profile.defaultProfile))),
        ),
        if(widget.profile.profileImages.isNotEmpty) Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color6,
            ),
            child: IconButton(
              onPressed: () {
                changeI(widget.profile, false);
                setState((){});
              },
              icon: Icon(
                Icons.chevron_left,
                size: 25,
              ),
            ),
          ),
        ),
        if(widget.profile.profileImages.isNotEmpty) Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color6,
            ),
            child: IconButton(
              onPressed: () {
                changeI(widget.profile, true);
                setState((){});

              },
              icon: Icon(
                Icons.chevron_right,
                size: 25,
              ),
            ),
          ),
        ),
        if(widget.profile.profileImages.isNotEmpty) Align(
          alignment: Alignment.bottomRight,
          child: Container(
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: IconButton(
              onPressed: () {
                deletePhoto(widget.profile, i);
                widget.function();
                Navigator.pop(context);

              },
              icon: Icon(
                Icons.delete,
                size: 25,
              ),
            ),
          ),
        ),

      ],
    );
  }
}

import 'package:app04/screens/staff/credit_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:share_plus/share_plus.dart';
import '../../icons/my_flutter_app_icons.dart';
import '../../models/properties_model.dart';
import '../../utilities/cache_image.dart';
import '../../utilities/consts.dart';
import '../../utilities/function_helper.dart';
import '../../utilities/http_helper.dart';
import '../info/part.dart';
import 'character_credit_widget.dart';

class StaffInfoScreen extends StatefulWidget {
  static const routeName = '/staff-info-screen';
  final Map<String, String?>? args;

  const StaffInfoScreen({Key? key, this.args}) : super(key: key);

  @override
  State<StaffInfoScreen> createState() => StaffInfoScreenState();
}

class StaffInfoScreenState extends State<StaffInfoScreen> {
  ScrollController _scrollViewController = ScrollController();
  bool _showAppbar = false;
  bool isScrollingDown = false;
  bool _isStaff = true;

  @override
  void initState() {
    _isStaff = widget.args!['type'] == 'true';
    _scrollViewController.addListener(() {
      if (_showAppbar && _scrollViewController.offset >= screenWidth) {
        setState(() => _showAppbar = false);
      } else if (!_showAppbar && _scrollViewController.offset <= screenWidth) {
        setState(() => _showAppbar = true);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollViewController.removeListener(() {});
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color4,
      extendBodyBehindAppBar: true,
      appBar: ScrollAppBar(
        elevation: 0,
        backgroundColor: color4,
        toolbarHeight: 40,
        controller: _scrollViewController,
        title: const Text("Staff info"),
      ),
      body: Snap(
        controller: _scrollViewController.appBar,
        child: SafeArea(
          child: RefreshIndicator(
            color: Colors.red,
            onRefresh: () async {
              await getSerialInfo(widget.args!['id']!);
              setState(() {});
            },
            child: FutureBuilder(
                future: _isStaff
                    ? getStaffInfo(widget.args!['id']!)
                    : getCharacterInfo(widget.args!['id']!),
                //todo simple way
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                      child: SizedBox(
                          width: screenWidth,
                          height: screenWidth,
                          child: FittedBox(
                              child: CacheImage(widget.args!['url'] ?? ''),
                              fit: BoxFit.fill)),
                    );
                  } else {
                    return _isStaff
                        ? StaffInfoWidget(snapshot.data)
                        : CharacterInfoWidget(snapshot.data);
                  }
                }),
          ),
        ),
      ),
    );
  }

  Widget StaffInfoWidget(Staff staff) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenWidth,
                    height: screenWidth,
                    child: InkWell(
                      onDoubleTap: () async {
                        UserStaffStats userStats = staff.userStaffStats!;
                        setState(() => staff.userStaffStats =
                            likeStaff(staff.userStaffStats!));

                        int res = await likeOrDislike('like_staff', staff.sId!,
                            (staff.userStaffStats!.likeStaff!) ? false : true);
                        if (res != 200) {
                          setState(() {
                            staff.userStaffStats = userStats;
                          });
                        }
                      },
                      child: FittedBox(
                        child: CacheImage(staff.imageData != null
                            ? staff.imageData!.url ?? ''
                            : ''),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                  ),
                ],
              ),
              Positioned(
                bottom: -0.1,
                child: Container(
                  decoration: BoxDecoration(
                    color: color1,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              splashRadius: 0.1,
                              onPressed: () async {
                                UserStaffStats userStats =
                                    staff.userStaffStats!;
                                setState(() => staff.userStaffStats =
                                    likeStaff(staff.userStaffStats!));

                                int res = await likeOrDislike(
                                    'like_staff',
                                    staff.sId!,
                                    (staff.userStaffStats!.likeStaff!)
                                        ? false
                                        : true);
                                if (res != 200) {
                                  setState(() {
                                    staff.userStaffStats = userStats;
                                  });
                                }
                              },
                              icon: Icon(
                                MyFlutterApp.thumbs_up,
                                color:
                                    (staff.userStaffStats!.likeStaff ?? false)
                                        ? Colors.green
                                        : Colors.grey,
                              )),
                          Text(
                              '${staff.userStaffStats!.likeStaffCount}  -  ${staff.userStaffStats!.dislikeStaffCount}'),
                          IconButton(
                              splashRadius: 0.1,
                              onPressed: () async {
                                UserStaffStats userStats =
                                    staff.userStaffStats!;
                                setState(() => staff.userStaffStats =
                                    disLikeStaff(staff.userStaffStats!));
                                int res = await likeOrDislike(
                                    'dislike_staff',
                                    staff.sId!,
                                    (staff.userStaffStats!.dislikeStaff!)
                                        ? false
                                        : true);
                                if (res != 200) {
                                  setState(() {
                                    staff.userStaffStats = userStats;
                                  });
                                }
                              },
                              icon: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                                child: Icon(
                                  MyFlutterApp.thumbs_down,
                                  color: (staff.userStaffStats!.dislikeStaff ??
                                          false)
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              )),
                        ],
                      ),
                      IconButton(
                        splashRadius: 0.1,
                        onPressed: () => Share.share(staff.imageData!.url ?? '',
                            subject: staff.name),
                        icon: const Icon(
                          Icons.share_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Part('Name', staff.name),
          if (staff.name?.toLowerCase() != staff.rawName?.toLowerCase())
            Part('RawName', staff.rawName),
          if (staff.gender != '') Part('Gender', staff.gender),
          if (staff.country != '') Part('Country', staff.country),
          if (staff.birthday != '') Part('Birthday', staff.birthday),
          if (staff.deathday != '') Part('Deathday', staff.deathday),
          if (staff.about != '') Part('About', staff.about),
          SizedBox(height: 20),
          const Text(
            'PLOT',
            style: TextStyle(color: Colors.red, fontSize: 20.0),
          ),
          if (_isStaff)
            for (var i in staff.credits!) StaffCreditWidget(i)
        ],
      ),
    );
  }

  Widget CharacterInfoWidget(Character character) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenWidth,
                    height: screenWidth,
                    child: InkWell(
                      onDoubleTap: () async {
                        CharacterStats userStats = character.characterStats!;
                        setState(() => character.characterStats =
                            likeCharacter(character.characterStats!));

                        int res = await likeOrDislike('like_character', character.sId!,
                            (character.characterStats!.likeCharacter!) ? false : true);
                        if (res != 200) {
                          setState(() {
                            character.characterStats = userStats;
                          });
                        }
                      },
                      child: FittedBox(
                        child: CacheImage(character.imageData != null
                            ? character.imageData!.url ?? ''
                            : ''),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                  ),
                ],
              ),
              Positioned(
                bottom: -0.1,
                child: Container(
                  decoration: BoxDecoration(
                    color: color1,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              splashRadius: 0.1,
                              onPressed: () async {
                                CharacterStats userStats =
                                    character.characterStats!;
                                setState(() => character.characterStats =
                                    likeCharacter(character.characterStats!));

                                int res = await likeOrDislike(
                                    'like_character',
                                    character.sId!,
                                    (character.characterStats!.likeCharacter!)
                                        ? false
                                        : true);
                                if (res != 200) {
                                  setState(() {
                                    character.characterStats = userStats;
                                  });
                                }
                              },
                              icon: Icon(
                                MyFlutterApp.thumbs_up,
                                color:
                                    (character.characterStats!.likeCharacter!)
                                        ? Colors.green
                                        : Colors.grey,
                              )),
                          Text(
                              '${character.characterStats!.likeCharacterCount}  -  ${character.characterStats!.dislikeCharacterCount}'),
                          IconButton(
                              splashRadius: 0.1,
                              onPressed: () async {
                                CharacterStats userStats =
                                    character.characterStats!;
                                setState(() => character.characterStats = disLikeCharacter(character.characterStats!));
                                int res = await likeOrDislike(
                                    'dislike_character',
                                    character.sId!,
                                    (character.characterStats!.dislikeCharacter!)
                                        ? false
                                        : true);
                                if (res != 200) {
                                  setState(() {
                                    character.characterStats = userStats;
                                  });
                                }
                              },
                              icon: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                                child: Icon(
                                  MyFlutterApp.thumbs_down,
                                  color: (character.characterStats!.dislikeCharacter!)
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              )),
                        ],
                      ),
                      IconButton(
                        splashRadius: 0.1,
                        onPressed: () => Share.share(character.imageData!.url ?? '',
                            subject: character.name),
                        icon: const Icon(
                          Icons.share_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Part('Name', character.name),
          if (character.name?.toLowerCase() != character.rawName?.toLowerCase())
            Part('RawName', character.rawName),
          if (character.gender != null) Part('Gender', character.gender),
          if (character.about != null) Part('About', character.about),
          SizedBox(height: 20),
          const Text(
            'PLOT',
            style: TextStyle(color: Colors.red, fontSize: 20.0),
          ),
          for (var i in character.credits!) CharacterCreditWidget(i)
        ],
      ),
    );
  }

  Widget part2(String key, String? value) {
    return (value == null || value == '')
        ? SizedBox(height: 1)
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                child: Row(
                  children: [
                    Text(
                      '$key : ',
                      style: const TextStyle(color: Colors.red, fontSize: 17),
                    ),
                    const SizedBox(width: 1),
                    Expanded(
                        child: Text(
                      value,
                      maxLines: 4,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.start,
                    )),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          );
  }
}

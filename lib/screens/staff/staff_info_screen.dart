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
import '../helper_widgets/trailer_part_widget.dart';
import '../info/part.dart';

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

  @override
  void initState() {
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
                future: getStaffInfo(widget.args!['id']!),
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
                    return StaffInfoWidget(snapshot.data);
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
                        setState(() {
                          like(
                              staff.userStats!.likeMovie,
                              staff.userStats!.dislikeMovie,
                              staff.likesCount!,
                              staff.dislikesCount!);
                        });
                        int res = await likeOrDislike('like_staff', staff.sId!,
                            (staff.userStats!.likeMovie ?? false) ? false : true);
                        if (res == 200) {
                          setState(() {});
                        }
                      },
                      child: FittedBox(
                        child: CacheImage(staff.imageData != null ? staff.imageData!.url ?? '' : ''),
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
                                setState(() {
                                  like(
                                      staff.userStats!.likeMovie,
                                      staff.userStats!.dislikeMovie,
                                      staff.likesCount!,
                                      staff.userStats!.dislikeMovieCount!);
                                });
                                int res = await likeOrDislike(
                                    'like_staff',
                                    staff.sId!,
                                    (staff.userStats!.likeMovie!) ? false : true);
                                if (res == 200) {
                                  setState(() {});
                                }
                              },
                              icon: Icon(
                                MyFlutterApp.thumbs_up,
                                color: (staff.userStats!.likeMovie ?? false)
                                    ? Colors.green
                                    : Colors.grey,
                              )),
                          Text(
                              '${staff.likesCount.toString()}  -  ${staff.dislikesCount.toString()}'),
                          IconButton(
                              splashRadius: 0.1,
                              onPressed: () async {
                                setState(() {
                                  like(
                                    staff.userStats!.dislikeMovie,
                                    staff.userStats!.likeMovie,
                                    staff.userStats!.dislikeMovieCount!,
                                    staff.userStats!.likeMovieCount!,
                                  );
                                });
                                int res = await likeOrDislike(
                                    'dislike_staff',
                                    staff.sId!,
                                    (staff.userStats!.dislikeMovie!)
                                        ? false
                                        : true);
                                if (res == 200) {
                                  setState(() {});
                                }
                              },
                              icon: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                                child: Icon(
                                  MyFlutterApp.thumbs_down,
                                  color: (staff.userStats!.dislikeMovie ?? false)
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
          if(staff.name?.toLowerCase() != staff.rawName?.toLowerCase()) Part('RawName', staff.rawName),
          Part('Gender', staff.gender),
          Part('Country', staff.country),
          Part('Birthday', staff.birthday),
          Part('Deathday', staff.deathday),
          Part('About', staff.about),
          SizedBox(height: 20),
          const Text(
            'PLOT',
            style: TextStyle(color: Colors.red, fontSize: 20.0),
          ),
          for(var i in staff.credits!)
            CreditWidget(i)

        ],
      ),
    );
  }

  Widget part2(String key, String? value){
    return (value == null || value == '') ? SizedBox(height: 1) : Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
          child: Row(
            children: [
              Text('$key : ', style: const TextStyle(color: Colors.red, fontSize: 17),),
              const SizedBox(width: 1),
              Expanded(
                child:  Text(value, maxLines: 4,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.start,)
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    )  ;
  }
}

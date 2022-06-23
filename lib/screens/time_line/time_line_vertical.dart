import 'dart:async';
import 'package:app04/screens/helper_widgets/vertical_shimmer.dart';
import 'package:flutter/material.dart';
import '../../models/low_data_item.dart';
import '../../utilities/consts.dart';
import '../../utilities/http_helper.dart';
import '../helper_widgets/scroll_list_widget.dart';

class VerticalTimeLine extends StatefulWidget {
  const VerticalTimeLine({Key? key}) : super(key: key);
  static const routeName = '/vertical_time_line';

  @override
  State<VerticalTimeLine> createState() => _VerticalTimeLineState();
}

class _VerticalTimeLineState extends State<VerticalTimeLine> {
  List<String> days = const [
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday'
  ];
  int i = DateTime.now().weekday;
  bool refresh = false;
  Future<void> change(int j) async {
    setState(() => refresh = true);
    await Future.delayed(Duration(milliseconds: 50));

    setState(() {
      refresh = false;
      i = (i + j) % 7;
    });
  }

  Future<List<LowDataItem>?> getMoreItem(int page) => getSecondPartItems(i, page);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: color4,
        appBar: AppBar(title:  Text(days[i]), actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
            child: ElevatedButton(onPressed: () => change(-1), child: Text('prev')),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 8, 25, 8),
            child: ElevatedButton(onPressed: ()=> change(1), child: Text('next')),
          )
        ]),
        body: Column(
          children: [
            Expanded(child: refresh ? listShimmer() : ScrollListWidget(getMoreItem)),
          ],
        ),
      ),
    );
  }

  Widget listShimmer(){
    return ListView(
      padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
      children: [
        VerticalShimmer(), VerticalShimmer(), VerticalShimmer(), VerticalShimmer(), VerticalShimmer(), VerticalShimmer(), VerticalShimmer(),
        VerticalShimmer(), VerticalShimmer(), VerticalShimmer(), VerticalShimmer(), VerticalShimmer(), VerticalShimmer(), VerticalShimmer(),

      ],
    );
  }

}

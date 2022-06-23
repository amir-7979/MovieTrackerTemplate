import 'package:app04/utilities/http_helper.dart';
import 'package:flutter/material.dart';
import '../../utilities/consts.dart';
import '../helper_widgets/horizontal_shimmer.dart';
import '../helper_widgets/show-part-widget.dart';
import '../more/more_screen.dart';
import '../time_line/time_line_vertical.dart';

class TimeLinePartWidget extends StatefulWidget {
  @override
  _TimeLinePartWidgetState createState() => _TimeLinePartWidgetState();
}

class _TimeLinePartWidgetState extends State<TimeLinePartWidget> {
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


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('TimeLine', style: Theme.of(context).textTheme.headline2),

            IconButton(icon: const Icon(Icons.grid_view, size: 20, color: yellow1), onPressed: () =>
                Navigator.of(context)
                    .pushNamed(VerticalTimeLine.routeName)),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        SizedBox(
          height: 220,
          child: FutureBuilder(
              future: getSecondPartItems(i, 1),
              builder: (context, AsyncSnapshot snapshot) => (snapshot.hasData) ? showPartWidget(snapshot.data) : HorizontalShimmerListWidget()),
        ),
      ],
    );
  }
}

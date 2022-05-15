import 'package:app04/utilities/http_helper.dart';
import 'package:flutter/material.dart';
import '../helper_widgets/show-part-widget.dart';

class SecondPartWidget extends StatefulWidget {
  @override
  _SecondPartWidgetState createState() => _SecondPartWidgetState();
}

class _SecondPartWidgetState extends State<SecondPartWidget> {
  List<String> days = const [
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday'
  ];
  int i = 0;

  void change(int j) => setState(() => i = (i + j) % 7);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: Text(
                "TimeLine",
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
            ),
            Row(children: [
              IconButton(
                  onPressed: () => change(-1),
                  icon: const Icon(Icons.arrow_left)),
              Text(
                days[i],
                style: const TextStyle(color: Colors.white, fontSize: 19),
              ),
              IconButton(
                  onPressed: () {
                    change(1);
                  },
                  icon: const Icon(Icons.arrow_right)),
            ]),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        SizedBox(
          height: 220,
          child: FutureBuilder(
              future: getSecondPartItems(i),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return showPartWidget(snapshot.data);
                } else {
                  return Container(height: 1);
                }
              }),
        ),
      ],
    );
  }
}

import 'package:app04/models/low_data_item.dart';
import 'package:app04/screens/helper_widgets/horizontal_item_widget.dart';
import 'package:app04/screens/helper_widgets/title_button_widget.dart';
import 'package:app04/utilities/http_helper.dart';
import 'package:flutter/material.dart';
import '../more/more_screen.dart';

class TopsByLikeWidget extends StatefulWidget {
  const TopsByLikeWidget({Key? key}) : super(key: key);

  @override
  _TopsByLikeWidgetState createState() => _TopsByLikeWidgetState();
}

class _TopsByLikeWidgetState extends State<TopsByLikeWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleButtonWidget("TopsByLike", () =>
            Navigator.of(context).pushNamed(
                MoreScreen.routeName, arguments: "topsByLikes"), Theme.of(context).accentColor),
        SizedBox(
          height: 250,
          child: FutureBuilder(
              future: getTopsByLikes(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return topsByLike(snapshot.data);
                }
                return const SizedBox(
                  height: 1,
                );
              }),
        ),
      ],
    );
  }

  Widget topsByLike(List<LowDataItem> items) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: ListView.builder(
          itemCount: items.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return HorizontalItemWidget(items[index]);
          }
      ),
    );
  }
}
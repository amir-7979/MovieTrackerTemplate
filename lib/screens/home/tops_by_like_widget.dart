import 'package:app04/models/low_data_item.dart';
import 'package:app04/screens/helper_widgets/horizontal_item_widget.dart';
import 'package:app04/screens/helper_widgets/title_button_widget.dart';
import 'package:app04/utilities/http_helper.dart';
import 'package:flutter/material.dart';
import '../../utilities/consts.dart';
import '../helper_widgets/horizontal_shimmer.dart';
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('TopsByLike'),
            IconButton(icon: const Icon(Icons.grid_view, size: 20, color: yellow1), onPressed: () =>
                Navigator.of(context)
                    .pushNamed(MoreScreen.routeName, arguments: "topsByLikes"),),
          ],),

        SizedBox(
          height: 250,
          child: FutureBuilder(
              future: getTopsByLikes(),
              builder: (context, AsyncSnapshot snapshot) => (snapshot.hasData) ? topsByLike(snapshot.data) : HorizontalShimmerListWidget()),
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
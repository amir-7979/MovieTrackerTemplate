import 'package:app04/models/low_data_item.dart';
import 'package:app04/screens/helper_widgets/horizontal_item_widget.dart';
import 'package:app04/screens/helper_widgets/title_button_widget.dart';
import 'package:app04/utilities/http_helper.dart';
import 'package:flutter/material.dart';
import '../../utilities/consts.dart';
import '../helper_widgets/horizontal_shimmer.dart';
import '../more/more_screen.dart';

class SortedMoviesWidget extends StatefulWidget {
  const SortedMoviesWidget({Key? key}) : super(key: key);

  @override
  _SortedMoviesWidgetState createState() => _SortedMoviesWidgetState();
}

class _SortedMoviesWidgetState extends State<SortedMoviesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('SortedMovies', style: Theme.of(context).textTheme.headline2),
            IconButton(
              icon: const Icon(Icons.grid_view, size: 20, color: yellow1),
              onPressed: () => Navigator.of(context)
                  .pushNamed(MoreScreen.routeName, arguments: "sortedMovies"),
            ),
          ],
        ),
        SizedBox(
          height: 250,
          child: FutureBuilder(
              future: getSortedMovies(),
              builder: (context, AsyncSnapshot snapshot) => (snapshot.hasData)
                  ? topsByLike(snapshot.data)
                  : HorizontalShimmerListWidget()),
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
          }),
    );
  }
}

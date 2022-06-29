import 'package:app04/utilities/http_helper.dart';
import 'package:flutter/material.dart';
import '../../models/trailer_model.dart';
import '../../utilities/consts.dart';
import '../helper_widgets/horizontal_shimmer.dart';
import '../helper_widgets/trailer_item_widget.dart';
import '../more/more_screen.dart';

class TrailerPart extends StatefulWidget {
  const TrailerPart({Key? key}) : super(key: key);

  @override
  _TrailerPartState createState() => _TrailerPartState();
}

class _TrailerPartState extends State<TrailerPart> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Trailers', style: Theme.of(context).textTheme.headline2),
            IconButton(icon: const Icon(Icons.grid_view, size: 20, color: yellow1), onPressed: () =>
              Navigator.of(context)
                  .pushNamed(MoreScreen.routeName, arguments: {'argName': "trailers", 'function': getMoreMovie}),),
        ],),
        SizedBox(
          height: 220,
          child: FutureBuilder(
              future: getTrailerPartItems(),
              builder: (context, AsyncSnapshot snapshot) => (snapshot.hasData) ? trailerList(snapshot.data) : HorizontalShimmerListWidget()
              ),
        ),
      ],
    );
  }

  Widget trailerList(List<TrailerModel> list) {
    return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return ShortTrailerItemWidget(list[index]);
          }
    );
  }
}

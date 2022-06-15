import 'package:app04/screens/helper_widgets/title_button_widget.dart';
import 'package:app04/utilities/http_helper.dart';
import 'package:flutter/material.dart';
import '../../models/trailer_model.dart';
import '../../utilities/consts.dart';
import '../helper_widgets/horizontal_shimmer.dart';
import '../helper_widgets/trailer_item_widget.dart';
import '../more/more_screen.dart';

class ThirdPartWidget extends StatefulWidget {
  const ThirdPartWidget({Key? key}) : super(key: key);

  @override
  _ThirdPartWidgetState createState() => _ThirdPartWidgetState();
}

class _ThirdPartWidgetState extends State<ThirdPartWidget> {

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
                  .pushNamed(MoreScreen.routeName, arguments: "trailers"),),
        ],),
        SizedBox(
          height: 200,
          child: FutureBuilder(
              future: getThirdPartItems(),
              builder: (context, AsyncSnapshot snapshot) => (snapshot.hasData) ? trailerList(snapshot.data) : HorizontalShimmerListWidget()
              ),
        ),
        Container(height: 10),
      ],
    );
  }

  @override
  Widget trailerList(List<TrailerModel> list) {
    return (list.isEmpty) ? Container(width: 1) :
    ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return ShortTrailerItemWidget(list[index].rawTitle!, list[index].type!, list[index].rating, (list[index].posters != null ? list[index].posters![0].url : null),
              (list[index].trailers != null ? list[index].trailers![0].url : null));
        }
    );
  }
}

import 'package:app04/screens/helper_widgets/horizontal_shimmer.dart';
import 'package:app04/utilities/http_helper.dart';
import 'package:app04/screens/helper_widgets/show-part-widget.dart';
import 'package:flutter/material.dart';
import '../../models/multiple_model.dart';
import '../../utilities/consts.dart';
import '../more/more_screen.dart';

class FirstPartWidget extends StatelessWidget {
  const FirstPartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getFirstPartItems(),
        builder: (context, AsyncSnapshot snapshot) => (snapshot.hasData) ? multipleParts(context, snapshot.data) :  multipleHorizontalShimmerWidget());
  }


  Widget multipleParts(BuildContext context, Multiple multiple) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('News'),
              IconButton(icon: const Icon(Icons.grid_view, size: 20, color: yellow1), onPressed: () =>
                  Navigator.of(context)
                      .pushNamed(MoreScreen.routeName, arguments: "news"),),
            ],
          ),
          showPartWidget(multiple.news),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Updates'),
              IconButton(icon: const Icon(Icons.grid_view, size: 20, color: yellow1), onPressed: () =>
                  Navigator.of(context)
                      .pushNamed(MoreScreen.routeName, arguments: "updates"),),
            ],
          ),
          showPartWidget(multiple.update),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('In Theater'),
              IconButton(icon: const Icon(Icons.grid_view, size: 20, color: yellow1), onPressed: () =>
                  Navigator.of(context)
                      .pushNamed(MoreScreen.routeName, arguments: "updates"),),
            ],
          ),
          showPartWidget(multiple.inTheaters),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('ComingSoon'),
              IconButton(icon: const Icon(Icons.grid_view, size: 20, color: yellow1), onPressed: () =>
                  Navigator.of(context)
                      .pushNamed(MoreScreen.routeName, arguments: "updates"),),
            ],
          ),
          showPartWidget(multiple.comingSoon),
        ],
      ),
    );
  }

  Widget multipleHorizontalShimmerWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('News'),
              IconButton(icon: const Icon(Icons.grid_view, size: 20, color: yellow1), onPressed: (){}),
            ],
          ),
          HorizontalShimmerListWidget(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Updates'),
              IconButton(icon: const Icon(Icons.grid_view, size: 20, color: yellow1), onPressed: () {}),
            ],
          ),
          HorizontalShimmerListWidget(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('In Theater'),
              IconButton(icon: const Icon(Icons.grid_view, size: 20, color: yellow1), onPressed: () {}),
            ],
          ),
          HorizontalShimmerListWidget(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('ComingSoon'),
              IconButton(icon: const Icon(Icons.grid_view, size: 20, color: yellow1), onPressed: (){})
            ],
          ),
          HorizontalShimmerListWidget(),
        ],
      ),
    );
  }
}

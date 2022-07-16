import 'package:app04/screens/helper_widgets/horizontal_shimmer.dart';
import 'package:app04/utilities/http_helper.dart';
import 'package:flutter/material.dart';
import '../../models/multiple_model.dart';
import '../helper_widgets/horizontal_part.dart';

class MultiplePartWidget extends StatelessWidget {
  const MultiplePartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: getMultiplePartItems(),
        builder: (context, AsyncSnapshot snapshot) => (snapshot.hasData) ? multipleParts(context, snapshot.data) :  multipleHorizontalShimmerWidget(context));


  Widget multipleParts(BuildContext context, Multiple multiple) {
    return Column(
        children: [
          HorizontalPart('News', 'news', multiple.news, getMoreMovie),
          HorizontalPart('Updates', 'updates', multiple.update, getMoreMovie),
          HorizontalPart('In Theater', 'inTheaters', multiple.inTheaters, getMoreSortedMovie),
          HorizontalPart('ComingSoon', 'comingSoon', multiple.comingSoon, getMoreSortedMovie),
        ],
      );
  }

  Widget multipleHorizontalShimmerWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
      child: Column(
        children: [
          HorizontalShimmerListWidget(context: context, name: 'News'),
          HorizontalShimmerListWidget(context: context, name: 'Updates'),
          HorizontalShimmerListWidget(context: context, name: 'In Theater'),
          HorizontalShimmerListWidget(context: context, name: 'ComingSoon'),
        ],
      ),
    );
  }
}

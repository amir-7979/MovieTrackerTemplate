import 'package:app04/screens/helper_widgets/shimmer_custom_widget.dart';
import 'package:flutter/material.dart';
import '../../utilities/consts.dart';

class HorizontalShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: const CustomWidget.rectangular(
                  height: itemHeight, width: itemWidth)),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: const CustomWidget.rectangular(
                  height: 14, width: itemWidth * 2 / 3),
            ),
          ),
        ],
      ),
    );
  }

}
Widget HorizontalShimmerListWidget({BuildContext? context, String? name}) {
  return  Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if(name != null)Text(name, style: Theme.of(context!).textTheme.headline2),
      if(name != null)const SizedBox(height: 10),
      SizedBox(
        height: 220,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            HorizontalShimmer(),
            HorizontalShimmer(),
            HorizontalShimmer(),
            HorizontalShimmer(),
            HorizontalShimmer(),
            HorizontalShimmer(),
          ],
        ),
      ),
    ],
  );
}



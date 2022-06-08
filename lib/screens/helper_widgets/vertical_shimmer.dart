import 'package:app04/screens/helper_widgets/shimmer_custom_widget.dart';
import 'package:flutter/material.dart';
import '../../utilities/consts.dart';

class VerticalShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: const CustomWidget.rectangular(
                height: 140, width: 100)),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: const CustomWidget.rectangular(
                    height: 14, width: 100),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: const CustomWidget.rectangular(
                    height: 14, width: 50),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
Widget verticalShimmerListWidget() {
  return  SizedBox(
    height: 220,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        VerticalShimmer(),
        VerticalShimmer(),
        VerticalShimmer(),
      ],
    ),
  );
}



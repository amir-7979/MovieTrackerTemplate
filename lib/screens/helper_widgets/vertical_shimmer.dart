import 'package:app04/screens/helper_widgets/shimmer_custom_widget.dart';
import 'package:flutter/material.dart';

class VerticalShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: const CustomWidget.rectangular(
                  height: 140, width: 100)),

          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: const CustomWidget.rectangular(
                      height: 14, width: 100),
                ),
                const SizedBox(height: 28),

                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: const CustomWidget.rectangular(
                      height: 12, width: 60),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: const CustomWidget.rectangular(
                      height: 12, width: 60),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: const CustomWidget.rectangular(
                      height: 12, width: 60),
                ),
              ],
            ),
          ),
        ],
      ),
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



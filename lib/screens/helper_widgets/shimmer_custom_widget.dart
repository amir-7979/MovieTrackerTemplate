import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomWidget extends StatelessWidget {

  final double width;
  final double height;
  final ShapeBorder shapeBorder;

   const CustomWidget.rectangular({Key? key,
    required this.width,
    required this.height
  }): shapeBorder = const RoundedRectangleBorder(), super(key: key);

   const CustomWidget.circular({Key? key,
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder()
  }) : super(key: key);

  @override
  Widget build(BuildContext context)  => Shimmer.fromColors(
    baseColor: const Color(0xff4b4b4b),
    highlightColor: const Color(0xff757575),
    child: Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: const Color(0xff646464),
        shape: shapeBorder,
      ),
    ),
  );
}
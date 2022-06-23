import 'package:app04/utilities/http_helper.dart';
import 'package:flutter/material.dart';
import '../helper_widgets/horizontal_part.dart';
import '../helper_widgets/horizontal_shimmer.dart';

class SortedMovie extends StatelessWidget {
  String type;

  SortedMovie(this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMoreSortedMovie(type, 1),
        builder: (context, AsyncSnapshot snapshot) =>
        (snapshot.hasData)
            ? HorizontalPart(
            '${type[0].toUpperCase()}${type.substring(1).toLowerCase()}', type, snapshot.data, getMoreSortedMovie)
            : HorizontalShimmerListWidget(context: context, name: type));
  }
}
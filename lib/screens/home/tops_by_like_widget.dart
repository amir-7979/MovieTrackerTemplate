import 'package:app04/utilities/http_helper.dart';
import 'package:flutter/material.dart';
import '../helper_widgets/horizontal_part.dart';
import '../helper_widgets/horizontal_shimmer.dart';

class ThirdPartWidget extends StatefulWidget {
  const ThirdPartWidget({Key? key}) : super(key: key);

  @override
  _ThirdPartWidgetState createState() => _ThirdPartWidgetState();
}

class _ThirdPartWidgetState extends State<ThirdPartWidget> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMoreMovie('topsByLikes', 1),
        builder: (context, AsyncSnapshot snapshot) => (snapshot.hasData) ? HorizontalPart('TopsByLike', 'topsByLikes', snapshot.data, getMoreMovie) : HorizontalShimmerListWidget(context: context, name: 'topsByLikes'));

  }
}
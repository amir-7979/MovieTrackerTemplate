import 'package:app04/models/low_data_item.dart';
import 'package:flutter/material.dart';
import '../../utilities/consts.dart';
import '../helper_widgets/scroll_list_widget.dart';

class MoreScreen extends StatelessWidget {
  static const routeName = '/screens.more-screen';
  late Map<String, dynamic>? _map;

  Future<List<LowDataItem>?> getMoreItem(int page) {
    return _map!['function'](_map!['argName'], page);
  }

  @override
  Widget build(BuildContext context) {
    _map = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return SafeArea(
      child: Scaffold(
        backgroundColor: color4,
        appBar: AppBar(title:  Text(_map!['argName'])),
        body: ScrollListWidget(getMoreItem),
      ),
    );
  }

}

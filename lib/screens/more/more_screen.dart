import 'package:app04/models/low_data_item.dart';
import 'package:flutter/material.dart';
import '../../utilities/consts.dart';
import '../../utilities/http_helper.dart';
import '../helper_widgets/scroll_list_widget.dart';

class MoreScreen extends StatelessWidget {
  static const routeName = '/screens.more-screen';
  late String? _type;

  Future<List<LowDataItem>?> getMoreItem(int page) {
    return getMoreMovie(_type!, page);
  }

  @override
  Widget build(BuildContext context) {
    _type = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: color4,
      appBar: AppBar(title: const Text("MoreItem")),
      body: ScrollListWidget(getMoreItem),
    );
  }

}

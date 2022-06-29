import 'package:flutter/material.dart';

import '../../models/low_data_item.dart';
import '../../utilities/consts.dart';
import '../../utilities/http_helper.dart';
import '../helper_widgets/scroll_list_widget.dart';

class BookMarkScreen extends StatelessWidget {
  const BookMarkScreen({Key? key}) : super(key: key);
  Future<List<LowDataItem>?> savedMovies(int page) {
    return userStatsList('save', page);
  }
  @override
  Widget build(BuildContext context) {

    return  SafeArea(
      child: Scaffold(
          backgroundColor: color4,
          appBar: AppBar(title: Text('Saved'),),
          body: ScrollListWidget(savedMovies)),
    );
  }
}

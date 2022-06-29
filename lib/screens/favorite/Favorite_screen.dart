import 'package:flutter/material.dart';
import '../../models/low_data_item.dart';
import '../../utilities/consts.dart';
import '../../utilities/http_helper.dart';
import '../helper_widgets/scroll_list_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  Future<List<LowDataItem>?> likedMovies(int page) {
    return userStatsList('like_movie', page);
  }
  @override
  Widget build(BuildContext context) {

    return  SafeArea(
      child: Scaffold(
          backgroundColor: color4,
          appBar: AppBar(title: Text('Favorites')),
          body: ScrollListWidget(likedMovies)),
    );
  }
}
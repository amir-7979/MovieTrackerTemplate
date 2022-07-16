import 'package:app04/models/movie_info_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'download_button_widget.dart';

Widget DownloadMovieSection(BuildContext context, Dio dio, MovieInfoModel movieInfoModel) {

  return Padding(
    padding: const EdgeInsets.fromLTRB(9, 10, 9, 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var item in movieInfoModel.qualities!)
          if (item.links!.isNotEmpty)
            downloadButtonWidget(context, movieInfoModel.title!, item.links![0].info, movieInfoModel.posters![0].url ,item.links![0].link, (){})
      ],
    ),
  );
}

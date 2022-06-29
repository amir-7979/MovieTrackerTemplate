import 'dart:io';

import 'package:app04/utilities/consts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'download_button_widget.dart';

Widget DownloadMovieSection(BuildContext context, Dio dio, String name,
    String info, String imageUrl, List<dynamic> link) {
  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

  Future download(Dio dio, String url, String savePath) async {
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }

  Future<void> download2(String url, String name) async {
    String fullPath = dirPath + "/${name}";
    download(dio, url, fullPath);
  }

  return Padding(
    padding: const EdgeInsets.fromLTRB(9, 10, 9, 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var item in link)
          if (item.links!.isNotEmpty)
            downloadButtonWidget(context, name, item.links![0].info, imageUrl,
                item.links![0].link, download2)
      ],
    ),
  );
}

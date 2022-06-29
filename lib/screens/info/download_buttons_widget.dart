import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/properties_model.dart';
import '../../models/serial_info_model.dart';
import '../download/download_screen.dart';
import 'download_button_widget.dart';



class DownloadMovieWidget2 extends StatelessWidget {
  final String? imageUrl;
  final List<Episodes>? ep;

  const DownloadMovieWidget2(this.imageUrl, this.ep);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(9, 10, 9, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /*for (var item in ep!)
            if (item.links!.isNotEmpty)
              downloadButtonWidget(
                  context,
                  'ep ${item.episodeNumber} - ${item.links![0].info}',
                  imageUrl,
                  item.links![0].link,
                      () {})*/
        ],
      ),
    );
  }
}
class DownloadSeasonsSection extends StatefulWidget {
  final SerialInfoModel _serialInfoModel;

  DownloadSeasonsSection(this._serialInfoModel);

  @override
  State<DownloadSeasonsSection> createState() => _DownloadSeasonsSectionState();
}

class _DownloadSeasonsSectionState extends State<DownloadSeasonsSection> {
/*
  Click click = Click();
*/

  Widget seasonQualityButton(int i) {
    List<Seasons> newList = [...widget._serialInfoModel.seasons!];
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var item in widget._serialInfoModel.maps!)
            if (int.parse(item['number']!) == i)
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DownloadScreen(args: {
                          'quality': '${item['quality']}',
                          'data': newList.firstWhere((element) =>
                              (element.seasonNumber ==
                                  int.parse(item['number']!)))
                        }),
                      ),
                    );
                    //print(newList.firstWhere((element) => (element.seasonNumber == int.parse(item['number']!))));
                  },
                  child: Text(
                      'Season ${int.parse(item['number']!)} - ${item['quality']} - ${item['size']}'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(9, 0, 9, 2),
        child: Column(
          children: [
            for (var item in widget._serialInfoModel.seasons!)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          elevation: 15),
                      onPressed: () {
                        setState(() {
/*
                          click.set(item.seasonNumber!);
*/
                        });
                      },
                      child: Text('Season ${item.seasonNumber}')),
                  /*if (click.index == item.seasonNumber && click.situation)
                    seasonQualityButton(item.seasonNumber!),*/
                ],
              ),
          ],
        ));
  }
}


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/properties_model.dart';
import '../../models/serial_info_model.dart';
import '../../utilities/consts.dart';

class DownloadSeasonsSection extends StatefulWidget {
  final SerialInfoModel _serialInfoModel;

  DownloadSeasonsSection(this._serialInfoModel);

  @override
  State<DownloadSeasonsSection> createState() => _DownloadSeasonsSectionState();
}

class _DownloadSeasonsSectionState extends State<DownloadSeasonsSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var item in widget._serialInfoModel.seasons!)
          _buildExpandableSeason(widget._serialInfoModel.maps!, item)
      ],
    );
  }

  Widget _buildExpandableSeason(List<Map<String, String>> maps, season) {
    return ExpansionTile(
      childrenPadding: EdgeInsets.symmetric(horizontal: 8),
      tilePadding: EdgeInsets.zero,
      title: Container(
        height: 35,
        decoration: BoxDecoration(
            color: color5, borderRadius: BorderRadius.circular(10)),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('Season ${season.seasonNumber}'),
            )),
      ),
      children: <Widget>[
        for (var map in maps)
          if (int.parse(map['number']!) == season.seasonNumber)
            _buildExpandableEpisode(maps, season.seasonNumber, map['quality']!,
                map['size']!, season.episodes)
      ],
    );
  }

  Widget _buildExpandableEpisode(List<Map<String, String>> maps,
      int seasonNumber, String quality, String size, List<Episodes> episodes) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.symmetric(horizontal: 8),
      title: Container(
          height: 30,
          decoration: BoxDecoration(
              color: color5, borderRadius: BorderRadius.circular(10)),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: (size.length > 1)
                    ? Text('${quality} -  ${size}')
                    : Text(quality),
              ))),
      children: <Widget>[
        for (int i = 0; i < episodes.length; i += 3)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (i < episodes.length)
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        elevation: 2,
                        textStyle: TextStyle(fontSize: 14),
                      ),
                      onPressed: () {
                        var link = episodes[i].links!.firstWhere(
                            (link) => link.info!.split('-').first == quality);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Download link copied to clipboard"),
                          duration: Duration(seconds: 1),
                        ));
                        Clipboard.setData(ClipboardData(text: link.link));
                      },
                      child: Text(
                        'Episode ${episodes[i].episodeNumber}',
                        style: TextStyle(overflow: TextOverflow.visible),
                        maxLines: 1,
                        softWrap: false,
                      )),
                ),
              if (i + 1 < episodes.length)
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        elevation: 2,
                        textStyle: TextStyle(fontSize: 14),
                      ),
                      onPressed: () {
                        var link = episodes[i + 1].links!.firstWhere(
                            (link) => link.info!.split('-').first == quality);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Download link copied to clipboard"),
                          duration: Duration(seconds: 1),
                        ));
                        Clipboard.setData(ClipboardData(text: link.link));
                      },
                      child: Text(
                        'Episode ${episodes[i + 1].episodeNumber}',
                        style: TextStyle(overflow: TextOverflow.visible),
                        maxLines: 1,
                        softWrap: false,
                      )),
                ),
              if (i + 2 < episodes.length)
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        elevation: 2,
                        textStyle: TextStyle(fontSize: 14),
                      ),
                      onPressed: () {
                        var link = episodes[i + 2].links!.firstWhere(
                            (link) => link.info!.split('-').first == quality);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Download link copied to clipboard"),
                          duration: Duration(seconds: 1),
                        ));
                        Clipboard.setData(ClipboardData(text: link.link));
                      },
                      child: Text(
                        'Episode ${episodes[i + 2].episodeNumber}',
                        style: TextStyle(overflow: TextOverflow.visible),
                        maxLines: 1,
                        softWrap: false,
                      )),
                ),
            ],
          )
      ],
    );
  }
}

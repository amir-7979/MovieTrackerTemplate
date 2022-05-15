import 'package:app04/models/low_data_item.dart';
import 'package:app04/screens/info/info_screen.dart';
import 'package:app04/utilities/consts.dart';
import 'package:flutter/material.dart';
import '../../utilities/cache_image.dart';

class HorizontalItemWidget extends StatelessWidget {
  final LowDataItem _itemModel;

  HorizontalItemWidget(this._itemModel);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfoScreen(args: {'id': _itemModel.id, 'url': _itemModel.posters[0].url, 'type': _itemModel.type}),
          ),
        ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
        child: Column(
          children: [
            Stack(children: [
              SizedBox(
                width: itemWidth,
                height: itemHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),

                  child: FittedBox(
                    child: CacheImage((_itemModel.posters.isNotEmpty) ? _itemModel.posters[0].url : ''),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                width: itemWidth,
                height: itemHeight,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 30,
                    height: 30,
                    child: Center(child: Text(_itemModel.rating.imdb.toString())),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,

                    ),
                  ),
                ),
              )
            ]),
            Container(height: 4),
            SizedBox(
              width: itemWidth,
              child: Text(
                _itemModel.title,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

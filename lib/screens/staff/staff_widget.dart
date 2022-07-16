import 'package:app04/screens/staff/staff_info_screen.dart';
import 'package:flutter/material.dart';
import '../../utilities/cache_image.dart';
import '../../utilities/consts.dart';

class StaffWidget extends StatelessWidget {
  final dynamic _itemModel;
  final bool _isStaff;


  StaffWidget(this._itemModel, this._isStaff);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StaffInfoScreen(args: {'id': _itemModel.sId, 'url': _itemModel.imageData != null ? _itemModel.imageData.url ?? '' : '', 'type': _isStaff.toString()}),
            ),
          ),
      child: Card(
        color: color5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FittedBox(
                  child: CacheImage(_itemModel.imageData != null ? _itemModel.imageData.url ?? '' : ''),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if(_itemModel.name != null) Text(_itemModel.name ?? '', overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 17),),
                  const SizedBox(height: 20),
                  /*if(_itemModel.rawName != null)Text(
                    _itemModel.rawName ?? '', overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 14),),*/
                  SizedBox(height: 5),
                  if(_itemModel.gender != null && _itemModel.gender != '')Text(
                    _itemModel.gender ?? '', overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 13),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

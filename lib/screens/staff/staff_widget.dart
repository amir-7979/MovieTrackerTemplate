import 'package:app04/screens/staff/staff_info_screen.dart';
import 'package:flutter/material.dart';
import '../../utilities/cache_image.dart';
import '../../utilities/consts.dart';
import '../person_info_screen/PersonInfoScreen.dart';

class StaffWidget extends StatelessWidget {
  final dynamic _itemModel;

  StaffWidget(this._itemModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StaffInfoScreen(args: {'id': _itemModel.sId, 'url': _itemModel.imageData != null ? _itemModel.imageData.url ?? '' : '',}),
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
                  Text(_itemModel.name ?? '', overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 17),),
                  const SizedBox(height: 20),
                  Text(
                    _itemModel.rawName ?? '', overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 14),),
                  Text(
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

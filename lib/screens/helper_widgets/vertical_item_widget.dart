import 'package:app04/models/low_data_item.dart';
import 'package:app04/screens/info/info_screen.dart';
import 'package:flutter/material.dart';
import '../../utilities/cache_image.dart';
import '../../utilities/consts.dart';

class VerticalItemWidget extends StatelessWidget {
  final LowDataItem _itemModel;
   const VerticalItemWidget(this._itemModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InfoScreen(args: {'id': _itemModel.id, 'url': _itemModel.posters.isNotEmpty ? _itemModel.posters[0].url ?? '' : 'assets/images/no_image.jpg', 'type': _itemModel.type}),
        ),
      ),
      child: Card(
        color: color5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 7,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              height: 140,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FittedBox(
                  child: CacheImage((_itemModel.posters.isNotEmpty) ? _itemModel.posters[0].url : ''),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width -200,
                    child: Text(_itemModel.title, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start, style: const TextStyle(fontSize: 17),)),
                const SizedBox(height: 25),
                Text("year : "+ _itemModel.year.toString(), textAlign: TextAlign.left, style: const TextStyle(fontSize: 15)),
                Row(
                  children: [
                    SizedBox(width: 45, height: 30,
                        child: Image.asset('assets/images/imdb.jpg')
                    ),
                    Text(" : ${_itemModel.rating.imdb.toString()}", style: const TextStyle(fontSize: 15),),
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: Icon(Icons.circle, size: 15,color: Colors.redAccent,),
                    ),
                    Text(_itemModel.type, textAlign: TextAlign.start, style: const TextStyle(fontSize: 17),)
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

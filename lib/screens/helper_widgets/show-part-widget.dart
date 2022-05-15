import 'package:app04/models/low_data_item.dart';
import 'package:app04/screens/helper_widgets/horizontal_item_widget.dart';
import 'package:flutter/material.dart';

class showPartWidget extends StatelessWidget {
  List<LowDataItem> items;

  showPartWidget(this.items, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
          itemCount: items.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) => HorizontalItemWidget(items[index])
      ),
    );
  }
}

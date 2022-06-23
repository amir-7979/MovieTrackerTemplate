import 'package:app04/models/low_data_item.dart';
import 'package:app04/screens/helper_widgets/show-part-widget.dart';
import 'package:flutter/material.dart';
import '../../utilities/consts.dart';
import '../more/more_screen.dart';

class HorizontalPart extends StatelessWidget {
  final String _name, _argName;
  final List<LowDataItem> _lowDataItems;
  final Function _function;
  late Map<String, dynamic> _map;



  HorizontalPart(this._name, this._argName, this._lowDataItems, this._function){
    _map = {'argName': _argName, 'function': _function};
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_name, style: Theme.of(context).textTheme.headline2),
            IconButton(
              icon: const Icon(Icons.grid_view, size: 20, color: yellow1),
              onPressed: () => Navigator.of(context)
                  .pushNamed(MoreScreen.routeName, arguments:_map),
            ),
          ],
        ),
        showPartWidget(_lowDataItems),
      ],
    );
  }
}

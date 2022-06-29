
import 'package:flutter/material.dart';

import '../../models/search_filter_model.dart';

class StaffFilterWidget extends StatefulWidget {
  final Function submitFilter;

  const StaffFilterWidget(this.submitFilter, {Key? key}) : super(key: key);

  @override
  State<StaffFilterWidget> createState() => _StaffFilterWidgetState();
}

class _StaffFilterWidgetState extends State<StaffFilterWidget> {
  bool isCharacter = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                'Filter',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                widget.submitFilter(SearchFilter('', '', '', ''));
                Navigator.pop(context);
              },
              child: const Icon(Icons.check),
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  elevation: 5,
                  primary: Colors.green),
            )
          ],
        ),

      ],
    );
  }
}

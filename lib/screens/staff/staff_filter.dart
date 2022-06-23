import 'package:app04/models/staff_seach_filter_model.dart';
import 'package:app04/utilities/consts.dart';
import 'package:flutter/material.dart';

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
                widget.submitFilter(StaffSearchFilter(isCharacter));
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
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 0, 10),
          child: Text('Type', style: Theme.of(context).textTheme.bodyMedium),
        ),
       Row(
         children: [
           Text('search in Characters?'),
           Checkbox(
             value: isCharacter,
             onChanged: (value) => setState(() => isCharacter = value!),
             activeColor: active,
           ),
         ],
       ),
      ],
    );
  }
}

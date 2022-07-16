import 'package:flutter/material.dart';

class FieldWidget extends StatelessWidget {
  final String fieldName;
  final String fieldValue;

  FieldWidget( this.fieldName, this.fieldValue);

  @override
  Widget build(BuildContext context) {
    return (fieldValue.isNotEmpty)? Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(fieldName, style: TextStyle(fontSize: 13, color: Colors.grey)),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 2),
            child: Text(fieldValue, style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
          Divider(),
          //Container(height: 1, color: Colors.red),
          const SizedBox(height: 10,)
        ],
      ),
    ) : SizedBox(height: 0.1,);
  }
}

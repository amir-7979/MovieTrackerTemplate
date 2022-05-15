import 'package:flutter/material.dart';

Widget titleButtonWidget(String txt, Function function, Color color){
  return Row(
    children: [
      TextButton(onPressed: () => function(), child: Text(txt, style: TextStyle(color: color))),
      Expanded(child: Container())
    ],
  );
}
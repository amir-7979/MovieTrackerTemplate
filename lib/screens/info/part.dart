import 'package:flutter/material.dart';
class Part extends StatelessWidget {
  String? name,value;

  Part(this.name, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(name!+" : ", style: const TextStyle(color: Colors.cyan, fontSize: 18),),
        const SizedBox(width: 10,),
        Expanded(
          child: (value != null) ? Text(value!, maxLines: 4,
             style: const TextStyle(color: Colors.white, fontSize: 18),
            overflow: TextOverflow.ellipsis,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.start,) : const SizedBox(width: 1),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

Widget downloadButtonWidget(BuildContext context, String name, String? info, String? imageUrl, String? downloadLink, Function function) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Theme.of(context).primaryColor,
      elevation: 15,
    ),
    onLongPress: () => Share.share(
      downloadLink ?? '',
      subject: imageUrl,
    ),
    onPressed: () async {
      //function(downloadLink, 'temp.mkv');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Download link copied to clipboard"),
        duration: Duration(seconds: 1),
      ));
      Clipboard.setData(ClipboardData(text: downloadLink));
    },
    child: Text(info ?? ''),
  );
}

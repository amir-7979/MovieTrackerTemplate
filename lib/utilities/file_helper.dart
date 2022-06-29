import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileHelper{

  static Future<String> createFolder(String cow) async {
    final dir = Directory((await getExternalStorageDirectory())!.path + '/$cow');
    if ((await dir.exists())) {
      return dir.path;
    } else {
      dir.create();
      return dir.path;
    }
  }}
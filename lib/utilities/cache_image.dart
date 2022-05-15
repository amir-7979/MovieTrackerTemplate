import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheImage extends StatelessWidget {
  String? imageUrl;


  CacheImage(this.imageUrl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (imageUrl != null && imageUrl!.isNotEmpty) ? CachedNetworkImage(
      imageUrl:  imageUrl! ,
      errorWidget: (context, url, error) =>
      const Icon(Icons.error),
    ) : Container();
  }
}

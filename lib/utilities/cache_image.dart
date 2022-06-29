import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheImage extends StatelessWidget {
  String? imageUrl;


  CacheImage(this.imageUrl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (imageUrl != null && imageUrl!.isNotEmpty) ? CachedNetworkImage(
      fit: BoxFit.fill,
      fadeInCurve: Curves.linear,
      imageUrl:  imageUrl! ,
      errorWidget: (context, url, error) => Image.asset('assets/images/no_image.jpg'),
    ) : Container();
  }
}

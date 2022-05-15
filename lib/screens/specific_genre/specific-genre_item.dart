import 'package:flutter/material.dart';
import '../../utilities/cache_image.dart';
import '../info/info_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SpecificGenreItem extends StatelessWidget {
  final String id;
  final String name;
  final String type;
  final double? rate;
  final int? year;
  final String? imageUrl;


  SpecificGenreItem(this.id, this.name, this.type, this.rate, this.year, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> Navigator.of(context).pushNamed(InfoScreen.routeName , arguments: id),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 2, 2, 2),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                height: 140,
                child: FittedBox(
                  child: (imageUrl != null) ?
                  CacheImage(imageUrl): const Padding(
                    padding: EdgeInsets.fromLTRB(7, 1, 7, 1),
                    child: Text('No Image'),
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              Container(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width -200,
                      child: Text(name, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start, style: const TextStyle(fontSize: 17),)),
                  const SizedBox(height: 20),
                  Text("year : "+ year.toString(), textAlign: TextAlign.left, style: const TextStyle(fontSize: 15)),
                  Row(
                    children: [
                      SizedBox(width: 45, height: 30,
                          child: Image.asset('assets/images/imdb.jpg')
                      ),
                      Text(" : ${rate.toString()}", style: const TextStyle(fontSize: 15),),
                    ],
                  ),
                  Text("type : "+ type.toString(), textAlign: TextAlign.left, style: const TextStyle(fontSize: 15)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

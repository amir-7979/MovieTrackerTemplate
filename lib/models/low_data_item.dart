import 'package:app04/models/properties_model.dart';

class LowDataItem {
  LowDataItem({
    required this.id,
    required this.title,
    required this.type,
    required this.rawTitle,
    required this.posters,
    required this.year,
    required this.premiered,
    required this.rating,
  });
  late final String id;
  late final String title;
  late final String type;
  late final String rawTitle;
  late final List<Poster> posters;
  late final String year;
  late final String premiered;
  late final Rating rating;

  LowDataItem.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    title = json['title'];
    type = json['type'];
    rawTitle = json['rawTitle'];
    posters = List.from(json['posters']).map((e)=>Poster.fromJson(e)).toList();
    year = json['year'];
    premiered = json['premiered'];
    rating = Rating.fromJson(json['rating']);
  }
}

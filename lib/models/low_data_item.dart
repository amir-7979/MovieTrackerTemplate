import 'package:app04/models/properties_model.dart';

class LowDataItem {
  LowDataItem({
    required this.id,
    required this.title,
    required this.type,
    required this.rawTitle,
    required this.likesCount,
    required this.dislikesCount,
    required this.posters,
    required this.year,
    required this.premiered,
    required this.rating,
    required this.likeOrDislike,
  });
  late final String id;
  late final String title;
  late final String type;
  late final String rawTitle;
  late final int likesCount;
  late final int dislikesCount;
  late final List<Posters> posters;
  late final String year;
  late final String premiered;
  late final Rating rating;
  late final String? likeOrDislike;

  LowDataItem.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    title = json['title'];
    type = json['type'];
    rawTitle = json['rawTitle'];
    likesCount = json['likesCount'];
    dislikesCount = json['dislikesCount'];
    posters = List.from(json['posters']).map((e)=>Posters.fromJson(e)).toList();
    year = json['year'];
    premiered = json['premiered'];
    rating = Rating.fromJson(json['rating']);
    likeOrDislike = json['likeOrDislike'];
  }
}

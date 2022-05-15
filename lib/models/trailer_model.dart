
import 'package:app04/models/properties_model.dart';

class TrailerModel {
  String? id;
  String? title;
  String? type;
  String? rawTitle;
  int? like;
  List<Posters>? posters;
  List<Trailers>? trailers;
  String? status;
  String? year;
  String? rated;
  List<String>? genres;
  double? rating;
  List<dynamic>? qualities;
  int? likesCount;

  TrailerModel({
    this.id,
    this.title,
    this.type,
    this.rawTitle,
    this.like,
    this.posters,
    this.trailers,
    this.status,
    this.year,
    this.rated,
    this.genres,
    this.rating,
    this.qualities,
    this.likesCount,
  });

  TrailerModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    title = json['title'] as String?;
    type = json['type'] as String?;
    rawTitle = json['rawTitle'] as String?;
    like = json['like'] as int?;
    posters = (json['posters'] as List?)?.map((dynamic e) => Posters.fromJson(e as Map<String,dynamic>)).toList();
    trailers = (json['trailers'] as List?)?.map((dynamic e) => Trailers.fromJson(e as Map<String,dynamic>)).toList();
    status = json['status'] as String?;
    year = json['year'] as String?;
    rated = json['rated'] as String?;
    genres = (json['genres'] as List?)?.map((dynamic e) => e as String).toList();
    rating = (json['rating']['imdb'].toDouble());
    qualities = json['qualities'] as List?;
    likesCount = json['likesCount'] as int?;
  }

}


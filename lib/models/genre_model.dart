import 'package:app04/models/properties_model.dart';

class Genre {
  Genre({
    required this.poster,
    required this.count,
    required this.genre,
  });
  late final Poster poster;
  late final int count;
  late final String genre;

  Genre.fromJson(Map<String, dynamic> json){
    if(json['poster'] != null) {
      poster = Poster.fromJson(json['poster']);
    }else {
      poster = Poster(info: '', size: 0, url: '');
    }
    count = json['count'];
    genre = json['genre'];
  }

}


import 'low_data_item.dart';

class SearchModel {
  SearchModel({
    required this.movies,
    required this.staff,
    required this.characters,
  });
  late final List<LowDataItem> movies;
  late final List<dynamic> staff;
  late final List<dynamic> characters;

  SearchModel.fromJson(Map<String, dynamic> json){
    movies = List.from(json['movies']).map((e)=>LowDataItem.fromJson(e)).toList();
    staff = List.castFrom<dynamic, dynamic>(json['staff']);
    characters = List.castFrom<dynamic, dynamic>(json['characters']);
  }
}








import 'low_data_item.dart';

class Multiple {
  Multiple({
    required this.inTheaters,
    required this.comingSoon,
    required this.news,
    required this.update,
  });
  late final List<LowDataItem> inTheaters;
  late final List<LowDataItem> comingSoon;
  late final List<LowDataItem> news;
  late final List<LowDataItem> update;

  Multiple.fromJson(Map<String, dynamic> json){
    inTheaters = List.from(json['inTheaters']).map((e)=>LowDataItem.fromJson(e)).toList();
    comingSoon = List.from(json['comingSoon']).map((e)=>LowDataItem.fromJson(e)).toList();
    news = List.from(json['news']).map((e)=>LowDataItem.fromJson(e)).toList();
    update = List.from(json['update']).map((e)=>LowDataItem.fromJson(e)).toList();
  }

}

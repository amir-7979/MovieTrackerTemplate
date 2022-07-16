
import 'package:app04/models/properties_model.dart';

class TrailerModel {
  String? sId;
  String? releaseState;
  Rank? rank;
  String? title;
  String? type;
  String? rawTitle;
  List<String>? alternateTitles;
  int? updateDate;
  List<Poster>? posters = [];
  Summary? summary;
  List<Trailers>? trailers = [];
  LatestData? latestData;
  String? status;
  String? releaseDay;
  String? year;
  String? premiered;
  dynamic nextEpisode;
  BoxOfficeData? boxOfficeData;
  List<String>? genres;
  Rating? rating;
  UserStats? userStats;

  TrailerModel(
      {this.sId,
        this.releaseState,
        this.rank,
        this.title,
        this.type,
        this.rawTitle,
        this.alternateTitles,
        this.updateDate,
        this.posters,
        this.summary,
        this.trailers,
        this.latestData,
        this.status,
        this.releaseDay,
        this.year,
        this.premiered,
        this.nextEpisode,
        this.boxOfficeData,
        this.genres,
        this.rating,
        this.userStats});

  TrailerModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    releaseState = json['releaseState'];
    rank = json['rank'] != null ? new Rank.fromJson(json['rank']) : null;
    title = json['title'];
    type = json['type'];
    rawTitle = json['rawTitle'];
    alternateTitles = json['alternateTitles'].cast<String>();
    updateDate = json['update_date'];
    if (json['posters'] != null) {
      json['posters'].forEach((v) {
        posters!.add(Poster.fromJson(v));
      });
    }
    summary =
    json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
    if (json['trailers'] != null) {
      json['trailers'].forEach((v) {
        trailers!.add( Trailers.fromJson(v));
      });
    }
    latestData = json['latestData'] != null
        ?  LatestData.fromJson(json['latestData'])
        : null;
    status = json['status'];
    releaseDay = json['releaseDay'];
    year = json['year'];
    premiered = json['premiered'];
    nextEpisode = json['nextEpisode'];
    boxOfficeData = json['boxOfficeData'] != null
        ?  BoxOfficeData.fromJson(json['boxOfficeData'])
        : null;
    genres = json['genres'].cast<String>();
    rating =
    json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    userStats = json['userStats'] != null
        ?  UserStats.fromJson(json['userStats'])
        : null;
  }
}



import 'package:app04/models/properties_model.dart';

class SerialInfoModel {
  List<Map<String, String>>? maps;
  String? id;
  String? releaseState;
  Rank? rank;
  String? title;
  String? type;
  String? rawTitle;
  List<dynamic>? alternateTitles;
  List<dynamic>? titleSynonyms;
  int? like;
  int? dislike;
  int? view;
  int? likeMonth;
  int? viewMonth;
  String? addDate;
  String? insertDate;
  //todo
  String? updateDate;
  String? apiUpdateDate;
  String? castUpdateDate;
  List<Seasons>? seasons;
  List<Posters>? posters;
  PosterS3? posterS3;
  dynamic trailerS3;
  Summary? summary;
  List<Trailers>? trailers;
  List<dynamic>? watchOnlineLinks;
  List<dynamic>? subtitles;
  LatestData? latestData;
  String? status;
  String? releaseDay;
  String? year;
  String? premiered;
  String? endYear;
  String? officialSite;
  String? webChannel;
  dynamic nextEpisode;
  String? duration;
  String? totalDuration;
  String? imdbID;
  int? tvmazeID;
  int? jikanID;
  int? totalSeasons;
  String? boxOffice;
  BoxOfficeData? boxOfficeData;
  String? rated;
  String? movieLang;
  String? country;
  List<String>? genres;
  Rating? rating;
  List<dynamic>? staffAndCharactersData;
  List<dynamic>? actors;
  List<dynamic>? directors;
  List<dynamic>? writers;
  String? awards;
  String? animeType;
  String? animeSource;
  List<dynamic>? relatedTitles;
  List<ActorsAndCharacters>? actorsAndCharacters;
  Staff? staff;
  List<dynamic>? qualities;
  int? dislikesCount;
  int? likesCount;
  String? likeOrDislike;

  SerialInfoModel({
    this.id,
    this.releaseState,
    this.rank,
    this.title,
    this.type,
    this.rawTitle,
    this.alternateTitles,
    this.titleSynonyms,
    this.like,
    this.dislike,
    this.view,
    this.likeMonth,
    this.viewMonth,
    this.addDate,
    this.insertDate,
    this.updateDate,
    this.apiUpdateDate,
    this.castUpdateDate,
    this.seasons,
    this.posters,
    this.posterS3,
    this.trailerS3,
    this.summary,
    this.trailers,
    this.watchOnlineLinks,
    this.subtitles,
    this.latestData,
    this.status,
    this.releaseDay,
    this.year,
    this.premiered,
    this.endYear,
    this.officialSite,
    this.webChannel,
    this.nextEpisode,
    this.duration,
    this.totalDuration,
    this.imdbID,
    this.tvmazeID,
    this.jikanID,
    this.totalSeasons,
    this.boxOffice,
    this.boxOfficeData,
    this.rated,
    this.movieLang,
    this.country,
    this.genres,
    this.rating,
    this.staffAndCharactersData,
    this.actors,
    this.directors,
    this.writers,
    this.awards,
    this.animeType,
    this.animeSource,
    this.relatedTitles,
    this.actorsAndCharacters,
    this.staff,
    this.qualities,
    this.dislikesCount,
    this.likesCount,
    this.likeOrDislike,
    this.maps
  });

  SerialInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    releaseState = json['releaseState'] as String?;
    rank = (json['rank'] as Map<String,dynamic>?) != null ? Rank.fromJson(json['rank'] as Map<String,dynamic>) : null;
    title = json['title'] as String?;
    type = json['type'] as String?;
    rawTitle = json['rawTitle'] as String?;
    alternateTitles = json['alternateTitles'] as List?;
    titleSynonyms = json['titleSynonyms'] as List?;
    like = json['like'] as int?;
    dislike = json['dislike'] as int?;
    view = json['view'] as int?;
    likeMonth = json['like_month'] as int?;
    viewMonth = json['view_month'] as int?;
    addDate = json['add_date'].toString();
    insertDate = json['insert_date'].toString();

    updateDate = json['update_date'].toString();

    apiUpdateDate = json['apiUpdateDate'].toString();
    castUpdateDate = json['castUpdateDate'].toString();
    seasons = (json['seasons'] as List?)?.map((dynamic e) => Seasons.fromJson(e as Map<String,dynamic>)).toList();
    posters = (json['posters'] as List?)?.map((dynamic e) => Posters.fromJson(e as Map<String,dynamic>)).toList();
    posterS3 = (json['poster_s3'] as Map<String,dynamic>?) != null ? PosterS3.fromJson(json['poster_s3'] as Map<String,dynamic>) : null;
    trailerS3 = json['trailer_s3'];
    summary = (json['summary'] as Map<String,dynamic>?) != null ? Summary.fromJson(json['summary'] as Map<String,dynamic>) : null;
    trailers = (json['trailers'] as List?)?.map((dynamic e) => Trailers.fromJson(e as Map<String,dynamic>)).toList();
    watchOnlineLinks = json['watchOnlineLinks'] as List?;
    subtitles = json['subtitles'] as List?;
    latestData = (json['latestData'] as Map<String,dynamic>?) != null ? LatestData.fromJson(json['latestData'] as Map<String,dynamic>) : null;
    status = json['status'] as String?;
    releaseDay = json['releaseDay'] as String?;
    year = json['year'] as String?;
    premiered = json['premiered'] as String?;
    endYear = json['endYear'] as String?;
    officialSite = json['officialSite'] as String?;
    webChannel = json['webChannel'] as String?;
    nextEpisode = json['nextEpisode'];
    duration = json['duration'] as String?;
    totalDuration = json['totalDuration'] as String?;
    imdbID = json['imdbID'] as String?;
    tvmazeID = json['tvmazeID'] as int?;
    jikanID = json['jikanID'] as int?;
    totalSeasons = json['totalSeasons'] as int?;
    boxOffice = json['boxOffice'] as String?;
    boxOfficeData = (json['boxOfficeData'] as Map<String,dynamic>?) != null ? BoxOfficeData.fromJson(json['boxOfficeData'] as Map<String,dynamic>) : null;
    rated = json['rated'] as String?;
    movieLang = json['movieLang'] as String?;
    country = json['country'] as String?;
    genres = (json['genres'] as List?)?.map((dynamic e) => e as String).toList();
    rating = (json['rating'] as Map<String,dynamic>?) != null ? Rating.fromJson(json['rating'] as Map<String,dynamic>) : null;
    staffAndCharactersData = json['staffAndCharactersData'] as List?;
    actors = json['actors'] as List?;
    directors = json['directors'] as List?;
    writers = json['writers'] as List?;
    awards = json['awards'] as String?;
    animeType = json['animeType'] as String?;
    animeSource = json['animeSource'] as String?;
    relatedTitles = json['relatedTitles'] as List?;
    actorsAndCharacters = (json['actorsAndCharacters'] as List?)?.map((dynamic e) => ActorsAndCharacters.fromJson(e as Map<String,dynamic>)).toList();
    staff = (json['staff'] as Map<String,dynamic>?) != null ? Staff.fromJson(json['staff'] as Map<String,dynamic>) : null;
    qualities = json['qualities'] as List?;
    dislikesCount = json['dislikesCount'] as int?;
    likesCount = json['likesCount'] as int?;
    likeOrDislike = json['likeOrDislike'] as String?;
    maps = makeMap();
  }

  @override
  String toString() {
    return 'SerialInfoModel{seasons: $seasons}';
  }

  List<Map<String, String>> makeMap(){
    List<Map<String, String>> newSeasons = [];
    Map<String, String> temp;
    List<String> split;
    for(var se in seasons!){
      for(var ep in se.episodes!){
        for(var link in ep.links!){
          split = link.info!.split('-');
          temp = {'number': se.seasonNumber.toString(), 'quality': split.first, 'size': (split.length > 1 ) ? split[1]: ''};
          if(!checkExist(newSeasons, temp)){
            newSeasons.add(temp);
          }
        }
      }
    }
    return newSeasons;
  }

  bool checkExist(List<Map<String, String>> newSeasons, Map<String, String> temp) {
    for(var item in newSeasons) {
      if(item['number'] == temp['number'] && item['quality'] == temp['quality']) return true;
    }
    return false;
  }


}

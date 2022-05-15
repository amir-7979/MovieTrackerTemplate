class Rank {
  int? animeTopComingSoon;
  int? animeTopAiring;
  int? comingSoon;
  int? inTheaters;
  int? boxOffice;
  int? top;
  int? popular;

  Rank({
    this.animeTopComingSoon,
    this.animeTopAiring,
    this.comingSoon,
    this.inTheaters,
    this.boxOffice,
    this.top,
    this.popular,
  });

  Rank.fromJson(Map<String, dynamic> json) {
    animeTopComingSoon = json['animeTopComingSoon'] as int?;
    animeTopAiring = json['animeTopAiring'] as int?;
    comingSoon = json['comingSoon'] as int?;
    inTheaters = json['inTheaters'] as int?;
    boxOffice = json['boxOffice'] as int?;
    top = json['top'] as int?;
    popular = json['popular'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['animeTopComingSoon'] = animeTopComingSoon;
    json['animeTopAiring'] = animeTopAiring;
    json['comingSoon'] = comingSoon;
    json['inTheaters'] = inTheaters;
    json['boxOffice'] = boxOffice;
    json['top'] = top;
    json['popular'] = popular;
    return json;
  }
}

class Seasons {
  int? seasonNumber;
  List<Episodes>? episodes;

  Seasons({
    this.seasonNumber,
    this.episodes,
  });

  Seasons.fromJson(Map<String, dynamic> json) {
    seasonNumber = json['seasonNumber'] as int?;
    episodes = (json['episodes'] as List?)?.map((dynamic e) => Episodes.fromJson(e as Map<String,dynamic>)).toList();
  }

  @override
  String toString() {
    return 'Seasons{seasonNumber: $seasonNumber, episodes: $episodes}';
  }
}

class Episodes {
  int? episodeNumber;
  String? title;
  String? released;
  String? releaseStamp;
  String? duration;
  String? imdbRating;
  String? imdbID;
  List<Links>? links;

  Episodes({
    this.episodeNumber,
    this.title,
    this.released,
    this.releaseStamp,
    this.duration,
    this.imdbRating,
    this.imdbID,
    this.links,
  });

  Episodes.fromJson(Map<String, dynamic> json) {
    episodeNumber = json['episodeNumber'] as int?;
    title = json['title'] as String?;
    released = json['released'] as String?;
    releaseStamp = json['releaseStamp'] as String?;
    duration = json['duration'] as String?;
    imdbRating = json['imdbRating'] as String?;
    imdbID = json['imdbID'] as String?;
    links = (json['links'] as List?)?.map((dynamic e) => Links.fromJson(e as Map<String,dynamic>)).toList();
  }

  @override
  String toString() {
    return 'Episodes{episodeNumber: $episodeNumber, title: $title, released: $released, releaseStamp: $releaseStamp, duration: $duration, imdbRating: $imdbRating, imdbID: $imdbID, links: $links}';
  }
}

class Links {
  String? link;
  String? info;
  String? qualitySample;
  String? sourceName;
  String? pageLink;
  int? season;
  int? episode;

  Links({
    this.link,
    this.info,
    this.qualitySample,
    this.sourceName,
    this.pageLink,
    this.season,
    this.episode,
  });

  Links.fromJson(Map<String, dynamic> json) {
    link = json['link'] as String?;
    info = json['info'] as String?;
    qualitySample = json['qualitySample'] as String?;
    sourceName = json['sourceName'] as String?;
    pageLink = json['pageLink'] as String?;
    season = json['season'] as int?;
    episode = json['episode'] as int?;
  }

  @override
  String toString() {
    return 'Links{link: $link, info: $info, qualitySample: $qualitySample, sourceName: $sourceName, pageLink: $pageLink, season: $season, episode: $episode}';
  }
}

class Qualities {
  Qualities({
    required this.quality,
    required this.links,
  });

  late final String? quality;
  late final List<Links>? links;

  Qualities.fromJson(Map<String, dynamic> json) {
    quality = json['quality'];
    links = List.from(json['links']).map((e) => Links.fromJson(e)).toList();
  }

  @override
  String toString() {
    return 'Qualities{quality: $quality, links: $links}';
  }
}


class Posters {
  String? url;
  String? info;
  int? size;

  Posters({
    this.url,
    this.info,
    this.size,
  });

  Posters.fromJson(Map<String, dynamic> json) {
    url = json['url'] as String?;
    info = json['info'] as String?;
    size = json['size'] as int?;
  }
}

class PosterS3 {
  String? url;
  String? originalUrl;
  int? size;

  PosterS3({
    this.url,
    this.originalUrl,
    this.size,
  });

  PosterS3.fromJson(Map<String, dynamic> json) {
    url = json['url'] as String?;
    originalUrl = json['originalUrl'] as String?;
    size = json['size'] as int?;
  }
}

class Summary {
  String? persian;
  String? english;

  Summary({
    this.persian,
    this.english,
  });

  Summary.fromJson(Map<String, dynamic> json) {
    persian = json['persian'] as String?;
    english = json['english'] as String?;
  }
}

class Trailers {
  String? url;
  String? info;

  Trailers({
    this.url,
    this.info,
  });

  Trailers.fromJson(Map<String, dynamic> json) {
    url = json['url'] as String?;
    info = json['info'] as String?;
  }
}

class LatestData {
  int? season;
  int? episode;
  String? quality;
  String? hardSub;
  String? dubbed;
  String? subtitle;

  LatestData({
    this.season,
    this.episode,
    this.quality,
    this.hardSub,
    this.dubbed,
    this.subtitle,
  });

  LatestData.fromJson(Map<String, dynamic> json) {
    season = json['season'] as int?;
    episode = json['episode'] as int?;
    quality = json['quality'] as String?;
    hardSub = json['hardSub'].toString();
    dubbed = json['dubbed'].toString();
    subtitle = json['subtitle'].toString();
  }
}

class BoxOfficeData {
  String? weekend;
  String? gross;
  int? weeks;

  BoxOfficeData({
    this.weekend,
    this.gross,
    this.weeks,
  });

  BoxOfficeData.fromJson(Map<String, dynamic> json) {
    weekend = json['weekend'] as String?;
    gross = json['gross'] as String?;
    weeks = json['weeks'] as int?;
  }
}

class Rating {
  double? imdb;
  int? rottenTomatoes;
  int? metacritic;
  double? myAnimeList;

  Rating({
    this.imdb,
    this.rottenTomatoes,
    this.metacritic,
    this.myAnimeList,
  });

  Rating.fromJson(Map<String, dynamic> json) {
    imdb = json['imdb'].toDouble();
    rottenTomatoes = json['rottenTomatoes'] as int?;
    metacritic = json['metacritic'] as int?;
    myAnimeList = json['myAnimeList'].toDouble();
  }
}

class ActorsAndCharacters {
  String? id;
  String? name;
  String? gender;
  String? country;
  String? image;
  List<String>? positions;
  CharacterData? characterData;

  ActorsAndCharacters({
    this.id,
    this.name,
    this.gender,
    this.country,
    this.image,
    this.positions,
    this.characterData,
  });

  ActorsAndCharacters.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    gender = json['gender'] as String?;
    country = json['country'] as String?;
    image = json['image'] as String?;
    positions = (json['positions'] as List?)?.map((dynamic e) => e as String).toList();
    characterData = (json['characterData'] as Map<String,dynamic>?) != null ? CharacterData.fromJson(json['characterData'] as Map<String,dynamic>) : null;
  }
}

class CharacterData {
  String? id;
  String? name;
  String? gender;
  String? image;
  String? role;

  CharacterData({
    this.id,
    this.name,
    this.gender,
    this.image,
    this.role,
  });

  CharacterData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    gender = json['gender'] as String?;
    image = json['image'] as String?;
    role = json['role'] as String?;
  }
}

class Staff {
  List<dynamic>? directors;
  List<Writers>? writers;
  List<dynamic>? others;

  Staff({
    this.directors,
    this.writers,
    this.others,
  });

  Staff.fromJson(Map<String, dynamic> json) {
    directors = json['directors'] as List?;
    writers = (json['writers'] as List?)?.map((dynamic e) => Writers.fromJson(e as Map<String,dynamic>)).toList();
    others = json['others'] as List?;
  }
}

class Writers {
  String? name;
  String? rawName;
  String? gender;
  String? country;
  String? image;
  List<String>? positions;
  dynamic characterData;

  Writers({
    this.name,
    this.rawName,
    this.gender,
    this.country,
    this.image,
    this.positions,
    this.characterData,
  });

  Writers.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    rawName = json['rawName'] as String?;
    gender = json['gender'] as String?;
    country = json['country'] as String?;
    image = json['image'] as String?;
    positions = (json['positions'] as List?)?.map((dynamic e) => e as String).toList();
    characterData = json['characterData'];
  }
}

class Premiered {
  Premiered({required this.url, required this.info, required this.size});

  late final String? url;
  late final String? info;
  late final int? size;

  Premiered.fromJson(Map<String, dynamic> json) {
    url = json['url'] as String?;
    info = json['info'] as String?;
    size = json['size'] as int?;
  }
}

class LikesCount {
  LikesCount({
    required this.imdb,
    required this.rottenTomatoes,
    required this.metacritic,
    required this.myAnimeList,
  });

  late final double imdb;
  late final int? rottenTomatoes;
  late final int? metacritic;
  late final int myAnimeList;

  LikesCount.fromJson(Map<String, dynamic> json) {
    imdb = json['imdb'];
    rottenTomatoes = json['rottenTomatoes'];
    metacritic = json['metacritic'];
    myAnimeList = json['myAnimeList'];
  }
}

class TrailerS3 {
  TrailerS3({
    required this.url,
    required this.originalUrl,
    required this.size,
  });
  late final String url;
  late final String originalUrl;
  late final int size;

  TrailerS3.fromJson(Map<String, dynamic> json){
    url = json['url'];
    originalUrl = json['originalUrl'];
    size = json['size'];
  }
}

class Directors {
  Directors({
    required this.name,
    required this.rawName,
    required this.gender,
    required this.country,
    required this.image,
    required this.positions,
    required this.characterData,
  });

  late final String name;
  late final String rawName;
  late final String gender;
  late final String country;
  late final String image;
  late final List<String> positions;
  late final CharacterData characterData;

  Directors.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rawName = json['rawName'];
    gender = json['gender'];
    country = json['country'];
    image = json['image'];
    positions = List.castFrom<dynamic, String>(json['positions']);
    characterData = CharacterData.fromJson(json['characterData']);
  }
}

class StaffAndCharactersData {
  StaffAndCharactersData({
    required this.name,
    required this.rawName,
    required this.gender,
    required this.country,
    required this.image,
    required this.positions,
    required this.characterData,
  });

  late final String name;
  late final String rawName;
  late final String gender;
  late final String country;
  late final String image;
  late final List<String> positions;
  late final CharacterData characterData;

  StaffAndCharactersData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rawName = json['rawName'];
    gender = json['gender'];
    country = json['country'];
    image = json['image'];
    positions = List.castFrom<dynamic, String>(json['positions']);
    characterData = CharacterData.fromJson(json['characterData']);
  }
}

class RelatedTitles {
  RelatedTitles({
    required this.id,
    required this.jikanID,
    required this.title,
    required this.rawTitle,
    required this.relation,
  });

  late final String id;
  late final int jikanID;
  late final String title;
  late final String rawTitle;
  late final String relation;

  RelatedTitles.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    jikanID = json['jikanID'];
    title = json['title'];
    rawTitle = json['rawTitle'];
    relation = json['relation'];
  }
}


class Others {
  Others({
    required this.id,
    required this.name,
    required this.gender,
    required this.country,
    required this.image,
    required this.positions,
    required this.characterData,
  });

  late final String id;
  late final String name;
  late final String gender;
  late final String country;
  late final String image;
  late final List<String> positions;
  late final CharacterData characterData;

  Others.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    country = json['country'];
    image = json['image'];
    positions = List.castFrom<dynamic, String>(json['positions']);
    characterData = CharacterData.fromJson(json['characterData']);
  }
}

class WatchOnlineLinks {
  String? link;
  String? info;

  WatchOnlineLinks({
    this.link,
    this.info,
  });

  WatchOnlineLinks.fromJson(Map<String, dynamic> json) {
    link = json['link'] as String?;
    info = json['info'] as String?;
  }
}

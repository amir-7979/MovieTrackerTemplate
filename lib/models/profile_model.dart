class Profile {
  Profile({
    required this.id,
    required this.username,
    required this.publicName,
    required this.email,
    required this.emailVerified,
    required this.bio,
    required this.profileImages,
    required this.defaultProfile,
    required this.friends,
    required this.favorites,
    required this.status,
    required this.registrationDate,
    required this.role,
    required this.thisDevice,
    required this.code,
    required this.errorMessage,
  });
  late  String id;
  late  String username;
  late  String publicName;
  late  String email;
  late  bool emailVerified;
  late  String bio;
  late  List<dynamic> profileImages;
  late  String defaultProfile;
  late  List<dynamic> friends;
  late  Favorites favorites;
  late  Status status;
  late  String registrationDate;
  late  String role;
  late  ThisDevice thisDevice;
  late  int code;
  late  String errorMessage;

  Profile.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    username = json['username'];
    publicName = json['publicName'];
    email = json['email'];
    emailVerified = json['emailVerified'];
    bio = json['bio'];
    profileImages = List.castFrom<dynamic, dynamic>(json['profileImages']);
    defaultProfile = json['defaultProfile'];
    friends = List.castFrom<dynamic, dynamic>(json['friends']);
    favorites = Favorites.fromJson(json['favorites']);
    status = Status.fromJson(json['status']);
    registrationDate = json['registrationDate'];
    role = json['role'];
    thisDevice = ThisDevice.fromJson(json['thisDevice']);
    code = json['code'];
    errorMessage = json['errorMessage'];
  }
}

class Favorites {
  Favorites({
    required this.titles,
    required this.staff,
    required this.characters,
  });
  late final List<dynamic> titles;
  late final List<dynamic> staff;
  late final List<dynamic> characters;

  Favorites.fromJson(Map<String, dynamic> json){
    titles = List.castFrom<dynamic, dynamic>(json['titles']);
    staff = List.castFrom<dynamic, dynamic>(json['staff']);
    characters = List.castFrom<dynamic, dynamic>(json['characters']);
  }

}

class Status {
  Status({
    required this.watched,
    required this.watching,
    required this.dropped,
    required this.wantToWatch,
  });
  late final List<dynamic> watched;
  late final List<dynamic> watching;
  late final List<dynamic> dropped;
  late final List<dynamic> wantToWatch;

  Status.fromJson(Map<String, dynamic> json){
    watched = List.castFrom<dynamic, dynamic>(json['watched']);
    watching = List.castFrom<dynamic, dynamic>(json['watching']);
    dropped = List.castFrom<dynamic, dynamic>(json['dropped']);
    wantToWatch = List.castFrom<dynamic, dynamic>(json['wantToWatch']);
  }
}

class ThisDevice {
  ThisDevice({
    required this.appName,
    required this.appVersion,
    required this.deviceOs,
    required this.deviceModel,
    required this.ipLocation,
    required this.deviceId,
    required this.loginDate,
    required this.lastUseDate,
  });
  late final String appName;
  late final String appVersion;
  late final String deviceOs;
  late final String deviceModel;
  late final String ipLocation;
  late final String deviceId;
  late final String loginDate;
  late final String lastUseDate;

  ThisDevice.fromJson(Map<String, dynamic> json){
    appName = json['appName'];
    appVersion = json['appVersion'];
    deviceOs = json['deviceOs'];
    deviceModel = json['deviceModel'];
    ipLocation = json['ipLocation'];
    deviceId = json['deviceId'];
    loginDate = json['loginDate'];
    lastUseDate = json['lastUseDate'];
  }
}
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:app04/models/movie_info_model.dart';
import 'package:app04/utilities/interceptors.dart';
import 'package:app04/utilities/preferences.dart';
import 'package:dio/dio.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../models/client_model.dart';
import '../models/genre_model.dart';
import '../models/low_data_item.dart';
import '../models/multiple_model.dart';
import '../models/profile_model.dart';
import '../models/properties_model.dart';
import '../models/serial_info_model.dart';
import '../models/session_model.dart';
import '../models/trailer_model.dart';
import 'consts.dart';

UserClient userClient = UserClient();
late Map<String, String> deviceInfo;
late Dio dio;
late Options cacheOption;

Future<void> preInit() async {
  BaseOptions options =
      BaseOptions(baseUrl: 'https://downloader-node-api.herokuapp.com/');
  dio = Dio(options);
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  deviceInfo = {
    "appName": packageInfo.appName,
    "appVersion": packageInfo.version,
    "os": Platform.operatingSystem,
    "deviceModel": (await DeviceInfoPlugin().androidInfo).model!,
  };
  cacheOption = buildCacheOptions(const Duration(minutes: 3));
  dio.interceptors.addAll({
    DioCacheManager(
            CacheConfig(baseUrl: 'https://downloader-node-api.herokuapp.com/'))
        .interceptor,
    GetTokenInterceptor(),
    GeneralInterceptor()
  });
  if (await Preferences.userExist()) {
    userClient = await Preferences.readUser();
    isLoggedIn = true;
  }
}

Future<String> signUpUser(String userName, String email, String password,
    String confirmPassword) async {
  final response = await dio.post(
    'users/signup?noCookie=true',
    data: jsonEncode(<String, dynamic>{
      'username': userName,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'deviceInfo': deviceInfo,
    }),
  );
  if (response.statusCode == 201) {
    userClient = UserClient.fromJson(response.data);
    Preferences.writeUser(userClient);
    return "signUp";
  } else {
    return response.data["errorMessage"];
  }
}

Future<String> logInUser(String userName, String password) async {
  try {
    final response = await dio.post(
      'users/login?noCookie=true',
      data: jsonEncode(<String, dynamic>{
        'username_email': userName,
        'password': password,
        'deviceInfo': deviceInfo,
      }),
    );
    if (response.statusCode == 200) {
      userClient = UserClient.fromJson(response.data);
      await Preferences.writeUser(userClient);
      return "logIn";
    } else {
      return 'wrong username or password';
    }
  } catch (error) {
    return 'wrong username or password';
  }
}

Future<String> logOutUser() async {
  final response = await dio.put('users/logout?noCookie=true');
  if (response.data['code'] == 200) {
    Preferences.deleteUser();
    userClient = UserClient();
    return "";
  } else {
    return response.data["errorMessage"];
  }
}

Future<List<Device>> forceLogoutAll() async {
  final response = await dio.put('users/forceLogoutAll?noCookie=true');
  if (response.data['code'] == 200) {
    return Session.fromJson(response.data).activeSessions;
  } else {
    return response.data["errorMessage"];
  }
}

Future<List<Device>> forceLogout(String txt) async {
  final response = await dio.put('users/forceLogout/{$txt}?noCookie=true');
  if (response.data['code'] == 200) {
    return Session.fromJson(response.data).activeSessions;
  } else {
    return response.data["errorMessage"];
  }
}

Future<Session?> activeSessions() async {
  try{
  final response = await dio.get('users/activeSessions?noCookie=true');
    return Session.fromJson(response.data);
  } catch(err) {
    return null;
  }
}

Future<Profile> myProfile() async {
  final response =
      await dio.get('users/myProfile?noCookie=true', options: cacheOption);
  if (response.data['code'] == 200) {
    return Profile.fromJson(response.data);
  } else {
    return response.data["errorMessage"];
  }
}

Future<String> sendVerifyEmail() async {
  final response = await dio.get('users/sendVerifyEmail?noCookie=true');
  if (response.data['code'] == 200) {
    return 'verify send';
  } else {
    return response.data["errorMessage"];
  }
}

Future<int?> getToken() async {
  final response = await dio.put(
    'users/getToken?noCookie=true',
    data: jsonEncode(<String, dynamic>{
      'deviceInfo': deviceInfo,
    }),
  );
  if (response.data['code'] == 200) {
    userClient.updateUser(response.data['accessToken'],
        response.data['accessToken_expire'], response.data['refreshToken']);
    Preferences.writeUser(userClient);
  }
  return response.statusCode;
}

Future<Multiple?> getFirstPartItems() async {
  try {
    final response = await dio.get(
      'movies/multiple/status/movie-serial-anime_movie-anime_serial/low/0-10/0-10/6/1',
      options: cacheOption,
    );
    return Multiple.fromJson(response.data['data']);
  } catch (error) {
    return null;
  }
}

Future<List<LowDataItem>?> getSecondPartItems(int i, int page) async {
  try {
    final response = await dio.get(
      'movies/seriesOfDay/$i/movie-serial-anime_movie-anime_serial/0-10/0-10/$page',
      options: cacheOption,
    );
    return List<LowDataItem>.from(
        response.data['data'].map((x) => LowDataItem.fromJson(x)));
  } catch (error) {
    return null;
  }
}

Future<List<TrailerModel>?> getTrailerPartItems() async {
  try {
    final response = await dio.get(
      'movies/trailers/movie-serial-anime_movie-anime_serial/medium/0-10/0-10/1',
      options: cacheOption,
    );
    return List<TrailerModel>.from(
        response.data['data'].map((x) => TrailerModel.fromJson(x)));
  } catch (error) {
    return null;
  }
}

Future<List<LowDataItem>?> getSearchItems(String title, int page, String filter) async {
  try {
    final response = await dio.get(
      'movies/searchbytitle/$title$filter$page',
      options: cacheOption,
    );
    return List<LowDataItem>.from(
        response.data['data']['movies'].map((x) => LowDataItem.fromJson(x)));
  } catch (error) {
    return null;
  }
}

Future<List<Staff>?> getStaffSearchItems(String title, int page, String filter, bool staff) async {
  try {
    final response = await dio.get(
      'movies/searchbytitle/$title$filter$page',
      options: cacheOption,
    );
    return List<Staff>.from(!staff ? response.data['data']['staff'].map((x) => Staff.fromJson(x)) :  response.data['data']['characters'].map((x) => Staff.fromJson(x)));
  } catch (error) {
    return null;
  }
}

Future<SerialInfoModel?> getSerialInfo(String txt) async {
  try {
    final response = await dio.get(
      'movies/searchbyid/$txt/high',
      options: cacheOption,
    );
    return SerialInfoModel.fromJson(response.data['data']);
  } catch (error) {
    return null;
  }
}

Future<MovieInfoModel?> getMovieInfo(String txt) async {
  try {
    final response = await dio.get(
      'movies/searchbyid/$txt/high',
    );
    return MovieInfoModel.fromJson(response.data['data']);
  } catch (error) {
    return null;
  }
}

Future<Staff?> getStaffInfo(String txt) async {
  try {
    final response = await dio.get(
      'movies/staff/searchById/$txt',
    );
    return Staff.fromJson(response.data['data']);
  } catch (error) {
    return null;
  }
}

Future<Character?> getCharacterInfo(String txt) async {
  try {
    final response = await dio.get(
      'movies/characters/searchById/$txt',
    );
    return Character.fromJson(response.data['data']);
  } catch (error) {
    return null;
  }
}

Future<List<Genre>?> getGenres() async {
  try {
    final response = await dio.get(
      'movies/status/genres',
      options: cacheOption,
    );
    return List.from(response.data['data'])
        .map((e) => Genre.fromJson(e))
        .toList();
  } catch (error) {
    return null;
  }
}

Future<List<LowDataItem>?> getGenreItems(String txt, int page) async {
  txt = txt.replaceAll('-', '_');
  txt = txt.replaceAll(' ', '_');
  try {
    final response = await dio.get(
      'movies/genres/$txt/serial-movie-anime_movie-anime_serial/low/0-10/0-10/$page',
      options: cacheOption,
    );
    return List.from(response.data['data'])
        .map((e) => LowDataItem.fromJson(e))
        .toList();
  } catch (error) {
    return null;
  }
}

Future<List<LowDataItem>?> getMoreMovie(String type, int page) async {
  try {
    final response = await dio.get(
      'movies/$type/movie-anime_movie-serial-anime_serial/low/0-10/0-10/$page',
      options: cacheOption,
    );
    return List<LowDataItem>.from(
        response.data['data'].map((x) => LowDataItem.fromJson(x)));
  } catch (error) {
    return null;
  }
}

Future<List<LowDataItem>?> sortedMovies(String type, int page) async {
  try {
    final response = await dio.get(
      'movies/sortedMovies/$type/movie-anime_movie-serial-anime_serial/low/0-10/0-10/$page',
      options: cacheOption,
    );
    return List<LowDataItem>.from(
        response.data['data'].map((x) => LowDataItem.fromJson(x)));
  } catch (error) {
    return null;
  }
}

Future<List<LowDataItem>?> getMoreSortedMovie(String type, int page) async {
  try {
    final response = await dio.get(
      'movies/sortedMovies/$type/movie-anime_movie-serial-anime_serial/low/0-10/0-10/$page',
      options: cacheOption,
    );
    return List<LowDataItem>.from(
        response.data['data'].map((x) => LowDataItem.fromJson(x)));
  } catch (error) {
    return null;
  }
}

Future<int> likeOrDislike(String type, String id, bool remove) async {
  try {
    final response = await dio.put('movies/addUserStats/$type/$id',
        queryParameters: {'remove': remove});
   return response.data['code'];
  } catch (error) {
    return -1;
  }
}

Future<void> checkUserConnection() async {
  try {
    final result = await InternetAddress.lookup('youtube.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      activeConnection = true;
    }
  } on SocketException {
    activeConnection = false;
  }
}

Future<List<LowDataItem>?> userStatsList(String type, int page) async {
  try {
    final response = await dio.get('movies/userStatsList/$type/high/$page');
    return List<LowDataItem>.from(
        response.data['data'].map((x) => LowDataItem.fromJson(x)));
  } catch (error) {
    return null;
  }
}
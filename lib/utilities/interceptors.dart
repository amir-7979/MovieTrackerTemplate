import 'package:dio/dio.dart';
import 'package:app04/utilities/http_helper.dart';
import 'package:mutex/mutex.dart';
final m = Mutex();

class GeneralInterceptor implements Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    checkUserConnection();
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers = {"Content-Type": 'application/json; charset=UTF-8'};
    if (options.path.contains("signup") || options.path.contains("login")) {
      options.headers
          .addEntries({"accessToken": '', "refreshToken": ''}.entries);
    } else if (options.path.contains("getToken")) {
      options.headers.addEntries(
          {"accessToken": '', "refreshToken": userClient.refreshToken}.entries);
    } else {
      options.headers.addEntries({
        "authorization": 'Bearer ' + userClient.accessToken,
        "refreshToken": userClient.refreshToken
      }.entries);
    }
    return handler.next(options);
  }

  @override
  void onResponse(
          Response<dynamic> response, ResponseInterceptorHandler handler) =>
      handler.next(response);
}

class GetTokenInterceptor implements Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    checkUserConnection();
    handler.next(err);
  }

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!options.path.contains("signup") &&
        !options.path.contains("login") &&
        !options.path.contains("getToken") &&
        (userClient.accessToken == '' ||
            userClient.accessTokenExpire! -
                    DateTime.now().millisecondsSinceEpoch <
                15000)) {
      try {
        await m.acquire();
        await getToken();
        m.release();
      } catch (e) {
        print(e.toString());
      }
    }
    return handler.next(options);
  }

  @override
  void onResponse(
          Response<dynamic> response, ResponseInterceptorHandler handler) =>
      handler.next(response);
}

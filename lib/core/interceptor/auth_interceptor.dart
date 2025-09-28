import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../routing/routers.dart';



class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required this.secureStorage,
  });

  final FlutterSecureStorage secureStorage;
  final dio = Dio(
    BaseOptions(
      baseUrl: "http://192.168.0.111:8888/api/v1",
      validateStatus: (status) => true,
    ),
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint('Request Ketti $options, $handler');
    var token = await secureStorage.read(key: 'token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    debugPrint('Response keldi: ${response.statusCode}');

    if (response.statusCode == 401) {
      var login = await secureStorage.read(key: 'login');
      var password = await secureStorage.read(key: 'password');
      if (login == null || password == null) {
        await logout();
        return;
      }

      // get new token
      final refreshResponse = await Dio().post(
        'http://192.168.0.111:8888/api/v1/auth/login',
        data: {'login': login, 'password': password},
      );

      if (refreshResponse.statusCode == 200 &&
          refreshResponse.data['accessToken'] != null) {
        final newToken = refreshResponse.data['accessToken'];
        await secureStorage.write(key: 'token', value: newToken);

        // update headers
        response.requestOptions.headers['Authorization'] = 'Bearer $newToken';

        // retry the original request
        final retryResponse = await Dio().fetch(response.requestOptions);

        return handler.resolve(retryResponse);
      } else {
        await logout();
        return;
      }
    }

    return handler.next(response);
  }

  Future<void> logout() async {
    await secureStorage.delete(key: 'token');
    await secureStorage.delete(key: 'login');
    await secureStorage.delete(key: 'password');
    router.go('/login');
    return;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('errooooooooooooooooor: $err, $handler');
    super.onError(err, handler);
  }
}

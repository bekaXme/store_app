import 'dart:developer';

import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // log(
    //   'Request: METHOD: ${options.method} \n PATH ${options.path} \n HEADERS: ${options.headers} \n DATA: ${options.data}',
    // );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // log(
    //   'Response: CODE :${response.statusCode} \n PATH: ${response.requestOptions.path} \n HEADERS: ${response.headers} \n REALURI ${response.realUri} \n DATA: ${response.data}',
    // );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // log(
    //   'Error: CODE: ${err.response?.statusCode} \n PATH: ${err.requestOptions.path}',
    // );
    super.onError(err, handler);
  }
}

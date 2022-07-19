import 'package:dio/dio.dart';

class HttpInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer ...put auth token here';
    return super.onRequest(options, handler);
  }
}

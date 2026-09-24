import 'package:dio/dio.dart';

import 'package:flutter_guidelines/core/logger/logger.dart';

class HttpInterceptor(final Logger _logger) extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer ...put auth token here';

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.logError(err, err.stackTrace);

    return super.onError(err, handler);
  }
}

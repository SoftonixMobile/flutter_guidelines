import 'package:dio/dio.dart';

abstract final class DioFactory() {
  static const Duration _connectTimeout = Duration(seconds: 10);
  static const Duration _sendTimeout = Duration(seconds: 15);
  static const Duration _receiveTimeout = Duration(seconds: 20);

  static Dio create(String baseUrl) => Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: _connectTimeout,
      sendTimeout: _sendTimeout,
      receiveTimeout: _receiveTimeout,
    ),
  );
}

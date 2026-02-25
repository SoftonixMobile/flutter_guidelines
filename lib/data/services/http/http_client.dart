import 'package:data_provider/network.dart';
import 'package:dio/dio.dart' hide Response;
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:fresh_dio/fresh_dio.dart' hide Response;
import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/core/logger/index.dart';
import 'package:flutter_guidelines/data/services/index.dart';
import 'package:flutter_guidelines/domain/models/index.dart';
import 'adapters/index.dart';

class HttpClient extends NetworkBaseClient implements AuthSession {
  late final Dio _dio;
  late final Fresh<String> _fresh;

  HttpClient({
    @ignoreParam Dio? dio,
    @ignoreParam Fresh<String>? fresh,
    @ignoreParam JsonDataParser? jsonParser,
    required Logger logger,
  }) : super(jsonParser ?? JsonDataParser()) {
    _dio =
        dio ??
        Dio(
          BaseOptions(
            baseUrl: DioOptions.baseUrl,
            connectTimeout: DioOptions.connectTimeout,
            receiveTimeout: DioOptions.receiveTimeout,
          ),
        );

    _fresh =
        fresh ??
        Fresh<String>(
          tokenHeader: (token) => {'Authorization': 'Bearer $token'},
          tokenStorage: SecureTokenStorage(),
          refreshToken: (token, client) {
            // throws a RevokeTokenException to trigger a logout
            throw RevokeTokenException();
          },
        );

    _dio.interceptors.addAll([
      _fresh,
      HttpInterceptor(logger),
      RetryInterceptor(
        dio: _dio,
        logPrint: logger.log,
      ),
    ]);
  }

  @override
  Stream<AuthStatus> get authenticationStatus =>
      _fresh.authenticationStatus.map((status) {
        return switch (status) {
          AuthenticationStatus.initial => AuthStatus.initial,
          AuthenticationStatus.unauthenticated => AuthStatus.unauthenticated,
          AuthenticationStatus.authenticated => AuthStatus.authenticated,
        };
      });

  @override
  Future<void> setToken(String authResponse) {
    return _fresh.setToken(authResponse);
  }

  @override
  Future<void> clearToken() {
    return _fresh.clearToken();
  }

  @override
  Future<Response<T>> get<T>(
    String url, {
    DynamicMap? queryParameters,
    NetworkOptions? options,
  }) async {
    final response = await _dio.get(
      url,
      options: RequestOptionsAdapter.fromOptional(options),
      queryParameters: queryParameters,
    );

    return DioResponseAdapter(response.parse<T>(jsonParser));
  }

  @override
  Future<Response<T>> post<T>(
    String url, {
    dynamic data,
    DynamicMap? queryParameters,
    NetworkOptions? options,
  }) async {
    final response = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: RequestOptionsAdapter.fromOptional(options),
    );

    return DioResponseAdapter(response.parse<T>(jsonParser));
  }

  @override
  Future<Response<T>> put<T>(
    String url, {
    dynamic data,
    DynamicMap? queryParameters,
    NetworkOptions? options,
  }) async {
    final response = await _dio.put(
      url,
      data: data,
      queryParameters: queryParameters,
      options: RequestOptionsAdapter.fromOptional(options),
    );

    return DioResponseAdapter(response.parse<T>(jsonParser));
  }

  @override
  Future<Response<T>> patch<T>(
    String url, {
    dynamic data,
    DynamicMap? queryParameters,
    NetworkOptions? options,
  }) async {
    final response = await _dio.patch(
      url,
      data: data,
      queryParameters: queryParameters,
      options: RequestOptionsAdapter.fromOptional(options),
    );

    return DioResponseAdapter(response.parse<T>(jsonParser));
  }

  @override
  Future<Response<T>> delete<T>(
    String url, {
    DynamicMap? queryParameters,
    NetworkOptions? options,
  }) async {
    final response = await _dio.delete(
      url,
      queryParameters: queryParameters,
      options: RequestOptionsAdapter.fromOptional(options),
    );

    return DioResponseAdapter(response.parse<T>(jsonParser));
  }

  @override
  Future<Response> download(
    String url,
    String path, {
    DynamicMap? queryParameters,
    NetworkOptions? options,
  }) async {
    final response = await _dio.download(
      url,
      path,
      queryParameters: queryParameters,
      options: RequestOptionsAdapter.fromOptional(options),
    );

    return DioResponseAdapter(response);
  }
}

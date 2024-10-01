import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_guidelines/models/index.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/blocs/index.dart';
import 'package:flutter_guidelines/models/general_models.dart';
import 'package:flutter_guidelines/services/index.dart';
import 'interceptors/index.dart';
import 'options.dart';
import 'token_storage.dart';
import 'json_data_parser.dart';

@Singleton(scope: 'auth')
class HttpClient {
  late Dio _dio;
  late Fresh<String> _fresh;
  late JsonDataParser _parser;

  HttpClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: DioOptions.baseUrl,
        receiveTimeout: DioOptions.receiveTimeout,
        connectTimeout: DioOptions.connectTimeout,
      ),
    );

    _fresh = Fresh<String>(
      tokenHeader: (token) => {'Authorization': 'Bearer $token'},
      tokenStorage: SecureTokenStorage(),
      refreshToken: (token, client) {
        getIt<AuthBloc>().add(const AuthEvent.signOut());

        throw Exception('Unauthenticated');
      },
    );

    _dio.interceptors.addAll([
      _fresh,
      HttpInterceptor(LoggerService.instance),
      RetryInterceptor(
        dio: _dio,
        logPrint: LoggerService.instance.log,
      ),
    ]);

    _parser = JsonDataParser()..registerType(Post.fromJson);
  }

  Stream<AuthStatus> get authenticationStatus =>
      _fresh.authenticationStatus.map((status) {
        switch (status) {
          case AuthenticationStatus.initial:
            return AuthStatus.initial;
          case AuthenticationStatus.unauthenticated:
            return AuthStatus.unauthenticated;
          case AuthenticationStatus.authenticated:
            return AuthStatus.authenticated;
        }
      });

  Future<void> setToken(String token) {
    return _fresh.setToken(token);
  }

  Future<void> clearToken() {
    return _fresh.clearToken();
  }

  Future<Response<T>> get<T>(
    String url, {
    DynamicMap? queryParameters,
    Options? options,
  }) async {
    final response = await _dio.get(
      url,
      queryParameters: queryParameters,
      options: options,
    );
    return response.convert<T>(_parser);
  }

  Future<Response<T>> post<T>(
    String url, {
    dynamic data,
    DynamicMap? queryParameters,
    Options? options,
  }) async {
    final response = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return response.convert<T>(_parser);
  }

  Future<Response<T>> put<T>(
    String url, {
    dynamic data,
    DynamicMap? queryParameters,
    Options? options,
  }) async {
    final response = await _dio.put(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return response.convert<T>(_parser);
  }

  Future<Response<T>> patch<T>(
    String url, {
    dynamic data,
    DynamicMap? queryParameters,
    Options? options,
  }) async {
    final response = await _dio.patch(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return response.convert<T>(_parser);
  }

  Future<Response<T>> delete<T>(
    String url, {
    DynamicMap? queryParameters,
    Options? options,
  }) async {
    final response = await _dio.delete(
      url,
      queryParameters: queryParameters,
      options: options,
    );
    return response.convert<T>(_parser);
  }

  Future<Response> download(String url, String savePath) {
    return _dio.download(url, savePath);
  }
}

extension on Response {
  Response<T> convert<T>(JsonDataParser parser) => Response(
        data: parser.convert<T>(data),
        requestOptions: requestOptions,
        extra: extra,
        headers: headers,
        isRedirect: isRedirect,
        redirects: redirects,
        statusCode: statusCode,
        statusMessage: statusMessage,
      );
}

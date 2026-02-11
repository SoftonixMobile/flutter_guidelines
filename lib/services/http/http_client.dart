import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/models/general_models.dart';
import 'package:flutter_guidelines/services/index.dart';

@Singleton(scope: 'auth')
class HttpClient {
  late final Dio _dio;
  late final Fresh<String> _fresh;
  final JsonDataParser _parser;

  HttpClient({
    @ignoreParam Dio? dio,
    @ignoreParam Fresh<String>? fresh,
    @ignoreParam JsonDataParser? parser,
    required Logger logger,
  }) : _parser = parser ?? JsonDataParser() {
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

  Stream<AuthStatus> get authenticationStatus =>
      _fresh.authenticationStatus.map((status) {
        return switch (status) {
          AuthenticationStatus.initial => AuthStatus.initial,
          AuthenticationStatus.unauthenticated => AuthStatus.unauthenticated,
          AuthenticationStatus.authenticated => AuthStatus.authenticated,
        };
      });

  Future<void> setToken(String token) {
    return _fresh.setToken(token);
  }

  Future<void> clearToken() {
    return _fresh.clearToken();
  }

  Future<Response<T>> getR<T>(
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

  Future<T> get<T>(
    String url, {
    DynamicMap? queryParameters,
    Options? options,
  }) => getR<T>(
    url,
    queryParameters: queryParameters,
    options: options,
  ).then((r) => r.data!);

  Future<Response<T>> postR<T>(
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

  Future<T> post<T>(
    String url, {
    dynamic data,
    DynamicMap? queryParameters,
    Options? options,
  }) => postR<T>(
    url,
    data: data,
    queryParameters: queryParameters,
    options: options,
  ).then((r) => r.data!);

  Future<Response<T>> putR<T>(
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

  Future<T> put<T>(
    String url, {
    dynamic data,
    DynamicMap? queryParameters,
    Options? options,
  }) => putR<T>(
    url,
    data: data,
    queryParameters: queryParameters,
    options: options,
  ).then((r) => r.data!);

  Future<Response<T>> patchR<T>(
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

  Future<T> patch<T>(
    String url, {
    dynamic data,
    DynamicMap? queryParameters,
    Options? options,
  }) => patchR<T>(
    url,
    data: data,
    queryParameters: queryParameters,
    options: options,
  ).then((r) => r.data!);

  Future<Response<T>> deleteR<T>(
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

  Future<T> delete<T>(
    String url, {
    DynamicMap? queryParameters,
    Options? options,
  }) => deleteR<T>(
    url,
    queryParameters: queryParameters,
    options: options,
  ).then((r) => r.data!);

  Future<Response> download(String url, String savePath) {
    return _dio.download(url, savePath);
  }
}

extension HttpClientX on HttpClient {
  void registerType<T>(JsonConverter<T> converter) {
    _parser.registerType<T>(converter);
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

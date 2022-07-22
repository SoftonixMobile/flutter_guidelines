import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:flutter_guidelines/blocs/index.dart';
import 'package:flutter_guidelines/models/general_models.dart';
import 'package:flutter_guidelines/services/index.dart';
import 'options.dart';
import 'token_storage.dart';

@injectable
class HttpClient {
  late Dio _dio;
  late Fresh<String> _fresh;

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
        getIt<AuthBloc>().signOut();

        throw Exception('Unauthenticated');
      },
      httpClient: _dio,
    );

    _dio.interceptors.addAll([
      _fresh,
      RetryInterceptor(
        dio: _dio,
        logPrint: print,
        retries: 3,
      ),
      PrettyDioLogger(),
    ]);
  }

  Stream<AuthenticationStatus> get authenticationStatus =>
      _fresh.authenticationStatus;

  Future<void> authenticate(
    String userName,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 2));

    return _fresh.setToken('token');
  }

  Future<void> unauthenticate() {
    return _fresh.clearToken();
  }

  Future<Response<T>> get<T>(String url,
      {DynamicMap? queryParameters, Options? options}) {
    return _dio.get<T>(url, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> post<T>(String url,
      {data, DynamicMap? queryParameters, Options? options}) {
    return _dio.post<T>(url,
        data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> put<T>(String url,
      {data, DynamicMap? queryParameters, Options? options}) {
    return _dio.put<T>(url,
        data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> patch<T>(String url,
      {data, DynamicMap? queryParameters, Options? options}) {
    return _dio.patch<T>(url,
        data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> delete<T>(String url,
      {DynamicMap? queryParameters, Options? options}) {
    return _dio.delete<T>(url,
        queryParameters: queryParameters, options: options);
  }

  Future<Response> download(String url, String savePath) {
    return _dio.download(url, savePath);
  }
}

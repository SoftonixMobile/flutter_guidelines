import 'models/index.dart';

abstract class NetworkBaseClient {
  Stream<AuthStatus> get authStatusStream;

  Future<void> setToken(String token);
  Future<void> clearToken();

  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    NetworkOptions? options,
  });

  Future<Response<T>> post<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    NetworkOptions? options,
  });

  Future<Response<T>> put<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    NetworkOptions? options,
  });

  Future<Response<T>> patch<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    NetworkOptions? options,
  });

  Future<Response<T>> delete<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    NetworkOptions? options,
  });

  Future<Response<T>> download<T>(
    String url,
    String path, {
    Map<String, dynamic>? queryParameters,
    NetworkOptions? options,
  });
}

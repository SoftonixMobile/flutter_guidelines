import 'models/options.dart';
import 'models/response.dart';

abstract class NetworkBaseClient {
  Future<void> setToken<AuthResponse>(AuthResponse authResponse);
  Future<void> clearToken();

  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? query,
    NetworkOptions? options,
  });

  Future<Response<T>> post<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? query,
    NetworkOptions? options,
  });

  Future<Response<T>> put<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? query,
    NetworkOptions? options,
  });

  Future<Response<T>> patch<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? query,
    NetworkOptions? options,
  });

  Future<Response<T>> delete<T>(
    String url, {
    Map<String, dynamic>? query,
    NetworkOptions? options,
  });

  Future<Response<T>> download<T>(
    String url,
    String path, {
    Map<String, dynamic>? query,
    NetworkOptions? options,
  });
}

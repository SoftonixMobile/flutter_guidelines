import 'models/index.dart';

abstract class NetworkBaseClient {
  Stream<AuthStatus> get authStatusStream;

  void registerType<T>(T Function(Map<String, dynamic>) fromJson);
  Future<void> setToken(String token);
  Future<void> clearToken();

  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    NetworkOptions? options,
  });

  Future<T> getData<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    NetworkOptions? options,
  }) => get<T>(
    url,
    queryParameters: queryParameters,
    options: options,
  ).then((response) => response.data as T);

  Future<Response<T>> post<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    NetworkOptions? options,
  });

  Future<T> postData<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    NetworkOptions? options,
  }) => post<T>(
    url,
    data: data,
    queryParameters: queryParameters,
    options: options,
  ).then((response) => response.data as T);

  Future<Response<T>> put<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    NetworkOptions? options,
  });

  Future<T> putData<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    NetworkOptions? options,
  }) => put<T>(
    url,
    data: data,
    queryParameters: queryParameters,
    options: options,
  ).then((response) => response.data as T);

  Future<Response<T>> patch<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    NetworkOptions? options,
  });

  Future<T> patchData<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    NetworkOptions? options,
  }) => patch<T>(
    url,
    data: data,
    queryParameters: queryParameters,
    options: options,
  ).then((response) => response.data as T);

  Future<Response<T>> delete<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    NetworkOptions? options,
  });

  Future<T> deleteData<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    NetworkOptions? options,
  }) => delete<T>(
    url,
    queryParameters: queryParameters,
    options: options,
  ).then((response) => response.data as T);

  Future<Response<T>> download<T>(
    String url,
    String path, {
    Map<String, dynamic>? queryParameters,
    NetworkOptions? options,
  });
}

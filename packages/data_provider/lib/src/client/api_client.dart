import 'package:data_provider/src/client/parser/json_parser.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/auth/models.dart';
import 'models/index.dart';

abstract class ApiClient(@protected final JsonParser jsonParser) {
  Stream<AuthStatus> get onSessionStatusChanged;

  Future<void> startSession(TokenResponse token);

  Future<void> clearSession();

  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    RequestOptions? options,
  });

  Future<T> getData<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    RequestOptions? options,
  }) => get<T>(
    url,
    queryParameters: queryParameters,
    options: options,
  ).then((response) => response.data as T);

  Future<Response<T>> post<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    RequestOptions? options,
  });

  Future<T> postData<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    RequestOptions? options,
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
    RequestOptions? options,
  });

  Future<T> putData<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    RequestOptions? options,
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
    RequestOptions? options,
  });

  Future<T> patchData<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    RequestOptions? options,
  }) => patch<T>(
    url,
    data: data,
    queryParameters: queryParameters,
    options: options,
  ).then((response) => response.data as T);

  Future<Response<T>> delete<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    RequestOptions? options,
  });

  Future<T> deleteData<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    RequestOptions? options,
  }) => delete<T>(
    url,
    queryParameters: queryParameters,
    options: options,
  ).then((response) => response.data as T);

  Future<Response> download(
    String url,
    String path, {
    Map<String, dynamic>? queryParameters,
    RequestOptions? options,
  });

  void registerType<T>(T Function(Map<String, dynamic>) fromJson) {
    jsonParser.registerType(fromJson);
  }
}

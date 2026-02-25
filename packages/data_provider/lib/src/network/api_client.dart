import 'package:data_provider/src/network/json_parser.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'models/index.dart';

abstract class ApiClient {
  @protected
  final JsonParser jsonParser;

  ApiClient(this.jsonParser);

  void registerType<T>(T Function(Map<String, dynamic>) fromJson) {
    jsonParser.registerType(fromJson);
  }

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

  Future<Response> download(
    String url,
    String path, {
    Map<String, dynamic>? queryParameters,
    NetworkOptions? options,
  });
}

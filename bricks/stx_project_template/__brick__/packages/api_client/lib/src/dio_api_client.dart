import 'package:dio/dio.dart' as dio;

import 'api_client.dart';
import 'dio_auth_session.dart';
import 'exceptions/api_exception.dart';
import 'exceptions/api_exception_mapper.dart';
import 'models/index.dart';
import 'parser/json_data_parser.dart';
import 'parser/json_parser.dart';
import 'utils/dio_factory.dart';

class DioApiClient({
  required String baseUrl,
  DioAuthSession? authSession,
  JsonParser? jsonParser,
  dio.Dio? httpClient,
}) extends ApiClient {
  final dio.Dio _dio = httpClient ?? DioFactory.create(baseUrl);

  this : super(jsonParser ?? JsonDataParser()) {
    if (authSession != null) _dio.interceptors.add(authSession.interceptor);
  }

  @override
  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    RequestOptions? options,
  }) async {
    final response = await _guard(
      () => _dio.get(
        url,
        queryParameters: queryParameters,
        options: _toDioOptions(options),
      ),
    );

    return _toResponse(response, jsonParser.parse<T>(response.data));
  }

  @override
  Future<Response<T>> post<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    RequestOptions? options,
  }) async {
    final response = await _guard(
      () => _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: _toDioOptions(options),
      ),
    );

    return _toResponse(response, jsonParser.parse<T>(response.data));
  }

  @override
  Future<Response<T>> put<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    RequestOptions? options,
  }) async {
    final response = await _guard(
      () => _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: _toDioOptions(options),
      ),
    );

    return _toResponse(response, jsonParser.parse<T>(response.data));
  }

  @override
  Future<Response<T>> patch<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    RequestOptions? options,
  }) async {
    final response = await _guard(
      () => _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: _toDioOptions(options),
      ),
    );

    return _toResponse(response, jsonParser.parse<T>(response.data));
  }

  @override
  Future<Response<T>> delete<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    RequestOptions? options,
  }) async {
    final response = await _guard(
      () => _dio.delete(
        url,
        queryParameters: queryParameters,
        options: _toDioOptions(options),
      ),
    );

    return _toResponse(response, jsonParser.parse<T>(response.data));
  }

  @override
  Future<Response> download(
    String url,
    String path, {
    Map<String, dynamic>? queryParameters,
    RequestOptions? options,
  }) async {
    final response = await _guard(
      () => _dio.download(
        url,
        path,
        queryParameters: queryParameters,
        options: _toDioOptions(options),
      ),
    );

    return _toResponse(response, response.data);
  }

  /// Rethrows a [dio.DioException] as an [ApiException].
  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on dio.DioException catch (e) {
      Error.throwWithStackTrace(
        ApiExceptionMapper.fromDioException(e),
        e.stackTrace,
      );
    }
  }

  Response<T> _toResponse<T>(dio.Response response, T? data) {
    return Response(
      data: data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      headers: response.headers.map,
    );
  }

  dio.Options? _toDioOptions(RequestOptions? options) {
    if (options == null) return null;

    return dio.Options(
      method: options.method,
      sendTimeout: options.sendTimeout,
      receiveTimeout: options.receiveTimeout,
      extra: options.extra,
      headers: options.headers,
      preserveHeaderCase: options.preserveHeaderCase,
      contentType: options.contentType,
      receiveDataWhenStatusError: options.receiveDataWhenStatusError,
      followRedirects: options.followRedirects,
      maxRedirects: options.maxRedirects,
    );
  }
}

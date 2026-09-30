import 'package:dio/dio.dart' as dio;
import 'package:fresh_dio/fresh_dio.dart'
    show Fresh, AuthenticationStatus, RevokeTokenException;
import 'package:storage/storage.dart';

import '../models/auth/models.dart';
import '../utils/token_helper.dart';
import 'api_client.dart';
import 'exceptions/api_exception.dart';
import 'exceptions/api_exception_mapper.dart';
import 'models/index.dart';
import 'parser/json_data_parser.dart';
import 'parser/json_parser.dart';
import 'storage/secure_token_storage.dart';

class DioApiClient({
  required String baseUrl,
  required Storage storage,
  JsonParser? jsonParser,
  dio.Dio? httpClient,
  dio.Dio? bareClient,
}) extends ApiClient {
  final Fresh<TokenResponse> _fresh = Fresh<TokenResponse>(
    tokenStorage: SecureTokenStorage(storage),
    tokenHeader: (token) => {'Authorization': 'Bearer ${token.accessToken}'},
    shouldRefreshBeforeRequest: (_, token) =>
        token != null && TokenHelper.isExpired(token),
    refreshToken: (token, client) {
      // throws a RevokeTokenException to trigger a logout
      throw RevokeTokenException();
    },
    // client without auth interceptors, used to refresh the token
    httpClient: bareClient ?? _createClient(baseUrl),
  );

  final dio.Dio _dio = httpClient ?? _createClient(baseUrl);

  this : super(jsonParser ?? JsonDataParser()) {
    _dio.interceptors.add(_fresh);
  }

  @override
  Stream<AuthStatus> get onSessionStatusChanged =>
      _fresh.authenticationStatus.map(_mapAuthStatus);

  @override
  Future<void> startSession(TokenResponse token) => _fresh.setToken(token);

  @override
  Future<void> clearSession() => _fresh.clearToken();

  static AuthStatus _mapAuthStatus(AuthenticationStatus status) {
    return switch (status) {
      .initial => .initial,
      .authenticated => .authenticated,
      .unauthenticated => .unauthenticated,
    };
  }

  static dio.Dio _createClient(String baseUrl) => dio.Dio(
    dio.BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 100),
    ),
  );

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

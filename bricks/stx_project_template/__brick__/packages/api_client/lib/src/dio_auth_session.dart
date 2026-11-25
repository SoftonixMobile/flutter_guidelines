import 'package:dio/dio.dart' as dio;
import 'package:fresh_dio/fresh_dio.dart'
    show AuthenticationStatus, Fresh, RevokeTokenException;
import 'package:meta/meta.dart';
import 'package:storage/storage.dart';

import 'api_client.dart';
import 'auth_session.dart';
import 'dio_api_client.dart';
import 'exceptions/api_exception.dart';
import 'models/index.dart';
import 'storage/secure_token_storage.dart';
import 'utils/dio_factory.dart';
import 'utils/token_helper.dart';

typedef TokenRefresher = Future<AuthToken> Function(
  AuthToken token,
  ApiClient client,
);

class DioAuthSession({
  required String baseUrl,
  required Storage storage,
  TokenRefresher? tokenRefresher,
  dio.Dio? httpClient,
}) implements AuthSession {
  final Fresh<AuthToken> _fresh = Fresh<AuthToken>(
    tokenStorage: SecureTokenStorage(storage),
    tokenHeader: (token) => {'Authorization': 'Bearer ${token.accessToken}'},
    shouldRefreshBeforeRequest: (_, token) =>
        token != null && TokenHelper.isExpired(token),
    // requests to other origins skip auth
    isTokenRequired: _isSameOrigin,
    refreshToken: (token, client) {
      // Fresh changes this client's base URL when it retries a request
      client.options.baseUrl = baseUrl;

      return _refresh(
        token,
        tokenRefresher,
        DioApiClient(baseUrl: baseUrl, httpClient: client),
      );
    },
    // client without auth interceptors, used to refresh the token
    httpClient: httpClient ?? DioFactory.create(baseUrl),
  );

  AuthStatus _status = .initial;

  this {
    onStatusChanged.listen((status) => _status = status);
  }

  @override
  AuthStatus get status => _status;

  @override
  Stream<AuthStatus> get onStatusChanged =>
      _fresh.authenticationStatus.map(_mapStatus);

  @override
  Future<void> start(AuthToken token) async {
    await _fresh.setToken(token);

    _status = .authenticated;
  }

  @override
  Future<void> clear() async {
    await _fresh.clearToken();

    _status = .unauthenticated;
  }

  @internal
  dio.Interceptor get interceptor => _fresh;

  /// Whether a request goes to the origin (scheme, host and port) of the base
  /// URL of the client that sends it.
  static bool _isSameOrigin(dio.RequestOptions options) {
    final baseUri = Uri.tryParse(options.baseUrl);
    final uri = options.uri;

    return baseUri != null &&
        uri.scheme == baseUri.scheme &&
        uri.host == baseUri.host &&
        uri.port == baseUri.port;
  }

  static Future<AuthToken> _refresh(
    AuthToken? token,
    TokenRefresher? tokenRefresher,
    ApiClient client,
  ) async {
    // throws a RevokeTokenException to trigger a logout
    if (token == null || tokenRefresher == null) throw RevokeTokenException();

    try {
      return await tokenRefresher(token, client);
    } catch (e, stackTrace) {
      if (e is ApiException && _isRejected(e)) throw RevokeTokenException();

      // Fresh fails the request and keeps the session only for a DioException;
      // on any other error it returns the 401 response as a success
      throw dio.DioException(
        requestOptions: dio.RequestOptions(),
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  static bool _isRejected(ApiException e) {
    return switch (e.type) {
      .badRequest ||
      .unauthorized ||
      .forbidden ||
      .notFound ||
      .clientError => true,
      _ => false,
    };
  }

  static AuthStatus _mapStatus(AuthenticationStatus status) {
    return switch (status) {
      .initial => .initial,
      .authenticated => .authenticated,
      .unauthenticated => .unauthenticated,
    };
  }
}

import 'package:dio/dio.dart' as dio;
import 'package:fresh_dio/fresh_dio.dart'
    show AuthenticationStatus, Fresh, RevokeTokenException;
import 'package:meta/meta.dart';
import 'package:storage/storage.dart';

import 'auth_session.dart';
import 'models/index.dart';
import 'storage/secure_token_storage.dart';
import 'utils/token_helper.dart';

class DioAuthSession({
  required Storage storage,
  dio.Dio? bareClient,
}) implements AuthSession {
  final Fresh<AuthToken> _fresh = Fresh<AuthToken>(
    tokenStorage: SecureTokenStorage(storage),
    tokenHeader: (token) => {'Authorization': 'Bearer ${token.accessToken}'},
    shouldRefreshBeforeRequest: (_, token) =>
        token != null && TokenHelper.isExpired(token),
    refreshToken: (token, client) {
      // throws a RevokeTokenException to trigger a logout
      throw RevokeTokenException();
    },
    // client without auth interceptors, used to refresh the token
    httpClient: bareClient,
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

  static AuthStatus _mapStatus(AuthenticationStatus status) {
    return switch (status) {
      .initial => .initial,
      .authenticated => .authenticated,
      .unauthenticated => .unauthenticated,
    };
  }
}

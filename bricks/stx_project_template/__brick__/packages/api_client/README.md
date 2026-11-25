# api_client

Generic HTTP client on top of Dio. Knows nothing about a specific backend, so it can be reused across projects.

- `ApiClient`: abstract client with `get`/`post`/`put`/`patch`/`delete`/`download` and `*Data` shortcuts that return the parsed body.
- `DioApiClient`: the implementation. Pass it an `authSession` to authorize its requests; without one they are sent unauthenticated.
- `AuthSession`: abstract session with `start`, `clear`, `status` and `onStatusChanged`.
- `DioAuthSession`: the implementation. Keeps the `AuthToken` in a `Storage` and sends `Authorization: Bearer <accessToken>` through `fresh_dio`. When the JWT `exp` claim has passed (30 s leeway) or the server returns 401, it calls the `tokenRefresher`; without one it ends the session. One session can authorize several clients. The token goes only to the origin (scheme, host and port) of the client's base URL: a request to any other origin is sent without it, and a 401 from there neither refreshes the token nor ends the session.
- `AuthToken` / `AuthStatus`: session credentials and state.

- `ApiException` / `ApiExceptionType`: every `DioException` is rethrown as an `ApiException`. One that carries an `ApiException` rethrows it as is; one with a response is typed by its status code. The 401 that ends the session is rethrown as `unauthorized` with its status code.
- `JsonParser` / `JsonDataParser`: register `fromJson` converters with `registerType`, then `get<Model>` and `get<List<Model>>` return parsed data.
- `RequestOptions` / `Response`: Dio-independent request options (with `longSend`/`longReceive` timeout presets) and response.

```dart
final authSession = DioAuthSession(
  baseUrl: baseUrl,
  storage: storage,
  tokenRefresher: (token, client) async {
    final json = await client.postData<Map<String, dynamic>>(
      '/auth/refresh',
      data: {'refreshToken': token.refreshToken},
    );

    return AuthToken.fromJson(json);
  },
);
final apiClient = DioApiClient(baseUrl: baseUrl, authSession: authSession);
```

`tokenRefresher` gets the current token and a client that sends requests to `baseUrl` without the session. Its result decides what happens next:

- It returns a token: the token is stored and the request is sent with it (or retried, after a 401).
- It throws an `ApiException` of type `badRequest`, `unauthorized`, `forbidden`, `notFound` or `clientError`: the session ends. A request refreshed before sending goes out without a token; one that got a 401 fails with `unauthorized`.
- It throws anything else: the request fails and the session is kept. An `ApiException` is rethrown as is; any other error becomes an `unknown` `ApiException` with it in `error`.

Backend-specific services and models belong in a package that depends on this one (see `app_api`).

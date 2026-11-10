# api_client

Generic HTTP client on top of Dio. Knows nothing about a specific backend, so it can be reused across projects.

- `ApiClient`: abstract client with `get`/`post`/`put`/`patch`/`delete`/`download` and `*Data` shortcuts that return the parsed body.
- `DioApiClient`: the implementation. Pass it an `authSession` to authorize its requests; without one they are sent unauthenticated.
- `AuthSession`: abstract session with `start`, `clear`, `status` and `onStatusChanged`.
- `DioAuthSession`: the implementation. Keeps the `AuthToken` in a `Storage` and sends `Authorization: Bearer <accessToken>` through `fresh_dio`. It ends the session when the JWT `exp` claim has passed (30 s leeway) or the server returns 401. One session can authorize several clients.
- `AuthToken` / `AuthStatus`: session credentials and state.

- `ApiException` / `ApiExceptionType`: every `DioException` is rethrown as an `ApiException`.
- `JsonParser` / `JsonDataParser`: register `fromJson` converters with `registerType`, then `get<Model>` and `get<List<Model>>` return parsed data.
- `RequestOptions` / `Response`: Dio-independent request options (with `longSend`/`longReceive` timeout presets) and response.

```dart
final authSession = DioAuthSession(storage: storage);
final apiClient = DioApiClient(baseUrl: baseUrl, authSession: authSession);
```

Backend-specific services and models belong in a package that depends on this one (see `app_api`).

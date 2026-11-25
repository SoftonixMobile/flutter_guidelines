# app_api

The app's backend API, built on `api_client`.

- `services.dart`: endpoint services (`AuthService`, `UserService`, `PostsService`, `ChatsService`, `SessionService`) and `AuthTokenRefresher`. Endpoint services take an `ApiClient` and register their response types with `_client.registerType(Model.fromJson)` in their constructors. `SessionService` takes an `AuthSession` instead.
- `models.dart`: wire models (`TokenResponse`, `UserProfileDto`, `PostDto`, `ChatDto`), plus `AuthStatus` re-exported from `api_client`. Names follow `docs/model_naming.md` in the app repository.
- `injector.dart`: `AppApiPackageModule`, an injectable micro-package module that registers the services. Register an `ApiClient` and an `AuthSession` in get_it before calling `init`.

`TokenResponse.toAuthToken()` maps the backend's `TokenResponse` to `api_client`'s `AuthToken`; `SessionService.startSession` uses it. `AuthTokenRefresher.refresh` is the `tokenRefresher` for `DioAuthSession`. For now it is a stub that returns a fixed token, like `AuthService.signIn`; the real call goes to the refresh endpoint through the `client` it is given and maps the `TokenResponse` with `toAuthToken()`.

After changing models or services, regenerate code from this directory:

```sh
dart run build_runner build --delete-conflicting-outputs
```

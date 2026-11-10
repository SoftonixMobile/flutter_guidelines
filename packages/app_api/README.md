# app_api

The app's backend API, built on `api_client`.

- `services.dart`: endpoint services (`AuthService`, `UserService`, `PostsService`, `ChatsService`, `SessionService`). Endpoint services take an `ApiClient` and register their response types with `_client.registerType(Model.fromJson)` in their constructors. `SessionService` takes an `AuthSession` instead.
- `models.dart`: response models (`TokenResponse`, `UserProfile`, `Post`, `Chat`), plus `AuthStatus` re-exported from `api_client`.
- `injector.dart`: `AppApiPackageModule`, an injectable micro-package module that registers the services. Register an `ApiClient` and an `AuthSession` in get_it before calling `init`.

`SessionService.startSession` maps the backend's `TokenResponse` to `api_client`'s `AuthToken`.

After changing models or services, regenerate code from this directory:

```sh
dart run build_runner build --delete-conflicting-outputs
```

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Flutter mobile application template following Clean Architecture with BLoC pattern. Monorepo structure with three local packages under `packages/`. Uses extensive code generation (Freezed, JSON serializable, auto_route, injectable, flutter_gen).

## Toolchain

- Flutter pinned via FVM in `.fvmrc` (currently 3.47.7). Prefer `fvm flutter ...` / `fvm dart ...` locally.
- Dart SDK `^3.13.0`, Flutter `^3.47.0`. Code uses Dart 3.13 **primary constructors** and **dot shorthands** (see Code Style).

## Common Commands

```bash
make get            # dart pub get
make build          # Run build_runner (generates *.g.dart, *.freezed.dart, *.config.dart, *.gr.dart)
make watch          # Run build_runner in watch mode
make lang           # Generate localization files in lib/presentation/localization/
make lint           # dart analyze --fatal-infos .
make sort           # Sort imports via tidy_imports
make fix            # dart fix --apply
make format         # dart format + make lang
make refactor       # Full pipeline: build → lang → fix → sort → lint
make splash         # Generate splash screen via flutter_native_splash
make icon           # Generate app icons via flutter_launcher_icons
make setup_hooks    # Install git hooks (pre-commit: tidy_imports --exit-if-changed + analyze)
```

After modifying models, BLoCs, routes, or DI registrations, always run `make build` to regenerate code.

**Running tests:**
```bash
flutter test                                          # All tests
flutter test test/unit_test/blocs/session/session_bloc_test.dart  # Single file
flutter test --name "Session bloc"                    # By name pattern
flutter test --coverage                               # With coverage
```

## Running the app

Config keys (`ENV`, `APP_API_URL`) are passed as dart-defines from `.env.dev` / `.env.prod`. These are git-ignored (`.env*`); copy `.env.example` (committed, keys only) and fill in real values locally. `AppConfig.fromEnvironment()` reads and validates them at startup: a missing or empty key, an unknown `ENV` or a non-absolute `APP_API_URL` throws a `ConfigException` before `runApp`, so running without `--dart-define-from-file` fails immediately with a message saying what to fix:

```bash
flutter run --dart-define-from-file=.env.dev
flutter run --dart-define-from-file=.env.prod --release
```

VS Code `launch.json` has `dev debug`, `dev release`, `prod debug`, `prod release` preconfigured.

## Config

`AppConfig` (`lib/core/config/app_config.dart`) is an immutable value object with `environment` (`AppEnvironment.dev` / `.prod`), `apiUrl` (`Uri`) and `enableConsoleLogs` (= debug build). `AppConfig.parse(Map<String, String>, {isDebugBuild})` is the pure, unit-testable parser. The config is created first in `initializeApp()`, registered in get_it by `configureAppDependencies(config:, logger:)`, and provided to widgets by a `RepositoryProvider` in `_AppStateWrapper` (`context.config`, via `AppConfigX` in `lib/presentation/utils/`). In tests, construct one with `testConfig(...)` (`test/helpers/test_app_config.dart`) instead of mocking it.

Rules:
- `String.fromEnvironment` appears only in `AppConfig.fromEnvironment()`.
- No static config access: inject `AppConfig`.
- `packages/*` never import `AppConfig`; pass primitives.
- `lib/domain` never imports `AppConfig`.
- Dart-defines are baked into the binary in plain text. Never put secrets in `.env.*`.
- A new key goes into `.env.example`, `.env.dev`, `.env.prod`, `AppConfig.parse` (with validation), `testConfig` and `app_config_test.dart`.

## Architecture

**Clean Architecture layers:**
- `lib/core/` — Config (`AppConfig` value object + `AppEnvironment` enum, built once from dart-defines; see Config), constants, base exceptions (`AppException`, `ConfigException`), initialization, DI (get_it + injectable), abstract `Logger`, utils
- `lib/domain/` — Domain models (`UserData`, type aliases, data models re-exports incl. `AuthStatus`), repository re-exports
- `lib/data/` — Repositories (extend `stx_repository` base), logger implementations
- `lib/presentation/` — App entry, BLoCs, screens, router (auto_route), localization, theme/design system, reusable widgets

**Dependency injection has two phases (`lib/core/injector/injector.dart`):**
1. `configureAppDependencies()` — core singletons (`AppConfig`, AppRouter, Logger, `AuthSession` with `baseUrl: config.apiUrl` and `tokenRefresher: AuthTokenRefresher.refresh`, `ApiClient` with the same `baseUrl` and that session), all `app_api` services (`AppApiPackageModule`), and `scope: 'app'` dependencies (AuthRepository, SessionBloc, LoginFormBloc).
2. `configureUserDependencies()` — pushed as the `'user'` scope in `MainScopeProvider.initState` (wraps `MainWrapperScreen`); registers `UserData` and user-scoped repositories/BLoCs.

User-scoped dependencies are torn down when `MainScopeProvider.dispose()` calls `getIt.dropScope('user')`.

**App initialization sequence** (`lib/core/initialization/app_initialization.dart`):
Config (`AppConfig.fromEnvironment()`, fails fast) → Splash → Localization → Logger (MultiLogger) → Crashlytics → BlocObserver → `configureAppDependencies()` → Validators

**Navigation:** auto_route with declarative routing at root. `RootScreen` switches between `LoginRoute` and `MainRouter` based on `SessionBloc` state. `MainWrapperScreen` (annotated `@RoutePage(name: 'MainRouter')`) manages user scope lifecycle. `MainScreen` uses `AutoTabsScaffold` with 3 bottom tabs (Dashboard, Messages, Settings) and an `AppDrawer` as endDrawer.

**Route tree:**
```
/ (RootRoute — declarative: Login or MainRouter)
  LoginRoute
  MainRouter (MainWrapperScreen — pushes user DI scope)
    MainRoute (MainScreen — tabbed scaffold)
      DashboardRoute
      MessagesRoute (CustomTabsRouter: Chats + Posts tabs)
        ChatsRoute
        PostsRoute
      SettingsRoute
    PostFormRoute
    ChatDetailsRoute
```

## Local Packages

- `packages/api_client/` — Generic HTTP client, no knowledge of a specific backend and no DI or codegen: abstract `ApiClient` (requests only) + `DioApiClient`, abstract `AuthSession` (token and auth status) + `DioAuthSession` with Fresh auth, `SecureTokenStorage` and an optional `tokenRefresher`, `AuthToken` (session credentials) and `AuthStatus`, `ApiException` + mapper, `JsonParser`/`JsonDataParser`, `RequestOptions`, `Response`. Single entry point `package:api_client/api_client.dart`.
- `packages/app_api/` — The app's backend API on top of `api_client`: response models (UserProfile, Chat, Post, TokenResponse; re-exports `AuthStatus`) and endpoint services (AuthService, UserService, PostsService, ChatsService, SessionService). Has its own injectable micro-package module (`AppApiPackageModule`). Endpoint services take an `ApiClient`; only `SessionService` takes the `AuthSession`. `AuthTokenRefresher.refresh` is the token refresh call (for now a stub that returns a fixed token, like `AuthService.signIn`): it is not registered in DI and must send its request through the client `DioAuthSession` passes to it. Services register their JSON types via `_client.registerType(Model.fromJson)` in constructors. Backend-specific code goes here, never in `api_client`.
- `packages/stx_repository/` — Base repository abstraction with mixins: `SyncLoadRepositoryMixin`, `StreamRepositoryMixin`, `TTLRefreshRepositoryMixin`, `DisposableRepositoryMixin`
- `packages/customizable_cupertino_dialog/` — Custom iOS dialog widget
- `packages/storage/` — Key-value `Storage` interface (`storage`) with `SecureStorage` (`secure_storage`, flutter_secure_storage) and `PersistentStorage` (`persistent_storage`, shared_preferences) implementations

## Code Generation Conventions

- Models use `@freezed` with `@JsonSerializable` — define in `.dart`, generated code in `.freezed.dart` and `.g.dart`
- BLoC states/events use `@freezed` sealed unions
- Routes use `@AutoRouterConfig` and `@RoutePage()` annotations — generated in `router.gr.dart`
- DI uses `@injectable`/`@singleton`/`@lazySingleton` annotations with optional `scope:` parameter — generated in `injector.config.dart`
- Assets/colors/fonts generated by flutter_gen into `lib/presentation/theme/`
- `build.yaml` restricts each generator to file-name patterns (e.g. freezed: `lib/data/models/**`, `lib/domain/models/**`, `lib/presentation/**_bloc.dart|_event.dart|_cubit.dart`; injectable: `lib/data/repositories/**`, `lib/data/services/**`, `lib/presentation/**_bloc.dart|_cubit.dart`; routes: `lib/presentation/**_screen.dart`). Name files accordingly or codegen won't pick them up.
- `packages/app_api` has its own build: run `make build_data` (build_runner inside that package) after changing its models/services. `packages/api_client` has no codegen.

## Repository Patterns

Repositories extend `RepositoryBase<T>` (single value) or `ListRepositoryBase<T>` (collection) from `stx_repository`. The `load()` method handles caching — it skips the fetch if `isDataLoaded` is true unless `refresh: true` is passed.

**Common mixin combinations for list repositories:**
```dart
@lazySingleton
class PostsRepository extends ListRepositoryBase<Post>
    with DisposableRepositoryMixin, StreamRepositoryMixin {
  @override
  bool equals(Post a, Post b) => a.id == b.id;

  @override
  @disposeMethod
  Future<void> close() => super.close();
}
```

`UserRepository.emit()` overrides the base to keep the `UserData` singleton in sync. App-scoped repositories use `@LazySingleton(scope: 'app')`.

## BLoC Patterns

**Standard list screen** uses `NetworkListBloc<T, S>` from `stx_bloc_base`:
```dart
typedef PostsState = NetworkListState<Post>;

@injectable
class PostsBloc(final PostsRepository _postsRepository)
    extends NetworkListBloc<Post, PostsState> {
  this : super(const NetworkListState(data: []));

  @override
  FutureOr<List<Post>> onLazyLoad() => _postsRepository.getPosts();

  @override
  Future<List<Post>> onLoadAsync() async =>
      await _postsRepository.getPosts(refresh: true);
}
```

**Single-value screen** uses `NetworkBloc<T, S>` — e.g., `UserBloc` (`@singleton`) extends `NetworkBloc<UserProfile, UserState>`.

**Form screen** uses `FormBloc<SuccessType, ErrorType>` from `stx_flutter_form_bloc` with `TextFieldBloc` fields. Field validators live in `lib/presentation/utils/field_validators.dart`. Form BLoCs support `@factoryParam` for edit mode — e.g., `PostFormBloc(@factoryParam Post? initial)` injected with `getIt<PostFormBloc>(param1: post)`.

**Auth/complex state machines** use custom `@freezed` sealed unions:
```dart
@freezed
sealed class SessionState with _$SessionState {
  const factory({@Default(AuthStatus.initial) AuthStatus authStatus}) = _SessionState;
  factory authenticated() => const SessionState(authStatus: .authenticated);
}
```

BLoC instances are `@injectable` (factory — new instance per injection). Repositories are `@lazySingleton`. `UserBloc` is `@singleton` (shared across user scope).

## Screen / Route Pattern

Screens annotated with `@RoutePage()` implement `AutoRouteWrapper` to inject their BLoC:
```dart
@RoutePage()
class PostsScreen extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PostsBloc>()..lazyLoad(),
      child: this,
    );
  }
}
```

After adding a new `@RoutePage()` screen, register it in `lib/presentation/router/router.dart` and run `make build`.

## Theme / Design System

**Two-layer architecture in `lib/presentation/theme/`:**

1. **Raw palette** — `AppColors` (static const colors: primary, success, danger, grey, surfaces, text tokens for light/dark) and `AppTypography` (static TextStyle factories: displayLarge/Small, titleLarge/Small, bodyLarge/Small, captionLarge/Small)
2. **ThemeExtensions** — `AppColorsTheme extends ThemeExtension<AppColorsTheme>` with `light()`/`dark()` factories; `AppTypographyTheme extends ThemeExtension<AppTypographyTheme>` with `fromFontFamily()` factory

**Access pattern:** `context.theme.colorsTheme.primary`, `context.theme.typographyTheme.bodySmall`

**Extensions** (`lib/presentation/theme/extensions.dart`): `BuildContextX.theme`, `ThemeDataX.colorsTheme`/`.typographyTheme`, `TextStyleX` chainable modifiers (`.poppins`, `.w300`–`.w900`, `.f10`–`.f64`, `.l20`–`.l64`)

`AppTheme.lightTheme()` / `.darkTheme()` build `ThemeData` with both extensions. Font is Poppins.

## Exception Handling

**Exception hierarchy:**
- `AppException` (`lib/core/exceptions/`) — base exception with `String? message`
- `ConfigException extends AppException` (`lib/core/exceptions/`) — thrown by `AppConfig.parse` on missing or invalid config
- `ApiException` (`packages/api_client`) — thrown by `ApiClient`; has `ApiExceptionType` enum (noConnection, timeout, cancelled, badCertificate, badRequest, unauthorized, forbidden, notFound, tooManyRequests, clientError, serviceUnavailable, serverError, unknown), `int? statusCode` and `message` (read from the response body's `message`/`error` when present)

**Flow:** `DioException` → `DioApiClient._guard()` → `ApiExceptionMapper.fromDioException()` (returns an `ApiException` carried in `DioException.error` as is; types any `DioException` with a response by its status code) → `ApiException` → BLoC `addError(e, stackTrace)` → `SimpleBlocObserver.onError()` → `logger.logError()`

**Session:** `AuthRepository` goes through `SessionService` (`app_api`), which maps the backend's `TokenResponse` to `api_client`'s `AuthToken`, calls `AuthSession.start(token)` / `clear()` and exposes `AuthSession.onStatusChanged`. `DioAuthSession` is passed to `DioApiClient(authSession:)`; before each request it checks the JWT `exp` claim (`TokenHelper.isExpired`, 30 s leeway); an expired token or a 401 calls its `tokenRefresher` (`AuthTokenRefresher.refresh` in `app_api`, sent through a client without the session). A returned token is stored and the request is sent or retried with it. A rejected refresh (`ApiException` of type `badRequest`, `unauthorized`, `forbidden`, `notFound` or `clientError`) or a missing refresher throws `RevokeTokenException` → auth status emits `unauthenticated` → `SessionBloc` navigates to Login; a request refreshed before sending goes out without a token, and a request whose 401 led there fails with an `unauthorized` `ApiException`. Any other refresh error fails the request (with the refresher's `ApiException`, or an `unknown` one wrapping any other error) and keeps the session; inside Fresh's `refreshToken` only a `RevokeTokenException` logs out and only a `DioException` fails the request cleanly. The token goes only to the origin (scheme, host and port) of the client's base URL: a request to any other origin is sent without it, and a 401 from there neither refreshes the token nor ends the session.

## Logger

Abstract `Logger` interface (`lib/core/logger/logger.dart`) with methods: `init`, `registerUser`, `log`, `logInfo`, `logWarning`, `logError`. `MultiLogger` (`lib/data/services/logger/`) fans out to multiple implementations. `ConsoleLogger` is added only when `config.enableConsoleLogs` is true (debug builds). Add new loggers (e.g., Crashlytics) to the `MultiLogger` list in `_initializeLogger()`.

## Code Style

`use_primary_constructors` is enabled (root, `api_client`, `app_api` and `stx_repository`). Write classes like:

```dart
class const MainWrapperScreen({super.key}) extends StatefulWidget { ... }
class HttpInterceptor(final Logger _logger) extends Interceptor { ... }
class ChatsBloc(final ChatsRepository _repo) extends Bloc<ChatsEvent, ChatsState> {
  this : super(const ChatsState()) { on<_Load>(_load); }   // initializer list + body
}
class LoggerService._() extends Logger { ... }               // private primary ctor
class MockDio extends Mock implements Dio;                   // empty body
```

Prefer dot shorthands where the context type is known: `emit(state.copyWith(status: .loading))`, `padding: const .all(8)`, `mainAxisSize: .min`, switch arms `.badResponse => ...`.

## Linting

Uses `very_good_analysis` with relaxed rules: no required doc comments, no sort pub dependencies, no sort constructors first. Excluded from analysis: generated files (`*.g.dart`, `*.freezed.dart`, `*.config.dart`, `*.gen.dart`), `build/` and platform folders.

**Import sorting:** `tidy_imports` (config in the `tidy_imports:` block of `pubspec.yaml`); the pre-commit hook rejects commits with unsorted imports. Generated files and `.dart_tool/` are ignored.

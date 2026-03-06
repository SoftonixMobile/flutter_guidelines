# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Flutter mobile application template following Clean Architecture with BLoC pattern. Monorepo structure with three local packages under `packages/`. Uses extensive code generation (Freezed, JSON serializable, auto_route, injectable, flutter_gen).

## Common Commands

```bash
make get            # dart pub get
make build          # Run build_runner (generates *.g.dart, *.freezed.dart, *.config.dart, *.gr.dart)
make watch          # Run build_runner in watch mode
make lang           # Generate localization files in lib/presentation/localization/
make lint           # flutter analyze .
make sort           # Sort imports via import_sorter
make fix            # dart fix --apply
make format         # dart format
make refactor       # Full pipeline: upgrade → build → lang → fix → sort → lint
make splash         # Generate splash screen via flutter_native_splash
make icon           # Generate app icons via flutter_launcher_icons
make setup_hooks    # Install git hooks (pre-commit: sort imports + analyze)
```

After modifying models, BLoCs, routes, or DI registrations, always run `make build` to regenerate code.

**Running tests:**
```bash
flutter test                                          # All tests
flutter test test/unit_test/blocs/auth/auth_bloc_test.dart  # Single file
flutter test --name "Auth bloc"                       # By name pattern
flutter test --coverage                               # With coverage
```

## Architecture

**Clean Architecture layers:**
- `lib/core/` — Config (`AppConfig` via `--dart-define`), constants, base exceptions (`AppException`), initialization, DI (get_it + injectable), abstract `Logger`, utils
- `lib/domain/` — Domain models (`UserData`, `AuthStatus`, type aliases, data models re-exports), `RemoteException`, abstract `AuthSession`, repository re-exports
- `lib/data/` — Repositories (extend `stx_repository` base), HTTP service (Dio + Fresh), logger implementations, storage keys
- `lib/presentation/` — App entry, BLoCs, screens, router (auto_route), localization, theme/design system, reusable widgets

**Dependency injection has two phases (`lib/core/injector/injector.dart`):**
1. `configureAuthDependencies()` — Registers core singletons (AppRouter, Logger, UserData, HttpClient as both ApiClient and AuthSession) and calls `getIt.initAuthScope()` which adds auth-scoped dependencies: AuthRepository, UserRepository, AuthBloc, LoginFormBloc
2. `configureUserDependencies()` — Called via `getIt.pushNewScope(init: configureUserDependencies)` inside `MainWrapperScreen.initState`; registers `DataProviderPackageModule` (services) and user-scoped dependencies (UserBloc, PostsRepository, ChatsRepository, PostsBloc, ChatsBloc, DrawerBloc, PostFormBloc)

User-scoped dependencies are torn down when `MainWrapperScreen.dispose()` calls `getIt.popScope()`.

**App initialization sequence** (`lib/core/initialization/app_initialization.dart`):
Splash → Localization → Logger (MultiLogger) → Crashlytics → BlocObserver → `configureAuthDependencies()` → Validators

**Navigation:** auto_route with declarative routing at root. `RootScreen` switches between `LoginRoute` and `MainRouter` based on `AuthBloc` state. `MainWrapperScreen` (annotated `@RoutePage(name: 'MainRouter')`) manages user scope lifecycle. `MainScreen` uses `AutoTabsScaffold` with 3 bottom tabs (Dashboard, Messages, Settings) and an `AppDrawer` as endDrawer.

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

- `packages/data_provider/` — Shared data models (UserProfile, Chat, Post, AuthResponse), abstract network layer (ApiClient, JsonParser, NetworkOptions, Response), network services (AuthService, UserService, PostsService, ChatsService). Has its own injectable micro-package module (`DataProviderPackageModule`). Services register their JSON types via `_client.registerType(Model.fromJson)` in constructors.
- `packages/stx_repository/` — Base repository abstraction with mixins: `SyncLoadRepositoryMixin`, `StreamRepositoryMixin`, `TTLRefreshRepositoryMixin`, `DisposableRepositoryMixin`
- `packages/customizable_cupertino_dialog/` — Custom iOS dialog widget

## Code Generation Conventions

- Models use `@freezed` with `@JsonSerializable` — define in `.dart`, generated code in `.freezed.dart` and `.g.dart`
- BLoC states/events use `@freezed` sealed unions
- Routes use `@AutoRouterConfig` and `@RoutePage()` annotations — generated in `router.gr.dart`
- DI uses `@injectable`/`@singleton`/`@lazySingleton` annotations with optional `scope:` parameter — generated in `injector.config.dart`
- Assets/colors/fonts generated by flutter_gen into `lib/presentation/theme/`

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

`UserRepository.emit()` overrides the base to keep the `UserData` singleton in sync. Auth-scoped repositories use `@LazySingleton(scope: 'auth')`.

## BLoC Patterns

**Standard list screen** uses `NetworkListBloc<T, S>` from `stx_bloc_base`:
```dart
typedef PostsState = NetworkListState<Post>;

@injectable
class PostsBloc extends NetworkListBloc<Post, PostsState> {
  final PostsRepository _postsRepository;

  PostsBloc(this._postsRepository) : super(const NetworkListState(data: []));

  @override
  FutureOr<List<Post>> onLazyLoad() => _postsRepository.getPosts();

  @override
  Future<List<Post>> onLoadAsync() => _postsRepository.getPosts(refresh: true);
}
```

**Single-value screen** uses `NetworkBloc<T, S>` — e.g., `UserBloc` (`@singleton`) extends `NetworkBloc<UserProfile, UserState>`.

**Form screen** uses `FormBloc<SuccessType, ErrorType>` from `stx_flutter_form_bloc` with `TextFieldBloc` fields. Field validators live in `lib/presentation/utils/field_validators.dart`. Form BLoCs support `@factoryParam` for edit mode — e.g., `PostFormBloc(@factoryParam Post? initial)` injected with `getIt<PostFormBloc>(param1: post)`.

**Auth/complex state machines** use custom `@freezed` sealed unions:
```dart
@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState({@Default(AuthStatus.initial) AuthStatus status}) = _AuthState;
  factory AuthState.authenticated() => const AuthState(status: AuthStatus.authenticated);
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
- `RemoteException` (`lib/domain/exceptions/`) — extends `AppException`; has `RemoteExceptionType` enum (noConnection, timeout, badRequest, unauthorized, notFound, clientError, serverError, unknown) and `int? statusCode`

**Flow:** `DioException` → `HttpClient._guard()` → `RemoteExceptionMapper.fromDioException()` → `RemoteException` → BLoC `addError(e, stackTrace)` → `SimpleBlocObserver.onError()` → `logger.logError()`

`fresh_dio` throws `RevokeTokenException` on 401 (refreshToken always throws) → `AuthSession.authenticationStatus` emits `unauthenticated` → `AuthBloc` navigates to Login.

## Logger

Abstract `Logger` interface (`lib/core/logger/logger.dart`) with methods: `init`, `registerUser`, `log`, `logInfo`, `logWarning`, `logError`. `MultiLogger` (`lib/data/services/logger/`) fans out to multiple implementations. `ConsoleLogger` used in debug mode only. Add new loggers (e.g., Crashlytics) to the `MultiLogger` list in `initializeLogger()`.

## Linting

Uses `very_good_analysis` with relaxed rules: no required doc comments, no sort pub dependencies, no sort constructors first. Generated files (`*.g.dart`, `*.freezed.dart`, `*.config.dart`, `*.gen.dart`) are excluded from analysis.

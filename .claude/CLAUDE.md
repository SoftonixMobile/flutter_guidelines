# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project purpose

This is a **Flutter project template** maintained by Softonix. The app code in `lib/` demonstrates the team's conventions end-to-end (auth flow, routing, DI, http, bloc, localization). The `bin/update_guidelines_brick.dart` script copies this project into `bricks/stx_project_template/__brick__` and converts the `flutter_guidelines` strings into Mason template placeholders — so any change in `lib/`, `pubspec.yaml`, `Makefile`, etc. is effectively a change to the template consumed by new projects. Keep this dual purpose in mind: code here is reference material, not product code.

## Toolchain

- Flutter pinned via FVM in `.fvmrc` (currently 3.41.7). Prefer `fvm flutter ...` / `fvm dart ...` locally; raw `flutter` / `dart` is fine in CI if the right version is on PATH.
- Dart SDK `^3.11.0`, Flutter `^3.41.0` (see `pubspec.yaml`).

## Common commands

Driven by `Makefile`:

- `make get` — `dart pub get`
- `make build` — one-shot `build_runner build --delete-conflicting-outputs` (freezed, json_serializable, auto_route, injectable, flutter_gen)
- `make watch` — build_runner in watch mode
- `make lang` — regenerate `codegen_loader.g.dart` and `locale_keys.g.dart` from `resources/langs/` via `stx_easy_localization_generator`
- `make sort` — `import_sorter` (must produce "Sorted 0 files" for pre-commit to pass)
- `make fix` — `dart fix --apply`
- `make format` — `dart format .`
- `make lint` — `flutter analyze .`
- `make refactor` — upgrade + build + lang + fix + sort + lint (run after pulling or large edits)
- `make splash` / `make icon` — regenerate native splash / launcher icons
- `make setup_hooks` — installs `scripts/hooks/pre-commit` (runs import_sorter then `flutter analyze`; fails commits on unsorted imports or analyzer errors)

Testing:

- `flutter test` — run all tests under `test/`
- `flutter test test/unit_test/blocs/auth_bloc_test.dart` — single file
- `flutter test --plain-name "signs out"` — single test by name

## Running the app

The app reads config exclusively via `String.fromEnvironment` (`lib/app/app_config.dart`: `ENV`, `APP_PROJECT_PREFIX`, `APP_API_URL`). Values come from `.env.dev` / `.env.prod` via `--dart-define-from-file`:

```
flutter run --dart-define-from-file=.env.dev
flutter run --dart-define-from-file=.env.prod --release
```

VS Code `launch.json` has `dev debug`, `dev release`, `prod debug`, `prod release` preconfigured. 

## Architecture

### Startup sequence (`lib/main.dart` → `lib/app/`)

`initializeApp()` in `app_initialization.dart` runs these in order before `runApp`:

1. `FlutterNativeSplash.preserve` — splash held until auth state resolves in `RootScreen`.
2. `LoggerService.instance.init()`
3. `EasyLocalization.ensureInitialized()`
4. `FlutterError.onError` + `PlatformDispatcher.instance.onError` → `LoggerService.logError` (crashlytics hook point).
5. `Bloc.observer = SimpleBlocObserver(...)`.
6. `FieldBlocValidators.required/requiredBooleanValidator` overridden with app-specific validators.
7. `configureAuthDependencies()` — registers ONLY the auth-scoped DI graph.

`MaterialApp.router` is built inside `AppStateWrapper`, which provides the app-wide `AuthBloc`. `RootScreen` listens to auth state and uses `AutoRouter.declarative` to switch between `[LoginRoute]` (unauthenticated) and `[MainRouter]` (authenticated); splash is removed once state leaves `initial`.

### Two-phase dependency injection (important)

`lib/services/injector/injector.dart` splits DI into two scopes:

- **auth scope** — `configureAuthDependencies()` runs at startup. Only registers what's needed to authenticate: `AppRouter`, `Logger`, `HttpClient`, `AuthRepository`, `AuthBloc`, etc. Anything annotated `@Injectable(scope: 'auth')` or `@Singleton(scope: 'auth')` belongs here.
- **user scope** — `configureUserDependencies(getIt)` is called AFTER the user authenticates (typically from `MainStateWrapper` / main flow) and registers the rest (`ChatsBloc`, `PostsBloc`, chat/post repositories, etc.).

When adding a new bloc/repository/service, decide which scope it lives in. The scope is what `injectable_generator` uses when generating `injector.config.dart` — don't hand-edit that file.

`build.yaml` restricts `injectable_builder` to files matching `*_bloc.dart`, `*_cubit.dart`, `*_repository.dart`, `*_provider.dart`, `*_client.dart`. File names matter for code generation.

### HTTP layer (`lib/services/http/`)

`HttpClient` wraps a single `Dio` with three interceptors in this order: `Fresh<String>` (token storage/refresh), `HttpInterceptor` (logging), `RetryInterceptor`. Tokens persist via `SecureTokenStorage` (flutter_secure_storage). The `refreshToken` callback intentionally throws `RevokeTokenException` — token refresh is a stub; replace it with a real implementation per project.

Every request funnels through `_guard(...)` which maps `DioException` → app-level exception via `AppExceptionMapper.fromDioException` (preserving stack trace). Responses go through `JsonDataParser` so each call site gets a typed `T` — register custom types with `httpClient.registerType<T>(converter)`.

Auth status is exposed as `Stream<AuthStatus>` derived from Fresh's stream; `AuthRepository` forwards it and `AuthBloc` subscribes to drive routing.

### Routing (`lib/router/`)

`auto_route` with a declarative root: `RootRoute` contains either `LoginRoute` or `MainRouter` (nested tab routes: `DashboardRoute`, `MessagesRoute` with `ChatsRoute`/`PostsRoute` children, `SettingsRoute`, plus `ChatDetailsRoute`). `router.gr.dart` is generated — don't edit. Routes are picked up from `lib/router/router.dart` AND any `lib/**_screen.dart` that has `@RoutePage()` (see `build.yaml`).

### State management

- `flutter_bloc` throughout, with freezed unions for events/states. `build.yaml` restricts freezed/json_serializable generation to `lib/models/**`, `lib/**/models.dart`, and `*_bloc.dart`/`*_cubit.dart`/`*_event.dart` files — follow these naming conventions so codegen runs on your files.
- Forms use `stx_flutter_form_bloc` (FieldBloc). Validators are registered globally in `initializeValidators()`.
- `stx_bloc_base` provides base bloc utilities used across features.

### Localization

`resources/langs/*.json` → generated into `lib/localization/codegen_loader.g.dart` + `locale_keys.g.dart` via `make lang`. Use `LocaleKeys.xxx.tr()`; don't hand-edit the generated files. Fallback locale is the last entry in `CodegenLoader.supportedLocales`.

### Theme & assets

`flutter_gen` outputs to `lib/theme/` (`assets.gen.dart`, `fonts.gen.dart`).


## Conventions enforced by tooling

- **Import sorting**: `import_sorter` groups imports; pre-commit hook rejects commits with unsorted imports. Generated files (`.g.dart`, `.config.dart`, `.freezed.dart`, `.gen.dart`, `.gr.dart`, `.mocks.dart`) are excluded.
- **Lints**: `very_good_analysis` baseline with project-specific relaxations in `analysis_options.yaml` (notably `always_use_package_imports: false`, `public_member_api_docs: false`, `lines_longer_than_80_chars: false`, `avoid_catches_without_on_clauses: false`). Formatter keeps trailing commas.
- **Barrel files**: each feature folder has an `index.dart` (`lib/app/index.dart`, `lib/blocs/index.dart`, etc.). Export new public members there.

## Updating the brick template

After making changes you want propagated to new projects generated from this template:

```
dart run flutter_guidelines:update_guidelines_brick
```

`bin/update_guidelines_brick.dart` wipes and rebuilds `bricks/stx_project_template/__brick__/` and rewrites `flutter_guidelines` → `{{project_name}}`, `FlutterGuidelinesApp` → `{{#pascalCase}}{{project_name}}{{/pascalCase}}App`, `Flutter_Guidelines_` → `{{#constantCase}}{{project_name}}{{/constantCase}}_`. If you introduce a new string that should be templated, extend `convertToBrickFormat`.
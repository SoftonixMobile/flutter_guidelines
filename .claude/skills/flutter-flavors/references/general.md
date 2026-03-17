# Flutter Flavors — General / Dart Side

This reference covers the Dart-side configuration that applies to both Android and iOS.

## Table of Contents
1. [Flavor Definition Strategy](#flavor-definition-strategy)
2. [Entry Point Approach](#entry-point-approach)
3. [Environment Files (`--dart-define-from-file`)](#environment-files---dart-define-from-file)
4. [Run Configurations](#run-configurations)

---

## Flavor Definition Strategy

Typical flavor set:

| Flavor    | Use case                  | ID Suffix   | Name Suffix |
|-----------|---------------------------|-------------|-------------|
| `dev`     | Local development         | `.dev`      | `Dev `      |
| `prod`    | Production release        | (none)      | (none)      |

The user may have different names or additional flavors — adapt accordingly.

---

## Entry Point Approach

Create a separate `main_<flavor>.dart` file per flavor. Each entry point handles flavor-specific bootstrap. Typically combined with `--dart-define-from-file` to pass environment variables (API URLs, keys, etc.).

### File structure example

```
lib/
├── core/
│   └── config/
│       └── app_config.dart   # Config class
│   └── initialization/
│       └── app_initialization.dart   # Shared app initialization logic
├── presentation/
│   └── app.dart              # Shared MyApp widget
├── main_dev.dart
├── main_prod.dart
.env.dev
.env.prod
```

### Example: `lib/core/config/app_config.dart`

```dart
abstract final class AppConfig {
  static const environment = String.fromEnvironment('ENV');
  static const appPrefix = String.fromEnvironment('APP_PROJECT_PREFIX');
  static const appApiUrl = String.fromEnvironment('APP_API_URL');

  static bool get isDev => environment == 'dev';
  static bool get isProd => environment == 'prod';
}
```

### Example: `lib/main_dev.dart`

```dart
void main() async {
  await initializeApp();

  runApp(
    EasyLocalization(
      path: CodegenLoader.path,
      supportedLocales: CodegenLoader.supportedLocales,
      fallbackLocale: CodegenLoader.supportedLocales.last,
      assetLoader: const CodegenLoader(),
      child: FlutterGuidelinesApp(),
    ),
  );
}
```

Repeat similarly for `main_prod.dart` with appropriate values. And remove `main.dart` file.

---

## Environment Files (`--dart-define-from-file`)

Use `.env` files to pass environment variables at build time. This works alongside entry points — entry points handle flavor-specific bootstrap, while `.env` files supply config values (API URLs, keys, feature flags).

### `.env` file example

```
# .env.dev
ENV='dev'
APP_PROJECT_PREFIX='Project_Name_Dev'
APP_API_URL='https://api-dev.example.com'
```

```
# .env.prod
ENV='prod'
APP_PROJECT_PREFIX='Project_Name'
APP_API_URL='https://api.example.com'
```

These values are accessed in Dart via `String.fromEnvironment()` (see `AppConfig` above).

### Build command

```bash
flutter run --flavor dev \
  -t lib/main_dev.dart \
  --dart-define-from-file=.env.dev
```

---

## Run Configurations

### VS Code (`/.vscode/launch.json`)

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "dev debug",
            "request": "launch",
            "type": "dart",
            "program": "lib/main_dev.dart",
            "args": [
                "--dart-define-from-file=.env.dev",
                "--flavor=dev"
            ],
        },
        {
            "name": "dev release",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release",
            "program": "lib/main_dev.dart",
            "args": [
                "--dart-define-from-file=.env.dev",
                "--flavor=dev"
            ],
        },
        {
            "name": "prod debug",
            "request": "launch",
            "type": "dart",
            "program": "lib/main_prod.dart",
            "args": [
                "--dart-define-from-file=.env.prod",
                "--flavor=prod"
            ],
        },
        {
            "name": "prod release",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release",
            "program": "lib/main_prod.dart",
            "args": [
                "--dart-define-from-file=.env.prod",
                "--flavor=prod"
            ],
        },
    ]
}
```
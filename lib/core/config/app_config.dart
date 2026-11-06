import 'package:flutter/foundation.dart';

import 'package:flutter_guidelines/core/exceptions/config_exception.dart';

import 'app_environment.dart';

@immutable
class const AppConfig({
  required final AppEnvironment environment,
  required final Uri apiUrl,
  required final bool enableConsoleLogs,
}) {
  /// The only place in the app that reads `--dart-define` values.
  factory fromEnvironment() => AppConfig.parse(
    const {
      'ENV': String.fromEnvironment('ENV'),
      'APP_API_URL': String.fromEnvironment('APP_API_URL'),
    },
    isDebugBuild: kDebugMode,
  );

  /// Pure parser and validator, unit-testable without dart-defines.
  factory parse(Map<String, String> env, {bool isDebugBuild = false}) {
    final rawEnvironment = _requireValue(env, 'ENV');
    final environment =
        AppEnvironment.values.asNameMap()[rawEnvironment] ??
        (throw ConfigException(message: 'Unknown ENV "$rawEnvironment"'));

    final apiUrl = Uri.tryParse(_requireValue(env, 'APP_API_URL'));
    if (apiUrl == null || !apiUrl.hasScheme || apiUrl.host.isEmpty) {
      throw const ConfigException(
        message: 'APP_API_URL must be an absolute URL',
      );
    }

    return AppConfig(
      environment: environment,
      apiUrl: apiUrl,
      enableConsoleLogs: isDebugBuild,
    );
  }

  static String _requireValue(Map<String, String> env, String key) {
    final value = env[key] ?? '';
    if (value.isEmpty) {
      throw ConfigException(
        message: '$key is not set. Run with --dart-define-from-file=.env.dev',
      );
    }

    return value;
  }
}

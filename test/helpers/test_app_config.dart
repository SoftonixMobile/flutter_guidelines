import 'package:flutter_guidelines/core/config/index.dart';

AppConfig testConfig({
  AppEnvironment environment = .dev,
  String apiUrl = 'https://api.test',
  bool enableConsoleLogs = false,
}) => AppConfig(
  environment: environment,
  apiUrl: Uri.parse(apiUrl),
  enableConsoleLogs: enableConsoleLogs,
);

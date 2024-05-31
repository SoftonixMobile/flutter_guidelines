class AppConfig {
  static const environment = String.fromEnvironment('ENV');
  static const appPrefix = String.fromEnvironment('APP_PROJECT_PREFIX');
  static const appApiUrl = String.fromEnvironment('APP_API_URL');

  static bool get isDev => environment == 'dev';
  static bool get isProd => environment == 'prod';
}

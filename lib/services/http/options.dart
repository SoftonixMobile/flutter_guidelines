import 'package:flutter_guidelines/app/app_config.dart';

abstract final class DioOptions {
  static String baseUrl = AppConfig.appApiUrl;

  static const Duration connectTimeout = Duration(seconds: 10);

  static const Duration receiveTimeout = Duration(seconds: 100);
}

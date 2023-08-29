import 'package:{{project_name}}/core/constants/index.dart';

class DioOptions {
  static String baseUrl = EnvConstants.appApiUrl;

  static const Duration connectTimeout = Duration(seconds: 10);

  static const Duration receiveTimeout = Duration(seconds: 100);
}

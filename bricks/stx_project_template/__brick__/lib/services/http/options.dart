import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioOptions {
  static String baseUrl = dotenv.get('APP_API_URL');

  static const Duration connectTimeout = Duration(seconds: 10);

  static const Duration receiveTimeout = Duration(seconds: 100);
}

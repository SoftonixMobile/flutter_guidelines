import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioOptions {
  static String baseUrl = dotenv.get('APP_API_URL');

  static const int connectTimeout = 10000;

  static const int receiveTimeout = 100000;
}

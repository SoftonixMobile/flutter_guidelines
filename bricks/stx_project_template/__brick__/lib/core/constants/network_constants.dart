import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioBaseOptions {
  static String baseUrl = '${dotenv.get('APP_API_URL')}/api';

  static const int connectTimeout = 10000;

  static const int receiveTimeout = 100000;
}

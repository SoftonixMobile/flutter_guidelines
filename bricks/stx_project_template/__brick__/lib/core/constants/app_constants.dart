import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static const String dotenvFilePath = '.env';
  static String appPrefix = dotenv.get('APP_PROJECT_PREFIX');
  static String appApiUrl = dotenv.get('APP_API_URL');
}

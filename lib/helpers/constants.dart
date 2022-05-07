import 'package:easy_localization/easy_localization.dart';

class AppConstants {
  static const String dotenvFilePath = ".env";

  static DateFormat dateFormat = DateFormat('EE MM/dd/yyyy', 'en');
  static DateFormat timeFormat = DateFormat('hh:mm a', 'en');
  static DateFormat fullDateFormat = DateFormat('EE, MM/dd/yyyy hh:mm a', 'en');
}

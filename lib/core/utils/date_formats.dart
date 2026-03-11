import 'package:easy_localization/easy_localization.dart';

abstract final class AppDateFormats {
  static final date = DateFormat('EE MM/dd/yyyy', 'en');
  static final dateFull = DateFormat('EE, MM/dd/yyyy hh:mm a', 'en');

  static final time = DateFormat('hh:mm a', 'en');
}

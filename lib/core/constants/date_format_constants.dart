import 'package:intl/intl.dart';

abstract final class DateFormatConstants() {
  static DateFormat get defaultDate => DateFormat('EE MM/dd/yyyy');
  static DateFormat get defaultTime => DateFormat('hh:mm a');
  static DateFormat get fullDat => DateFormat('EE, MM/dd/yyyy hh:mm a');

  static final DateFormat payload = DateFormat('yyyy-MM-dd', 'en');
}

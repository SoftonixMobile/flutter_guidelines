import 'package:intl/intl.dart';

abstract final class DateFormatters() {
  static String date(DateTime value) => DateFormat.yMd().format(value);

  static String dateMedium(DateTime value) => DateFormat.yMMMd().format(value);

  static String weekdayDate(DateTime value) => DateFormat.yMEd().format(value);

  static String time(DateTime value) => DateFormat.jm().format(value);

  static String dateTime(DateTime value) =>
      DateFormat.yMEd().add_jm().format(value);
}

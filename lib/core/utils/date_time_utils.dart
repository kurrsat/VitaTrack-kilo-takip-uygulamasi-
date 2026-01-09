import 'package:intl/intl.dart';
class DateTimeUtils {
  static DateTime nowUtc() => DateTime.now().toUtc();

  static DateTime startOfDayUtc(DateTime date) =>
      DateTime.utc(date.year, date.month, date.day);

  static String formatDate(DateTime date, String locale) {
    return DateFormat.yMMMd(locale).format(date.toLocal());
  }

  static String formatDateShort(DateTime date, String locale) {
    return DateFormat.MMMd(locale).format(date.toLocal());
  }

  static String formatTime(DateTime date, String locale) {
    return DateFormat.Hm(locale).format(date.toLocal());
  }
}

import 'package:intl/intl.dart';

String dayKey(DateTime date) {
  final local = date.toLocal();
  return DateFormat('yyyy-MM-dd').format(local);
}

DateTime normalizeDate(DateTime date) {
  final local = date.toLocal();
  return DateTime(local.year, local.month, local.day);
}

String formatDayTitle(DateTime date, String locale) {
  return DateFormat('d MMMM, EEEE', locale).format(date.toLocal());
}

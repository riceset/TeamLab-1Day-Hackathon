import 'package:intl/intl.dart';

class DateFormatter {
  static const japaneseDateFormat = 'M月d日(E)';
  static const inputDateFormat = 'yyyy/M/d';

  static String formatJapanese(DateTime date) {
    return DateFormat(japaneseDateFormat, 'ja').format(date);
  }

  static String formatInput(DateTime date) {
    return '${date.year}/${date.month}/${date.day}';
  }
}

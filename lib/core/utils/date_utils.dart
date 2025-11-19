import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();

  static final DateFormat _displayFormatter = DateFormat('MMM dd, yyyy');
  static final DateFormat _inputFormatter = DateFormat('yyyy-MM-dd');

  static String formatDisplayDate(DateTime date) =>
      _displayFormatter.format(date);

  static String formatInputDate(DateTime date) =>
      _inputFormatter.format(date);

  static DateTime? tryParseInput(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    try {
      return _inputFormatter.parseStrict(value.trim());
    } on FormatException {
      return null;
    }
  }
}
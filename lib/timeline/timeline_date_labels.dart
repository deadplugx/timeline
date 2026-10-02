import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class TimelineDateLabels {
  const TimelineDateLabels._();

  static String day(DateTime time, Locale locale) {
    return DateFormat('d MMM', locale.toString()).format(time);
  }

  static String month(DateTime time, Locale locale) {
    return DateFormat.LLL(locale.toString()).format(time);
  }
}

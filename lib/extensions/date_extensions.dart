import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  String get formattedTime {
    return DateFormat('hh:mm a').format(this);
  }
}

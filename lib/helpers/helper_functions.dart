import 'package:intl/intl.dart';

String changeTimeToAnotherTimeZone(DateTime dateTime, int timeZone) {
  return DateFormat('hh:mm a')
      .format(dateTime.toUtc().add(Duration(seconds: timeZone)));
}

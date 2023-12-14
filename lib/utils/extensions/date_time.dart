import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String toFormattedStringWithMonth() {
    return DateFormat('MMMM dd, yyyy').format(toLocal());
  }

  String toFormattedStringWithMonthAndTime() {
    return DateFormat('MMMM dd, yyyy hh:mm a ').format(toLocal());
  }

  String toFormattedString() {
    return DateFormat('dd/MM/yyyy').format(toLocal());
  }

  String toFormattedStringWithTime() {
    return DateFormat('dd/MM/yyyy hh:mm a').format(toLocal());
  }

  String toFormattedTimeString() {
    return DateFormat('hh:mm a').format(toLocal());
  }

  String toFormattedTimeStringWithSeconds() {
    return DateFormat('hh:mm:ss a').format(toLocal());
  }

  String toFormattedTimeStringWithDate() {
    return DateFormat('dd/MM/yyyy hh:mm a').format(toLocal());
  }

  String toFormattedTimeStringWithDateAndSeconds() {
    return DateFormat('dd/MM/yyyy hh:mm:ss a').format(toLocal());
  }

  String toFormattedTimeStringWithDateAndSecondsAndTimezone() {
    return DateFormat('dd/MM/yyyy hh:mm:ss a z').format(toLocal());
  }

  String toFormattedTimeStringWithSecondsAndTimezone() {
    return DateFormat('hh:mm:ss a z').format(toLocal());
  }

  String toFormattedTimeStringWithTimezone() {
    return DateFormat('hh:mm a z').format(toLocal());
  }

  String toFormattedTimeStringWithDateAndTimezone() {
    return DateFormat('dd/MM/yyyy hh:mm a z').format(toLocal());
  }
}

import 'package:intl/intl.dart';

// Formats a DateTime variable to show year, month and day respectively
String toDate(DateTime dateTime) {
  final date = DateFormat.yMMMEd().format(dateTime);

  return '$date';
}

// Formats a DateTime variable to show hour and minutes, respectively
String toTime(DateTime dateTime) {
  final time = DateFormat.Hm().format(dateTime);

  return '$time';
}
import 'package:intl/intl.dart';

DateTime parseDate(String input) {
  return DateFormat("dd/MM/yy").parse(input);
}

String formatDate(DateTime input) {
  return DateFormat("dd/MM/yy").format(input);
}
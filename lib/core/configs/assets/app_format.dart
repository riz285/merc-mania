import 'package:intl/intl.dart';

class AppFormat {
  static NumberFormat currency = NumberFormat.simpleCurrency(locale: 'vi');
  static DateFormat date = DateFormat('dd-MM-yyyy hh:mm');
  static DateFormat dateTostring = DateFormat('yyyyMMddhhmm');
}

import 'package:intl/intl.dart';

class AppFormat {
  static NumberFormat currency = NumberFormat.simpleCurrency(locale: 'vi');
  static DateFormat hourmin = DateFormat('HH:mm');
  static DateFormat date = DateFormat('yyyy-MM-dd HH:mm');
  static DateFormat time = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
  static DateFormat dateTostring = DateFormat('yyyyMMddhhmm');
  static NumberFormat cardnumber = NumberFormat('####,####,####,####');
}

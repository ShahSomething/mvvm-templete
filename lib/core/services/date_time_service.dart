import 'package:intl/intl.dart';

///[DateTimeService] contains all the date formating functions
class DateTimeService {
  ///formats the date in Year-Month-Day form
  static formateDate(DateTime? dateTime) {
    final dateFormat = DateFormat('dd MMM yyyy');
    if (dateTime != null) return dateFormat.format(dateTime);
  }

  ///formats the date in [time][AM/PM] form
  static formatToAMPM(DateTime? dateTime) {
    final dateFormat = DateFormat.jm();
    if (dateTime != null) return dateFormat.format(dateTime);
  }

  static myFormat(DateTime? dateTime) {
    final dateFormat = DateFormat('hh:mm a, dd MMM yyyy');
    if (dateTime != null) {
      return dateFormat.format(dateTime);
    }
  }

  static myFormat2(DateTime? startTime, DateTime? endTime) {
    final timeFormat = DateFormat('hh:mm a');
    final dateFormat = DateFormat('dd MMM yyyy');
    if (startTime != null && endTime != null) {
      return "${timeFormat.format(startTime)} - ${timeFormat.format(endTime)}, ${dateFormat.format(startTime)}";
    }
  }

  static String? dayName(DateTime date1, DateTime date2) {
    var d1 = DateTime(date1.year, date1.month, date1.day);
    var d2 = DateTime(date2.year, date2.month, date2.day);
    if (d1.difference(d2).inDays == 0) {
      return 'Today';
    } else if (d1.difference(d2.add(const Duration(days: 1))).inDays == 0) {
      return 'Tomorrow';
    } else {
      return null;
    }
  }

  static formatForTask(DateTime dateTime) {
    String? date = dayName(dateTime, DateTime.now());

    final timeFormat = DateFormat('hh:mm a');
    final dateFormat = DateFormat('dd MMM yyyy');
    return "${date ?? dateFormat.format(dateTime)} At ${timeFormat.format(dateTime)}";
  }
}

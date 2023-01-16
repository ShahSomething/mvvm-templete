import 'package:intl/intl.dart';

///[DateTimeService] contains all the date formating functions
class DateTimeService {
  ///formats the date in Year-Month-Day form
  static formateDate(DateTime? dateTime) {
    final dateFormat = DateFormat.yMd();
    if (dateTime != null) return dateFormat.format(dateTime);
  }

  ///formats the date in [time][AM/PM] form
  static formateToAMPM(DateTime? dateTime) {
    final dateFormat = DateFormat.jm();
    if (dateTime != null) return dateFormat.format(dateTime);
  }
}

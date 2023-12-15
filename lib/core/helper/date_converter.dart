import 'package:intl/intl.dart';

class DateConverter {

  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss a').format(dateTime);
  }

  static String dateToTimeOnly(DateTime dateTime) {
    return DateFormat(_timeFormatter()).format(dateTime);
  }

  static String dateToDateAndTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  static String dateToDateOnly(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime);
  }

  static String dateTimeStringToDateTime(String dateTime) {
    return DateFormat('dd MMM yyyy  ${_timeFormatter()}').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
  }

  static String dateTimeStringToDateOnly(String dateTime) {
    return DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
  }

  static DateTime dateTimeStringToDate(String dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime);
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime);
  }

  static DateTime isoUtcStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();
  }

  static String isoStringToDateTimeString(String dateTime) {
    return DateFormat('dd MMM yyyy  ${_timeFormatter()}').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String stringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM, yyyy').format(DateFormat('yyyy-MM-dd').parse(dateTime));
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime);
  }

  static String convertTimeToTime(String time) {
    return DateFormat(_timeFormatter()).format(DateFormat('HH:mm').parse(time));
  }

  static String convertStringTimeToDate(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  static DateTime convertStringTimeToDateOnly(String time) {
    return DateFormat('yyyy-MM-dd').parse(time);
  }

  static String dateMonthYearTime(String dateTime) {
    return DateFormat(_timeFormatter()).format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
    }
  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('HH:mm aa').format(isoStringToLocalDate(dateTime));
  }

  static String dateStringMonthYear(DateTime ? dateTime) {
    return DateFormat('d MMM,y').format(dateTime!);
  }

  static String dateToWeek(DateTime ? dateTime) {
    return DateFormat('EEEE').format(dateTime!);
  }

  static String _timeFormatter() {
    return 'hh:mm a';
  }

  static int countDays(DateTime ? dateTime) {
    final startDate = dateTime!;
    final endDate = DateTime.now();
    final difference = endDate.difference(startDate).inDays;
    return difference;
  }

  static String dateMonthYearTimeTwentyFourFormat(DateTime ? dateTime) {
    return DateFormat('d MMM,y HH:mm').format(dateTime!);
  }


  static DateTime isoUtcStringToLocalDateTime(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();
  }



}

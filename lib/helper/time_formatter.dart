import 'dart:ui'; // For locale detection
import 'package:intl/intl.dart';

bool isUSLocale() {
  return window.locale.countryCode == 'US';
}

DateTime parseDate(String date) {
  DateTime dateTime = DateTime.parse(date);
  if (isUSLocale()) {
    return dateTime;
  } else {
    return dateTime.isUtc ? dateTime.toLocal() : dateTime;
  }
}

String timeFormatter(String date) {
  return DateFormat("hh:mm a").format(parseDate(date)).toString();
}

String time24Formatter(String date) {
  return DateFormat("HH:mm").format(DateTime.parse(date)).toString();
}

String timeFormatterEnhance(String date) {
  return DateFormat("HH:mm").format(parseDate(date)).toString();
}

String timeFormatterEnhanceTwo(String date, int val) {
  DateTime dateTime = parseDate(date).add(Duration(minutes: val));
  return DateFormat("HH:mm").format(dateTime).toString();
}

String dateFormatter(String date) {
  try {
    // Parse the input date string (e.g., "MM-dd-yyyy")
    DateTime parsedDate = DateFormat("MM-dd-yyyy").parse(date);

    // Round the date to the nearest minute (ignoring seconds and milliseconds)
    final roundedDate = DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
      parsedDate.hour,
      parsedDate.minute,
    );

    // Format the rounded date back to "MM-dd-yyyy" format
    return DateFormat("MM-dd-yyyy").format(roundedDate);
  } catch (e) {
    // If parsing fails, return the input date string
    return date;
  }
}

String dateTimeFormatter(String date) {
  return DateFormat("MM-dd-yyyy hh:mm a").format(parseDate(date)).toString();
}

String dateTimeFormatter24(String date) {
  return DateFormat("MM-dd-yyyy HH:mm").format(parseDate(date)).toString();
}

String dateOnlyFormatter(String date) {
  return DateFormat("MM-dd-yyyy").format(parseDate(date)).toString();
}

String newDateOnlyFormatter(String date) {
  return DateFormat("MM-dd-yyyy").format(parseDate(date)).toString();
}

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

String calculateTotalDuration(String startDateStr, String endDateStr) {
  DateTime startDate = parseDate(startDateStr);
  DateTime endDate = parseDate(endDateStr);

  Duration duration = endDate.difference(startDate);

  int days = duration.inDays;
  int hours = duration.inHours.remainder(24);
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);

  String formattedDuration = '';
  if (days > 0) {
    formattedDuration += '$days d ';
  }
  if (hours > 0) {
    formattedDuration += '$hours h ';
  }
  if (minutes > 0) {
    formattedDuration += '$minutes m ';
  }
  if (seconds > 0) {
    formattedDuration += '$seconds s';
  }

  return formattedDuration.trim();
}

const String myListdateFormatter = 'MM-dd-yyyy';

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat(myListdateFormatter);
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}

String formatTimestampWithZone(String input) {
  final DateTime dateTime = parseDate(input);
  final DateFormat formatter = DateFormat('MM-dd-yyyy h:mm a z');
  return formatter.format(dateTime);
}

String convert24hrToAmPm(String time24) {
  final parsedTime = DateTime.parse('1970-01-01 $time24');
  final formattedTime =
      '${parsedTime.hour > 12 ? parsedTime.hour - 12 : parsedTime.hour == 0 ? 12 : parsedTime.hour}'
      ':${parsedTime.minute.toString().padLeft(2, '0')} '
      '${parsedTime.hour >= 12 ? 'PM' : 'AM'}';

  return formattedTime;
}

String convertToReadableDate(String date) {
  final parsedDate = parseDate(date);
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  final formattedDate =
      '${parsedDate.day} ${months[parsedDate.month - 1]} ${parsedDate.year}';

  return formattedDate;
}

String formatTimeWithTimezone(String iso8601String) {
  try {
    // Parse the ISO 8601 string
    final DateTime dateTime = DateTime.parse(iso8601String);
    
    // Get the timezone offset in hours
    final Duration offset = dateTime.timeZoneOffset;
    final int offsetHours = offset.inHours;
    
    // Format the time as HH:mm
    final String timeString = DateFormat('HH:mm').format(dateTime);
    
    // Create the timezone string (+5 GMT, -3 GMT, etc.)
    final String timezoneString = offsetHours >= 0 
        ? '+$offsetHours GMT' 
        : '$offsetHours GMT';
    
    return '$timeString $timezoneString';
  } catch (e) {
    // If parsing fails, return a default format
    return '00:00 +0 GMT';
  }
}

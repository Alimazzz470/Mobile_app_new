import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' show TimeOfDay;

String get currentTime {
  var now = DateTime.now();
  return DateFormat('hh:mm a').format(now);
}

String formatTimeInChatlist(DateTime date) {
  log("Testing : ${DateTime.now().day - DateTime.now().subtract(const Duration(days: 1)).day}");
  // check if the date is today
  switch (date.dateOnly.compareTo(DateTime.now().dateOnly)) {
    case 0:
      return DateFormat('hh:mm a').format(date.toLocal());
    case -1:
      return DateTime.now().day - date.day == 1
          ? "Yesterday"
          : DateFormat('dd MMM').format(date);
    default:
      return DateFormat('hh:mm a').format(date);
  }
}

String formatTime(DateTime date) {
  return DateFormat('hh:mm a').format(date.toLocal());
}

String yyyyMMdd(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String ddMMM(DateTime date) {
  return DateFormat('dd MMM').format(date);
}

String ddMMMyyyy(DateTime date) {
  return DateFormat('dd MMM yyyy').format(date);
}

bool isSameYear(DateTime date1, DateTime date2) {
  return date1.year == date2.year;
}

String parseDateToString(String date) {
  final dateTime = DateFormat('yyyy-MM-dd').parse(date);
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

DateTime parseStringToDate(String date) {
  return DateFormat('yyyy-MM-dd').parse(date);
}

DateTime timeOfDayToDateTime(TimeOfDay time) {
  final now = DateTime.now();
  final dateTime =
      DateTime(now.year, now.month, now.day, time.hour, time.minute);
  return DateTime.parse(dateTime.toIso8601String());
}

extension DateTimeExtension on DateTime {
  DateTime get dateOnly => DateTime(year, month, day);

  DateTime get timeOnly => DateTime(0, 0, 0, hour, minute, second);

  String get dateText => DateFormat('yyyy-MM-dd').format(this);

  String get timeText => DateFormat('hh:mm a').format(this);

  bool isEqualOrBefore(DateTime date) {
    return dateOnly.isAtSameMomentAs(date.dateOnly) ||
        dateOnly.isBefore(date.dateOnly);
  }

  bool isEqualOrAfter(DateTime date) {
    return dateOnly.isAtSameMomentAs(date.dateOnly) ||
        dateOnly.isAfter(date.dateOnly);
  }
}

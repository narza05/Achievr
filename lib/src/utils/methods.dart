import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateTime getDateWithoutTime({DateTime? date}) {
  DateTime now = DateTime.now();
  return date != null
      ? DateTime(date.year, date.month, date.day)
      : DateTime(now.year, now.month, now.day);
}

String getFormattedDate({String? format, DateTime? date}) {
  return DateFormat(format ?? 'yyyy-MM-dd').format(date ?? DateTime.now());
}

TimeOfDay parseTime(String timeString) {
  final format = DateFormat.jm(); // e.g., 12:00 AM
  final dt = format.parse(timeString);
  return TimeOfDay(hour: dt.hour, minute: dt.minute);
}


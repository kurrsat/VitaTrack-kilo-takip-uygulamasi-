import 'package:flutter/material.dart';
class QuietHours {
  QuietHours({required this.startMinutes, required this.endMinutes});

  final int startMinutes;
  final int endMinutes;

  bool contains(DateTime time) {
    final minutes = time.hour * 60 + time.minute;
    if (startMinutes <= endMinutes) {
      return minutes >= startMinutes && minutes < endMinutes;
    }
    return minutes >= startMinutes || minutes < endMinutes;
  }

  DateTime nextAllowed(DateTime time) {
    if (!contains(time)) {
      return time;
    }
    final date = time.toLocal();
    final end = TimeOfDay(hour: endMinutes ~/ 60, minute: endMinutes % 60);
    var next = DateTime(date.year, date.month, date.day, end.hour, end.minute);
    if (startMinutes > endMinutes && time.hour * 60 + time.minute >= startMinutes) {
      next = next.add(const Duration(days: 1));
    }
    return next;
  }
}

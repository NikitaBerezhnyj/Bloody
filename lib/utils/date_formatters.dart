import 'package:flutter/material.dart';

String formatDate(DateTime d) =>
    "${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}";

String formatTime(TimeOfDay t) =>
    "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";

DateTime normalizeDate(DateTime date) =>
  DateTime(date.year, date.month, date.day);

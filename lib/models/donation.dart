import 'package:flutter/material.dart';

class Donation {
  final int? id;
  final DateTime date;
  final TimeOfDay time;
  final String type;
  final String feeling;
  final String notes;

  Donation({
    this.id,
    required this.date,
    required this.time,
    required this.type,
    this.feeling = '',
    this.notes = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'time': '${time.hour}:${time.minute}',
      'type': type,
      'feeling': feeling,
      'notes': notes,
    };
  }

  factory Donation.fromMap(Map<String, dynamic> map) {
    final timeParts = (map['time'] as String).split(':');
    return Donation(
      id: map['id'] as int?,
      date: DateTime.parse(map['date']),
      time: TimeOfDay(
        hour: int.parse(timeParts[0]),
        minute: int.parse(timeParts[1]),
      ),
      type: map['type'],
      feeling: map['feeling'] ?? '',
      notes: map['notes'] ?? '',
    );
  }
}
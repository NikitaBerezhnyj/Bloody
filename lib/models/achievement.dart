import 'package:flutter/material.dart';

class Achievement {
  final String id;
  final String title;
  final int? level;
  final bool achieved;
  final String? description;
  final IconData? icon;

  Achievement({
    required this.id,
    required this.title,
    this.level,
    required this.achieved,
    this.description,
    this.icon,
  });
}

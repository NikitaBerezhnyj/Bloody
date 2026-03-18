import 'package:flutter/material.dart';
import 'achievement.dart';

class AchievementCategory {
  final String name;
  final IconData icon;
  final List<Achievement> achievements;

  AchievementCategory({
    required this.name,
    required this.icon,
    required this.achievements,
  });
}
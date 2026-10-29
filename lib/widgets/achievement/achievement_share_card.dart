import 'package:flutter/material.dart';

class AchievementShareCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const AchievementShareCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: 800,
      height: 800,
      color: colorScheme.primary,
      padding: const EdgeInsets.all(64),
      child: Column(
        children: [
          Text(
            'Bloody',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimary,
            ),
          ),
          const Spacer(),
          Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 140, color: colorScheme.onPrimary),
          ),
          const SizedBox(height: 48),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              height: 1.3,
              color: colorScheme.onPrimary.withValues(alpha: 0.85),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

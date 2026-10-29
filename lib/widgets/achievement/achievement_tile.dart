import 'package:flutter/material.dart';
import 'achievement_dialog.dart';

class AchievementTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool achieved;
  final String description;

  const AchievementTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.achieved,
    this.description = "",
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final background = achieved
        ? colorScheme.primaryContainer
        : colorScheme.surfaceContainerHighest;
    final foreground = achieved
        ? colorScheme.onPrimaryContainer
        : colorScheme.onSurfaceVariant;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: achieved
          ? () => showDialog(
              context: context,
              builder: (_) => AchievementDialog(
                icon: icon,
                title: title,
                description: description,
              ),
            )
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 40, color: foreground),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: foreground,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: theme.textTheme.labelLarge?.copyWith(
              color: achieved
                  ? colorScheme.onSurface
                  : colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final bool showSettingsButton;
  final VoidCallback? onBack;
  final VoidCallback? onSettings;
  final Widget? action;

  const AppHeader({
    super.key,
    this.title,
    this.showBackButton = false,
    this.showSettingsButton = false,
    this.onBack,
    this.onSettings,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          if (showBackButton)
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBack ?? () => Navigator.pop(context),
            ),
          if (!showBackButton)
            Icon(Icons.opacity, color: colorScheme.primary, size: 36),
          const SizedBox(width: 8),
          Text(title ?? 'Bloody'),
        ],
      ),
      actions: [
        if (showSettingsButton)
          IconButton(icon: const Icon(Icons.settings), onPressed: onSettings),
        if (!showSettingsButton && action != null) action!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

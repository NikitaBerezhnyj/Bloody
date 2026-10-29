import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/common/status_screen.dart';

class ChangesSavedScreen extends StatelessWidget {
  const ChangesSavedScreen({super.key});

  void _onBackToDetails(BuildContext context) {
    Navigator.of(context)
      ..pop()
      ..pop();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return StatusScreen(
      icon: Icons.check_circle,
      iconColor: colorScheme.primary,
      title: t.changesSavedTitle,
      body: t.changesSavedBody,
      primaryLabel: t.backToDetails,
      onPrimaryPressed: () => _onBackToDetails(context),
    );
  }
}

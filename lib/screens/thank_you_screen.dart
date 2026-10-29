import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/unlocked_achievement.dart';
import '../services/achievement_service.dart';
import '../services/widget_prompt_service.dart';
import '../widgets/common/status_screen.dart';
import 'achievement_unlock_screen.dart';
import 'journal_screen.dart';

class ThankYouScreen extends StatelessWidget {
  final int? newDonationId;

  const ThankYouScreen({super.key, this.newDonationId});

  Future<void> _onGoToJournal(BuildContext context) async {
    final t = AppLocalizations.of(context)!;

    final newlyUnlocked = await AchievementService.getNewlyUnlocked(
      t,
      newDonationId,
    );

    if (!context.mounted) return;

    if (newlyUnlocked.isNotEmpty) {
      final unlocked = newlyUnlocked
          .map(
            (a) => UnlockedAchievement(
              title: a.title,
              description: a.description!,
              icon: a.icon ?? Icons.emoji_events,
            ),
          )
          .toList();

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AchievementUnlockScreen(achievements: unlocked),
        ),
      );

      if (!context.mounted) return;
    }

    await WidgetPromptService.markHasDonation();

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const JournalScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return StatusScreen(
      icon: Icons.favorite,
      iconColor: colorScheme.primary,
      title: t.thankYouTitle,
      body: t.thankYouBody,
      primaryLabel: t.goToJournal,
      onPrimaryPressed: () => _onGoToJournal(context),
    );
  }
}

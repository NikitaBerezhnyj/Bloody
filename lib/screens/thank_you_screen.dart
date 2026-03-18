import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/unlocked_achievement.dart';
import '../services/achievement_service.dart';
import '../services/widget_prompt_service.dart';
import '../widgets/common/button.dart';
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

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const JournalScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 2),
              const Icon(Icons.favorite, color: Colors.red, size: 80),
              const SizedBox(height: 24),
              Text(
                t.thankYouTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                t.thankYouBody,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 2),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  label: t.goToJournal,
                  onPressed: () => _onGoToJournal(context),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
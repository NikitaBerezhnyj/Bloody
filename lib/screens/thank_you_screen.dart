import 'package:bloody/screens/widget_prompt_screen.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/widget_prompt_service.dart';
import '../widgets/common/button.dart';
import 'journal_screen.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

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
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 2),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  label: t.goToJournal,
                  onPressed: () async {
                    if (!context.mounted) return;

                    final shouldShow = await WidgetPromptService.shouldShow();

                    if (shouldShow) {
                      await WidgetPromptService.markShown();
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const WidgetPromptScreen()),
                      );
                    }

                    if (!context.mounted) return;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const JournalScreen()),
                    );
                  },
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

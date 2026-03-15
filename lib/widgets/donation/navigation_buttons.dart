import 'package:flutter/material.dart';
import '../common/button.dart';
import '../../l10n/app_localizations.dart';

class NavigationButtons extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback? onNext;
  final VoidCallback? onBack;
  final VoidCallback? onSave;

  const NavigationButtons({
    required this.currentStep,
    required this.totalSteps,
    this.onNext,
    this.onBack,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final isLast = currentStep == totalSteps - 1;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Row(
        children: [
          if (onBack != null)
            Expanded(
              child: OutlineButton(
                label: t.back,
                onPressed: onBack,
              ),
            ),
          if (onBack != null) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: PrimaryButton(
              label: isLast ? t.saveDonation : t.next,
              onPressed: isLast ? onSave : onNext,
            ),
          ),
        ],
      ),
    );
  }
}
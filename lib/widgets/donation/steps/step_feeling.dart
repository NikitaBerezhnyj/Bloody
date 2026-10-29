import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/donation_labels.dart';
import '../selection_card.dart';
import '../step_wrapper.dart';

class StepFeeling extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onChanged;

  const StepFeeling({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return StepWrapper(
      title: t.feeling,
      child: Column(
        children: getFeelings(t).map((f) {
          final isSelected = selected == f.key;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SelectionCard(
              icon: f.icon,
              label: f.label,
              isSelected: isSelected,
              onTap: () => onChanged(f.key),
            ),
          );
        }).toList(),
      ),
    );
  }
}

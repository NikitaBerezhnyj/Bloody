import 'package:flutter/material.dart';
import '../../../constants/app_constants.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/donation_labels.dart';
import '../selection_card.dart';
import '../step_wrapper.dart';

class StepDonationType extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onChanged;

  const StepDonationType({super.key, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return StepWrapper(
      title: t.donationType,
      child: Column(
        children: donationTypes.map((key) {
          final isSelected = selected == key;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SelectionCard(
              icon: typeIcon(key),
              label: typeLabel(t, key),
              isSelected: isSelected,
              onTap: () => onChanged(key),
            ),
          );
        }).toList(),
      ),
    );
  }
}
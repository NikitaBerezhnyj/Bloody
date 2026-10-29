import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../l10n/app_localizations.dart';

String typeLabel(AppLocalizations t, String key) => {
  for (var k in donationTypes)
    k:
        {
          'donationWholeBlood': t.donationWholeBlood,
          'donationPlasma': t.donationPlasma,
          'donationPlatelets': t.donationPlatelets,
        }[k] ??
        k,
}[key]!;

IconData typeIcon(String key) => typeIcons[key] ?? Icons.bloodtype;

class Feeling {
  final String key;
  final String label;
  final IconData icon;

  const Feeling({required this.key, required this.label, required this.icon});
}

List<Feeling> getFeelings(AppLocalizations t) => [
  Feeling(
    key: 'feelingGood',
    label: t.feelingGood,
    icon: Icons.sentiment_satisfied_rounded,
  ),
  Feeling(
    key: 'feelingNormal',
    label: t.feelingNormal,
    icon: Icons.sentiment_neutral_rounded,
  ),
  Feeling(
    key: 'feelingTired',
    label: t.feelingTired,
    icon: Icons.sentiment_dissatisfied_rounded,
  ),
];

String feelingLabel(AppLocalizations t, String key) => getFeelings(t)
    .firstWhere(
      (f) => f.key == key,
      orElse: () =>
          Feeling(key: key, label: key, icon: Icons.sentiment_neutral_rounded),
    )
    .label;

IconData feelingIcon(String key) => switch (key) {
  'feelingGood' => Icons.sentiment_satisfied_rounded,
  'feelingNormal' => Icons.sentiment_neutral_rounded,
  'feelingTired' => Icons.sentiment_dissatisfied_rounded,
  _ => Icons.sentiment_neutral_rounded,
};

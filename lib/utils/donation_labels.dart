import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../l10n/app_localizations.dart';

String typeLabel(AppLocalizations t, String key) =>
    {
      for (var k in donationTypes) k: {
        'donationWholeBlood': t.donationWholeBlood,
        'donationPlasma': t.donationPlasma,
        'donationPlatelets': t.donationPlatelets,
      }[k] ?? k
    }[key]!;

IconData typeIcon(String key) => typeIcons[key] ?? Icons.bloodtype;

class Feeling {
  final String key;
  final String label;
  final String emoji;

  const Feeling({required this.key, required this.label, required this.emoji});
}

List<Feeling> getFeelings(AppLocalizations t) => [
  Feeling(key: 'feelingGood', label: t.feelingGood, emoji: '😃'),
  Feeling(key: 'feelingNormal', label: t.feelingNormal, emoji: '😐'),
  Feeling(key: 'feelingTired', label: t.feelingTired, emoji: '😔'),
];

String feelingLabel(AppLocalizations t, String key) =>
    getFeelings(t).firstWhere(
          (f) => f.key == key,
      orElse: () => Feeling(key: key, label: key, emoji: ''),
    ).label;

String feelingEmoji(AppLocalizations t, String key) =>
    getFeelings(t).firstWhere(
          (f) => f.key == key,
      orElse: () => Feeling(key: key, label: key, emoji: ''),
    ).emoji;

String feelingLabelWithEmoji(AppLocalizations t, String key) =>
    '${feelingEmoji(t, key)} ${feelingLabel(t, key)}';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

String translateType(AppLocalizations t, String key) {
  switch (key) {
    case 'donationWholeBlood':
      return t.donationWholeBlood;
    case 'donationPlasma':
      return t.donationPlasma;
    case 'donationPlatelets':
      return t.donationPlatelets;
    default:
      return key;
  }
}

String translateFeeling(AppLocalizations t, String key) {
  switch (key) {
    case 'feelingGood':
      return '😃 ${t.feelingGood}';
    case 'feelingNormal':
      return '😐 ${t.feelingNormal}';
    case 'feelingTired':
      return '😔 ${t.feelingTired}';
    default:
      return key;
  }
}

IconData typeIcon(String key) {
  switch (key) {
    case 'donationWholeBlood':
      return Icons.bloodtype;
    case 'donationPlasma':
      return Icons.opacity;
    case 'donationPlatelets':
      return Icons.healing;
    default:
      return Icons.bloodtype;
  }
}
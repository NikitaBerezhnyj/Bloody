import 'package:flutter/material.dart';

const Map<String, String> bloodTypeGroups = {
  '0+': 'I+',
  '0-': 'I-',
  'A+': 'II+',
  'A-': 'II-',
  'B+': 'III+',
  'B-': 'III-',
  'AB+': 'IV+',
  'AB-': 'IV-',
};

List<String> get bloodTypes => bloodTypeGroups.keys.toList();

String bloodTypeLabel(String bloodType) =>
    '$bloodType (${bloodTypeGroups[bloodType]})';

const List<String> feelingKeys = [
  'feelingGood',
  'feelingNormal',
  'feelingTired',
];

const List<String> donationTypes = [
  'donationWholeBlood',
  'donationPlasma',
  'donationPlatelets',
];

const Map<String, int> donationCooldownDays = {
  "donationWholeBlood": 60,
  "donationPlasma": 30,
  "donationPlatelets": 14,
};

const typeIcons = {
  'donationWholeBlood': Icons.bloodtype,
  'donationPlasma': Icons.opacity,
  'donationPlatelets': Icons.healing,
};

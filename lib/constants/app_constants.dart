import 'package:flutter/material.dart';

const List<String> bloodTypes = ["A+", "A-", "B+", "B-", "AB+", "AB-", "0+", "0-"];
const List<String> feelingKeys = ['feelingGood', 'feelingNormal', 'feelingTired'];
const List<String> donationTypes = ['donationWholeBlood', 'donationPlasma', 'donationPlatelets'];

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
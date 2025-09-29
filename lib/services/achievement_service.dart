import 'package:flutter/material.dart';
import '../models/donation.dart';
import 'donation_service.dart';
import '../l10n/app_localizations.dart';

class AchievementService {
  static const List<int> levels = [1, 3, 5, 10, 25, 50, 100];

  static Future<Map<String, AchievementCategory>> getAchievements(AppLocalizations t) async {
    final donations = await DonationService.getDonations();
    final totalDonations = donations.length;

    final Map<String, List<Donation>> donationsByType = {
      'wholeBlood': donations.where((d) => d.type == 'donationWholeBlood').toList(),
      'plasma': donations.where((d) => d.type == 'donationPlasma').toList(),
      'platelets': donations.where((d) => d.type == 'donationPlatelets').toList(),
    };

    final Map<String, AchievementCategory> achievements = {};

    achievements['wholeBlood'] = AchievementCategory(
      name: t.donationWholeBlood,
      icon: Icons.bloodtype,
      achievements: _buildAchievementsForType(
        donationsByType['wholeBlood']!.length,
        'wholeBlood',
        t,
      ),
    );

    achievements['plasma'] = AchievementCategory(
      name: t.donationPlasma,
      icon: Icons.opacity,
      achievements: _buildAchievementsForType(
        donationsByType['plasma']!.length,
        'plasma',
        t,
      ),
    );

    achievements['platelets'] = AchievementCategory(
      name: t.donationPlatelets,
      icon: Icons.healing,
      achievements: _buildAchievementsForType(
        donationsByType['platelets']!.length,
        'platelets',
        t,
      ),
    );

    achievements['total'] = AchievementCategory(
      name: t.achievementTotalTitle,
      icon: Icons.star,
      achievements: _buildAchievementsForType(
        totalDonations,
        'total',
        t,
      ),
    );

    return achievements;
  }

  static List<Achievement> _buildAchievementsForType(
      int count,
      String type,
      AppLocalizations t,
      ) {
    return levels.map((level) {
      return Achievement(
        title: _getAchievementTitle(t, type, level),
        level: level,
        achieved: count >= level,
      );
    }).toList();
  }

  static String _getAchievementTitle(AppLocalizations t, String type, int level) {
    switch (type) {
      case 'wholeBlood':
        switch (level) {
          case 1: return t.achievementWholeBlood1;
          case 3: return t.achievementWholeBlood3;
          case 5: return t.achievementWholeBlood5;
          case 10: return t.achievementWholeBlood10;
          case 25: return t.achievementWholeBlood25;
          case 50: return t.achievementWholeBlood50;
          case 100: return t.achievementWholeBlood100;
        }
        break;
      case 'plasma':
        switch (level) {
          case 1: return t.achievementPlasma1;
          case 3: return t.achievementPlasma3;
          case 5: return t.achievementPlasma5;
          case 10: return t.achievementPlasma10;
          case 25: return t.achievementPlasma25;
          case 50: return t.achievementPlasma50;
          case 100: return t.achievementPlasma100;
        }
        break;
      case 'platelets':
        switch (level) {
          case 1: return t.achievementPlatelets1;
          case 3: return t.achievementPlatelets3;
          case 5: return t.achievementPlatelets5;
          case 10: return t.achievementPlatelets10;
          case 25: return t.achievementPlatelets25;
          case 50: return t.achievementPlatelets50;
          case 100: return t.achievementPlatelets100;
        }
        break;
      case 'total':
        switch (level) {
          case 1: return t.achievementTotal1;
          case 3: return t.achievementTotal3;
          case 5: return t.achievementTotal5;
          case 10: return t.achievementTotal10;
          case 25: return t.achievementTotal25;
          case 50: return t.achievementTotal50;
          case 100: return t.achievementTotal100;
        }
        break;
    }
    return '';
  }
}

class AchievementCategory {
  final String name;
  final IconData icon;
  final List<Achievement> achievements;

  AchievementCategory({
    required this.name,
    required this.icon,
    required this.achievements,
  });
}

class Achievement {
  final String title;
  final int level;
  final bool achieved;

  Achievement({
    required this.title,
    required this.level,
    required this.achieved,
  });
}
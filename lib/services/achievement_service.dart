import 'package:flutter/material.dart';
import '../models/donation.dart';
import '../models/user.dart';
import 'donation_service.dart';
import 'user_service.dart';
import '../l10n/app_localizations.dart';

class AchievementService {
  static const List<int> levels = [1, 3, 5, 10, 25, 50, 100];

  static final List<DateTime> holidays = [
    DateTime(DateTime.now().year, 1, 1), // Новий рік
    DateTime(DateTime.now().year, 3, 8), // Міжнародний жіночий день
    DateTime(DateTime.now().year, 6, 14), // Всесвітній день донора крові
    DateTime(DateTime.now().year, 12, 25), // Різдво
  ];

  static Future<Map<String, AchievementCategory>> getAchievements(
      AppLocalizations t) async {
    final donations = await DonationService.getDonations();
    final user = await UserService.getUser();

    final Map<String, List<Donation>> donationsByType = {
      'wholeBlood':
      donations.where((d) => d.type == 'donationWholeBlood').toList(),
      'plasma': donations.where((d) => d.type == 'donationPlasma').toList(),
      'platelets':
      donations.where((d) => d.type == 'donationPlatelets').toList(),
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

    achievements['other'] = AchievementCategory(
      name: t.achievementOtherTitle,
      icon: Icons.emoji_events,
      achievements: _buildSpecialAchievements(
        donations,
        donationsByType,
        user,
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
        description: null,
      );
    }).toList();
  }

  static List<Achievement> _buildSpecialAchievements(
      List<Donation> donations,
      Map<String, List<Donation>> donationsByType,
      User? user,
      AppLocalizations t,
      ) {
    final achievements = <Achievement>[];

    final hasProfile = user != null;
    achievements.add(Achievement(
      title: t.achievementFirstStep,
      achieved: hasProfile,
      description: t.achievementFirstStepDescription,
      icon: Icons.person_add,
    ));

    final hasWholeBlood = donationsByType['wholeBlood']!.isNotEmpty;
    final hasPlasma = donationsByType['plasma']!.isNotEmpty;
    final hasPlatelets = donationsByType['platelets']!.isNotEmpty;
    final isUniversal = hasWholeBlood && hasPlasma && hasPlatelets;

    achievements.add(Achievement(
      title: t.achievementUniversal,
      achieved: isUniversal,
      description: t.achievementUniversalDescription,
      icon: Icons.all_inclusive,
    ));

    final hasHolidayDonation = donations.any((donation) {
      final donationDate = donation.date;
      return holidays.any((holiday) =>
      holiday.year == donationDate.year &&
          holiday.month == donationDate.month &&
          holiday.day == donationDate.day);
    });

    achievements.add(Achievement(
      title: t.achievementHolidayDonor,
      achieved: hasHolidayDonation,
      description: t.achievementHolidayDonorDescription,
      icon: Icons.celebration,
    ));

    return achievements;
  }

  static String _getAchievementTitle(
      AppLocalizations t, String type, int level) {
    switch (type) {
      case 'wholeBlood':
        switch (level) {
          case 1:
            return t.achievementWholeBlood1;
          case 3:
            return t.achievementWholeBlood3;
          case 5:
            return t.achievementWholeBlood5;
          case 10:
            return t.achievementWholeBlood10;
          case 25:
            return t.achievementWholeBlood25;
          case 50:
            return t.achievementWholeBlood50;
          case 100:
            return t.achievementWholeBlood100;
        }
        break;
      case 'plasma':
        switch (level) {
          case 1:
            return t.achievementPlasma1;
          case 3:
            return t.achievementPlasma3;
          case 5:
            return t.achievementPlasma5;
          case 10:
            return t.achievementPlasma10;
          case 25:
            return t.achievementPlasma25;
          case 50:
            return t.achievementPlasma50;
          case 100:
            return t.achievementPlasma100;
        }
        break;
      case 'platelets':
        switch (level) {
          case 1:
            return t.achievementPlatelets1;
          case 3:
            return t.achievementPlatelets3;
          case 5:
            return t.achievementPlatelets5;
          case 10:
            return t.achievementPlatelets10;
          case 25:
            return t.achievementPlatelets25;
          case 50:
            return t.achievementPlatelets50;
          case 100:
            return t.achievementPlatelets100;
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
  final int? level;
  final bool achieved;
  final String? description;
  final IconData? icon;

  Achievement({
    required this.title,
    this.level,
    required this.achieved,
    this.description,
    this.icon,
  });
}

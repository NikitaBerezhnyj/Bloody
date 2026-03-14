import '../models/donation.dart';
import '../services/user_service.dart';

class CalculationService {
  static const Map<String, int> donationCooldownDays = {
    "donationWholeBlood": 60,
    "donationPlasma": 30,
    "donationPlatelets": 14,
  };

  static const int maxWholeBloodMale = 5;
  static const int maxWholeBloodFemale = 4;
  static const int maxAgeForDonation = 65;

  static const String wholeBloodType = "donationWholeBlood";

  static Future<int> calculateDaysLeft(List<Donation> donations) async {
    if (donations.isEmpty) return 0;

    final user = await UserService.getUser();
    if (user == null) return 0;

    final now = DateTime.now();

    donations.sort((a, b) => b.date.compareTo(a.date));
    final lastDonation = donations.first;

    final cooldownDays =
        donationCooldownDays[lastDonation.type] ?? 60;

    final nextByType =
    lastDonation.date.add(Duration(days: cooldownDays));

    final oneYearAgo = now.subtract(const Duration(days: 365));

    final wholeBloodDonations = donations
        .where((d) =>
    d.type == wholeBloodType &&
        d.date.isAfter(oneYearAgo))
        .toList();

    final maxWholeBlood = user.gender == 'female'
        ? maxWholeBloodFemale
        : maxWholeBloodMale;

    DateTime? nextByYearLimit;

    if (wholeBloodDonations.length >= maxWholeBlood) {
      final oldest = wholeBloodDonations.reduce(
            (a, b) => a.date.isBefore(b.date) ? a : b,
      );

      nextByYearLimit =
          oldest.date.add(const Duration(days: 365));
    }

    final candidateDates = [nextByType];

    if (nextByYearLimit != null) {
      candidateDates.add(nextByYearLimit);
    }

    final nextPossibleDate =
    candidateDates.reduce((a, b) => a.isAfter(b) ? a : b);

    final daysLeft = nextPossibleDate.difference(now).inDays;

    return daysLeft > 0 ? daysLeft : 0;
  }
}
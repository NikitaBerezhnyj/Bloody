import '../models/donation.dart';
import '../services/user_service.dart';

class CalculationService {
  static const Map<String, int> donationCooldownDays = {
    "donationWholeBlood": 60,
    "donationPlasma": 30,
    "donationPlatelets": 14,
  };

  static const int maxDonationsPerYearMale = 5;
  static const int maxDonationsPerYearFemale = 4;

  static Future<int> calculateDaysLeft(List<Donation> donations) async {
    if (donations.isEmpty) return 0;

    donations.sort((a, b) => b.date.compareTo(a.date));
    final lastDonation = donations.first;

    final user = await UserService.getUser();
    final gender = user?.gender ?? 'male';
    final now = DateTime.now();

    final cooldownDays = donationCooldownDays[lastDonation.type] ?? 60;
    final nextPossibleDateByType = lastDonation.date.add(Duration(days: cooldownDays));

    final oneYearAgo = now.subtract(const Duration(days: 365));
    final recentDonations = donations.where((d) => d.date.isAfter(oneYearAgo)).toList();
    int maxDonations = gender == 'female' ? maxDonationsPerYearFemale : maxDonationsPerYearMale;

    DateTime? nextPossibleDateByCount;
    if (recentDonations.length >= maxDonations) {
      final firstDonation = recentDonations.reduce((a, b) => a.date.isBefore(b.date) ? a : b);
      nextPossibleDateByCount = firstDonation.date.add(const Duration(days: 365));
    }

    final candidateDates = [nextPossibleDateByType];
    if (nextPossibleDateByCount != null) candidateDates.add(nextPossibleDateByCount);

    final nextPossibleDate = candidateDates.reduce(
            (a, b) => a.isAfter(b) ? a : b);

    final daysLeft = nextPossibleDate.difference(now).inDays;
    return daysLeft > 0 ? daysLeft : 0;
  }
}

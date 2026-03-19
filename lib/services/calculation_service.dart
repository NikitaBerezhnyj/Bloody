import '../constants/app_constants.dart';
import '../models/donation.dart';
import '../services/user_service.dart';
import '../utils/date_formatters.dart';

class CalculationService {
  static const int maxWholeBloodMale = 5;
  static const int maxWholeBloodFemale = 4;
  static const int maxAgeForDonation = 65;

  static const String wholeBloodType = "donationWholeBlood";

  static Future<int> calculateDaysLeft(List<Donation> donations) async {
    if (donations.isEmpty) return 0;

    final user = await UserService.getUser();
    if (user == null) return 0;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    donations.sort((a, b) => b.date.compareTo(a.date));
    final lastDonation = donations.first;
    final lastDate = normalizeDate(lastDonation.date);

    final cooldownDays = donationCooldownDays[lastDonation.type] ?? 60;

    final nextByType = lastDate.add(Duration(days: cooldownDays));

    final oneYearAgo = today.subtract(const Duration(days: 365));

    final wholeBloodDonations = donations
        .where((d) =>
          d.type == wholeBloodType &&
          normalizeDate(d.date).isAfter(oneYearAgo))
        .toList();

    final maxWholeBlood = user.gender == 'female'
        ? maxWholeBloodFemale
        : maxWholeBloodMale;

    DateTime? nextByYearLimit;

    if (wholeBloodDonations.length >= maxWholeBlood) {
      final oldest = wholeBloodDonations.reduce(
            (a, b) => normalizeDate(a.date).isBefore(b.date) ? a : b,
      );

      nextByYearLimit =
          normalizeDate(oldest.date).add(const Duration(days: 365));
    }

    final candidateDates = [nextByType];

    if (nextByYearLimit != null) {
      candidateDates.add(nextByYearLimit);
    }

    final nextPossibleDate =
    candidateDates.reduce((a, b) => a.isAfter(b) ? a : b);

    final daysLeft = nextPossibleDate.difference(today).inDays;

    return daysLeft > 0 ? daysLeft : 0;
  }
}
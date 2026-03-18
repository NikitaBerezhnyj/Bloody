import '../utils/date_formatters.dart';
import 'donation.dart';

class DonationStats {
  final int total;
  final int wholeBlood;
  final int plasma;
  final int platelets;
  final int avgIntervalDays;
  final String lastDonationDate;
  final int daysSinceLast;
  final List<int> availableYears;

  const DonationStats({
    required this.total,
    required this.wholeBlood,
    required this.plasma,
    required this.platelets,
    required this.avgIntervalDays,
    required this.lastDonationDate,
    required this.daysSinceLast,
    required this.availableYears,
  });

  factory DonationStats.from(List<Donation> donations) =>
      _compute(donations, donations);

  factory DonationStats.forYear(List<Donation> all, int year) =>
      _compute(all.where((d) => d.date.year == year).toList(), all);

  static DonationStats _compute(
      List<Donation> donations,
      List<Donation> all,
      ) {
    final now        = DateTime.now();
    final total      = donations.length;
    final wholeBlood = donations.where((d) => d.type == 'donationWholeBlood').length;
    final plasma     = donations.where((d) => d.type == 'donationPlasma').length;
    final platelets  = donations.where((d) => d.type == 'donationPlatelets').length;
    final years      = all.map((d) => d.date.year).toSet().toList()..sort();

    int avg = 0;
    if (donations.length >= 2) {
      final sorted = [...donations]..sort((a, b) => a.date.compareTo(b.date));
      int sum = 0;
      for (int i = 1; i < sorted.length; i++) {
        sum += sorted[i].date.difference(sorted[i - 1].date).inDays;
      }
      avg = sum ~/ (sorted.length - 1);
    }

    final last = all.first;
    final lastDate = formatDate(last.date);

    return DonationStats(
      total: total,
      wholeBlood: wholeBlood,
      plasma: plasma,
      platelets: platelets,
      avgIntervalDays: avg,
      lastDonationDate: lastDate,
      daysSinceLast: now.difference(last.date).inDays,
      availableYears: years,
    );
  }
}
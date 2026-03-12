import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/donation.dart';
import '../services/donation_service.dart';
import '../services/notification_service.dart';

class DonationsNotifier extends AsyncNotifier<List<Donation>> {
  @override
  Future<List<Donation>> build() => DonationService.getDonations();

  Future<void> add(Donation donation) async {
    await DonationService.addDonation(donation);
    ref.invalidateSelf();
    await _reschedule();
  }

  Future<void> edit(Donation donation) async {
    await DonationService.updateDonation(donation);
    ref.invalidateSelf();
    await _reschedule();
  }

  Future<void> delete(int id) async {
    await DonationService.deleteDonation(id);
    ref.invalidateSelf();
    await _reschedule();
  }

  Future<void> _reschedule() async {
    final donations = await DonationService.getDonations();
    await NotificationService.rescheduleAll(donations);
  }
}

final donationsProvider =
AsyncNotifierProvider<DonationsNotifier, List<Donation>>(
  DonationsNotifier.new,
);
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/donation.dart';
import '../services/donation_service.dart';

class DonationsNotifier extends AsyncNotifier<List<Donation>> {
  @override
  Future<List<Donation>> build() => DonationService.getDonations();

  Future<void> add(Donation donation) async {
    await DonationService.addDonation(donation);
    ref.invalidateSelf();
  }

  Future<void> edit(Donation donation) async {
    await DonationService.updateDonation(donation);
    ref.invalidateSelf();
  }

  Future<void> delete(int id) async {
    await DonationService.deleteDonation(id);
    ref.invalidateSelf();
  }
}

final donationsProvider =
AsyncNotifierProvider<DonationsNotifier, List<Donation>>(
  DonationsNotifier.new,
);
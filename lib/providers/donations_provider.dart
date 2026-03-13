import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/donation.dart';
import '../services/donation_service.dart';
import '../services/notification_service.dart';
import '../services/widget_service.dart';

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
    final current = state.valueOrNull;
    if (current != null) {
      state = AsyncData(current.where((d) => d.id != id).toList());
    }

    await DonationService.deleteDonation(id);
    await _reschedule();
  }

  Future<void> _reschedule() async {
    final donations = await DonationService.getDonations();
    await NotificationService.rescheduleAll(donations);
    final locale = await _getLocale();
    await WidgetService.updateWidget(donations: donations, locale: locale);
  }

  Future<String> _getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('locale') ?? 'uk';
  }
}

final donationsProvider =
AsyncNotifierProvider<DonationsNotifier, List<Donation>>(
  DonationsNotifier.new,
);
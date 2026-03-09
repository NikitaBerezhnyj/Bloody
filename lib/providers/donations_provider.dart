import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/donation.dart';
import '../services/donation_service.dart';

final donationsProvider = FutureProvider<List<Donation>>((ref) async {
  final list = await DonationService.getDonations();
  return list.cast<Donation>();
});
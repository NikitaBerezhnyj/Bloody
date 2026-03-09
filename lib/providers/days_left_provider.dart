import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'donations_provider.dart';
import '../services/calculation_service.dart';

final daysLeftProvider = FutureProvider<int>((ref) async {
  final donations = await ref.watch(donationsProvider.future);
  return CalculationService.calculateDaysLeft(donations);
});
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../models/achievement_category.dart';
import '../services/achievement_service.dart';
import '../l10n/app_localizations.dart';
import 'donations_provider.dart';

final achievementsProvider =
FutureProvider.family<Map<String, AchievementCategory>, String>((ref, localeCode) async {
  ref.watch(donationsProvider);
  final locale = Locale(localeCode);
  final t = await AppLocalizations.delegate.load(locale);
  return AchievementService.getAchievements(t);
});
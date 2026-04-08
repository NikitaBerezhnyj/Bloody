import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/donation_service.dart';
import '../services/notification_service.dart';
import '../services/widget_service.dart';

class LocaleNotifier extends AsyncNotifier<Locale?> {
  @override
  Future<Locale> build() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('locale');

    if (saved != null) {
      return Locale(saved);
    }

    const supported = ['uk', 'es', 'en'];
    final systemCode = PlatformDispatcher.instance.locale.languageCode;
    final resolved = supported.contains(systemCode) ? systemCode : 'en';

    await prefs.setString('locale', resolved);

    return Locale(resolved);
  }

  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    final oldLocale = prefs.getString('locale');

    if (oldLocale == locale.languageCode) return;

    await prefs.setString('locale', locale.languageCode);

    state = AsyncData(locale);

    final donations = await DonationService.getDonations();

    await NotificationService.rescheduleLocale(
      donations: donations,
      locale: locale.languageCode,
    );

    await WidgetService.updateWidget(
      donations: donations,
      locale: locale.languageCode,
    );
  }

  String _resolveSystemLocale() {
    const supported = ['uk', 'es', 'en'];
    final systemCode = PlatformDispatcher.instance.locale.languageCode;
    return supported.contains(systemCode) ? systemCode : 'en';
  }
}

final localeProvider = AsyncNotifierProvider<LocaleNotifier, Locale?>(
  LocaleNotifier.new,
);
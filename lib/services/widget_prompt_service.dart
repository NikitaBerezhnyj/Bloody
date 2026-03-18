import 'package:shared_preferences/shared_preferences.dart';

class WidgetPromptService {
  static const _shownKey = 'widget_prompt_shown';
  static const _hasDonationKey = 'widget_prompt_has_donation';

  static Future<void> markHasDonation() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasDonationKey, true);
  }

  static Future<bool> shouldShow() async {
    final prefs = await SharedPreferences.getInstance();
    final alreadyShown = prefs.getBool(_shownKey) ?? false;
    final hasDonation = prefs.getBool(_hasDonationKey) ?? false;
    return hasDonation && !alreadyShown;
  }

  static Future<void> markShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_shownKey, true);
  }

  static Future<void> cleanShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_shownKey);
    await prefs.remove(_hasDonationKey);
  }
}
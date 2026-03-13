import 'package:shared_preferences/shared_preferences.dart';

class WidgetPromptService {
  static const _key = 'widget_prompt_shown_count';
  static const _maxShown = 2;

  static Future<bool> shouldShow() async {
    final prefs = await SharedPreferences.getInstance();
    final count = prefs.getInt(_key) ?? 0;
    return count < _maxShown;
  }

  static Future<void> markShown() async {
    final prefs = await SharedPreferences.getInstance();
    final count = prefs.getInt(_key) ?? 0;
    await prefs.setInt(_key, count + 1);
  }

  static Future<void> cleanShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
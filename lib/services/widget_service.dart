import 'package:home_widget/home_widget.dart';
import '../models/donation.dart';
import 'calculation_service.dart';

class WidgetService {
  static const _appGroupId = 'com.nikitaberezhnyj.bloody';
  static const _widgetName = 'BloodyWidget';

  static Future<void> updateWidget({
    required List<Donation> donations,
    required String locale,
  }) async {
    await HomeWidget.setAppGroupId(_appGroupId);

    String daysText;
    String labelText;
    bool showIcon;

    if (donations.isEmpty) {
      showIcon = true;
      daysText = '';
      labelText = _canDonateNow(locale);
    } else {
      final daysLeft = await CalculationService.calculateDaysLeft(donations);

      if (daysLeft <= 0) {
        showIcon = true;
        daysText = '';
        labelText = _canDonateNow(locale);
      } else {
        showIcon = false;
        daysText = '$daysLeft';
        labelText =
        daysLeft == 1 ? _oneDayLeft(locale) : _daysLeft(locale);
      }
    }

    await HomeWidget.saveWidgetData('widget_days_text', daysText);
    await HomeWidget.saveWidgetData('widget_label_text', labelText);
    await HomeWidget.saveWidgetData('widget_show_icon', showIcon);

    await HomeWidget.updateWidget(androidName: _widgetName);
  }

  static String _canDonateNow(String locale) {
    return _translations['canDonateNow']?[locale] ?? _translations['canDonateNow']!['en']!;
  }

  static String _oneDayLeft(String locale) {
    return _translations['oneDayLeft']?[locale] ?? _translations['oneDayLeft']!['en']!;
  }

  static String _daysLeft(String locale) {
    return _translations['daysLeft']?[locale] ?? _translations['daysLeft']!['en']!;
  }

  static const Map<String, Map<String, String>> _translations = {
    'canDonateNow': {
      'en': 'you can donate now',
      'uk': 'можна здавати кров',
      'es': 'puedes donar sangre',
    },
    'oneDayLeft': {
      'en': 'day until your next\ndonation',
      'uk': 'день до наступної\nдонації',
      'es': 'día hasta la próxima\ndonación',
    },
    'daysLeft': {
      'en': 'days until your next\ndonation',
      'uk': 'днів до наступної\nдонації',
      'es': 'días hasta la próxima\ndonación',
    },
  };
}
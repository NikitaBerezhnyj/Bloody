import 'package:home_widget/home_widget.dart';
import '../models/donation.dart';

class WidgetService {
  static const _appGroupId = 'com.nikitaberezhnyj.bloody';
  static const _widgetName = 'BloodyWidget';

  static const Map<String, int> _cooldownDays = {
    'donationWholeBlood': 60,
    'donationPlasma': 14,
    'donationPlatelets': 14,
  };

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
      final last = donations.first;
      final cooldown = _cooldownDays[last.type] ?? 60;

      final lastDt = DateTime(last.date.year, last.date.month, last.date.day);

      final canDonateOn = lastDt.add(Duration(days: cooldown));

      final today = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      );

      final diff = canDonateOn.difference(today).inDays;

      if (diff <= 0) {
        showIcon = true;
        daysText = '';
        labelText = _canDonateNow(locale);
      } else {
        showIcon = false;
        daysText = '$diff';
        labelText = diff == 1 ? _oneDayLeft(locale) : _daysLeft(locale);
      }
    }

    await HomeWidget.saveWidgetData('widget_days_text', daysText);
    await HomeWidget.saveWidgetData('widget_label_text', labelText);
    await HomeWidget.saveWidgetData('widget_show_icon', showIcon);

    await HomeWidget.updateWidget(androidName: _widgetName);
  }

  static String _canDonateNow(String locale) {
    switch (locale) {
      case 'uk':
        return 'можна здавати кров';
      case 'es':
        return 'puedes donar sangre';
      default:
        return 'you can donate now';
    }
  }

  static String _oneDayLeft(String locale) {
    switch (locale) {
      case 'uk':
        return 'день до наступної\nдонації';
      case 'es':
        return 'día hasta la próxima\ndonación';
      default:
        return 'day until your next\ndonation';
    }
  }

  static String _daysLeft(String locale) {
    switch (locale) {
      case 'uk':
        return 'днів до наступної\nдонації';
      case 'es':
        return 'días hasta la próxima\ndonación';
      default:
        return 'days until your next\ndonation';
    }
  }
}

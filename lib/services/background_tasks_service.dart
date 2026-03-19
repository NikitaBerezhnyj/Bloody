import 'package:workmanager/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'donation_service.dart';
import 'widget_service.dart';

const widgetUpdateTask = 'widgetUpdateTask';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName == widgetUpdateTask) {
      try {
        final donations = await DonationService.getDonations();
        final prefs = await SharedPreferences.getInstance();
        final locale = prefs.getString('locale') ?? 'uk';
        await WidgetService.updateWidget(
          donations: donations,
          locale: locale,
        );
      } catch (e) {
        return false;
      }
    }
    return true;
  });
}
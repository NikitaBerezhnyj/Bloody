import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import '../models/donation.dart';

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  // cooldown в днях залежно від типу донації
  static const Map<String, int> _cooldownDays = {
    'donationWholeBlood': 60,
    'donationPlasma':     14,
    'donationPlatelets':  14,
  };

  static Future<void> init() async {
    tz_data.initializeTimeZones();
    tz.setLocalLocation(tz.local);

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios     = DarwinInitializationSettings();
    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );

    // запит дозволу на Android 13+
    await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  // ─── Головний метод — викликати після add/edit/delete ─────────────────────

  static Future<void> rescheduleAll(List<Donation> donations) async {
    await _plugin.cancelAll();

    if (donations.isEmpty) return;

    // беремо останню донацію (вже відсортовано по даті DESC)
    final last = donations.first;
    final cooldown = _cooldownDays[last.type] ?? 60;

    final lastDateTime = DateTime(
      last.date.year, last.date.month, last.date.day,
      last.time.hour, last.time.minute,
    );
    final cooldownDate = lastDateTime.add(Duration(days: cooldown));

    // плануємо 4 нотифікації
    await _scheduleIfFuture(
      id: 1,
      title: 'Незабаром можна донувати',
      body: 'Завтра ви знову зможете здати кров.',
      scheduledDate: cooldownDate.subtract(const Duration(days: 1)),
    );
    await _scheduleIfFuture(
      id: 2,
      title: 'Сьогодні можна донувати',
      body: 'Сьогодні ви можете знову здати кров.',
      scheduledDate: cooldownDate,
    );
    await _scheduleIfFuture(
      id: 3,
      title: 'Ви вже можете донувати',
      body: 'Ви вже можете донувати кров. Можливо, настав час запланувати наступну донацію.',
      scheduledDate: cooldownDate.add(const Duration(days: 5)),
    );
    await _scheduleIfFuture(
      id: 4,
      title: 'Давно не було донацій',
      body: 'Давно не було донацій. Можливо, настав час допомогти знову.',
      scheduledDate: cooldownDate.add(const Duration(days: 100)),
    );
  }

  // ─── Приватні методи ───────────────────────────────────────────────────────

  static Future<void> _scheduleIfFuture({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    // не плануємо нотифікації в минулому
    if (scheduledDate.isBefore(DateTime.now())) return;

    final tzDate = tz.TZDateTime.from(scheduledDate, tz.local);

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tzDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'donation_reminders',
          'Нагадування про донацію',
          channelDescription: 'Нагадування про можливість наступної донації',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
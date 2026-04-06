import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import '../constants/app_constants.dart';
import '../constants/notification_strings.dart';
import '../models/donation.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz_data.initializeTimeZones();
    String localTimezone = await FlutterTimezone.getLocalTimezone();

    if (localTimezone == 'Europe/Kiev') {
      localTimezone = 'Europe/Kyiv';
    }

    try {
      tz.setLocalLocation(tz.getLocation(localTimezone));
    } catch (_) {
      tz.setLocalLocation(tz.UTC);
    }

    const android = AndroidInitializationSettings('@drawable/ic_notification');
    const ios = DarwinInitializationSettings();
    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  static Future<void> rescheduleAll(
    List<Donation> donations,
    String locale,
  ) async {
    await _plugin.cancelAll();
    if (donations.isEmpty) return;

    final last = donations.first;
    final cooldown = donationCooldownDays[last.type] ?? 60;

    final lastDateTime = DateTime(
      last.date.year,
      last.date.month,
      last.date.day,
      last.time.hour,
      last.time.minute,
    );

    final rawCooldownDate = lastDateTime.add(Duration(days: cooldown));

    final cooldownDate = DateTime(
      rawCooldownDate.year,
      rawCooldownDate.month,
      rawCooldownDate.day,
      11,
      30,
    );

    await _scheduleIfFuture(
      id: 1,
      title: NotificationStrings.get('soonTitle', locale),
      body: NotificationStrings.get('soonBody', locale),
      scheduledDate: cooldownDate.subtract(const Duration(days: 1)),
      channelName: NotificationStrings.get('channelName', locale),
      channelDescription: NotificationStrings.get('channelDescription', locale),
    );
    await _scheduleIfFuture(
      id: 2,
      title: NotificationStrings.get('todayTitle', locale),
      body: NotificationStrings.get('todayBody', locale),
      scheduledDate: cooldownDate,
      channelName: NotificationStrings.get('channelName', locale),
      channelDescription: NotificationStrings.get('channelDescription', locale),
    );
    await _scheduleIfFuture(
      id: 3,
      title: NotificationStrings.get('alreadyTitle', locale),
      body: NotificationStrings.get('alreadyBody', locale),
      scheduledDate: cooldownDate.add(const Duration(days: 5)),
      channelName: NotificationStrings.get('channelName', locale),
      channelDescription: NotificationStrings.get('channelDescription', locale),
    );
    await _scheduleIfFuture(
      id: 4,
      title: NotificationStrings.get('longAgoTitle', locale),
      body: NotificationStrings.get('longAgoBody', locale),
      scheduledDate: cooldownDate.add(const Duration(days: 100)),
      channelName: NotificationStrings.get('channelName', locale),
      channelDescription: NotificationStrings.get('channelDescription', locale),
    );
  }

  static Future<void> _scheduleIfFuture({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    required String channelName,
    required String channelDescription,
  }) async {
    if (scheduledDate.isBefore(DateTime.now())) return;
    final tzDate = tz.TZDateTime.from(scheduledDate, tz.local);
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tzDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'donation_reminders',
          channelName,
          channelDescription: channelDescription,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}

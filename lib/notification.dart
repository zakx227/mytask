import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationHelper {
  static final _notification = FlutterLocalNotificationsPlugin();

  static init() async {
    await _notification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      ),
    );
    tz.initializeTimeZones();
  }

  static sheduleNotification(
    String title,
    String body,
    int userDayInput,
  ) async {
    var androidDetails = const AndroidNotificationDetails(
      "important_notification",
      "My channel",
      importance: Importance.max,
      priority: Priority.high,
    );
    var notificationDetails = NotificationDetails(android: androidDetails);
    await _notification.zonedSchedule(
      1,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: userDayInput)),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  cancelAllNotifications() {
    _notification.cancelAll();
  }

  Future<void> repeatPeriodicallyWithDurationNotification(
    String title,
    String body,
    int userDayInput,
  ) async {
    int id = 0;
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'repeating channel id',
          'repeating channel name',
          channelDescription: 'repeating description',
        );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await _notification.periodicallyShowWithDuration(
      id++,
      'repeating period title',
      'repeating period body',
      Duration(seconds: userDayInput),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}

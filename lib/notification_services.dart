import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/browser.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
  AndroidInitializationSettings('logo');

  void initializeNotification() async{
      InitializationSettings initializationSettings = InitializationSettings(
        android: _androidInitializationSettings
      );

      await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void shcheduleNotification(String title, String body) async{
    AndroidNotificationDetails androidNotificationDetails = 
        const AndroidNotificationDetails(
            'channelId',
            'channelName',
            importance : Importance.max,
          priority: Priority.high,
          styleInformation: BigTextStyleInformation(''),
        );

    NotificationDetails notificationDetails =
        NotificationDetails(
          android: androidNotificationDetails,
        );

    await _flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        title,
        body,
        RepeatInterval.daily,
        notificationDetails
    );
  }

  void sendNotification(String title, String body) async{
    AndroidNotificationDetails androidNotificationDetails =
    const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance : Importance.max,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(''),
    );

    NotificationDetails notificationDetails =
    NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        notificationDetails
    );
  }
  void scheduleDateNotification(
      String title, String body, DateTime scheduledDateTime) async {
    AndroidNotificationDetails androidNotificationDetails =
    const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(''),
    );

    NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    int notificationId = 0; // You can assign a unique ID for each notification

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      title,
      body,
      _nextInstanceOfScheduledTime(scheduledDateTime),
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  tz.TZDateTime _nextInstanceOfScheduledTime(DateTime scheduledDateTime) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      scheduledDateTime.year,
      scheduledDateTime.month,
      scheduledDateTime.day,
      scheduledDateTime.hour,
      scheduledDateTime.minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

}
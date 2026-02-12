import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';

class LocalNotificationService {
  localNotificationInit() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'achievr_channel',
          channelName: 'Achievr Notifications',
          channelDescription: 'Notification channel for daily wellness tasks',
          defaultColor: const Color(0xFF9D50DD),
          importance: NotificationImportance.High,
          channelShowBadge: true,
        )
      ],
    );
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }
}

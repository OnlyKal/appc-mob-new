import 'dart:math';
import 'package:appc/func/export.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationClass {
  static initializeNotif() async {
    AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelGroupKey: 'basic_channel_group',
              channelDescription: 'APPC SERVICES NOTIFICATION',
              defaultColor: mainColor,
              importance: NotificationImportance.High,
              channelShowBadge: true,
              ledColor: Colors.white)
        ],
        debug: true);
  }

  static askPermission(context) {
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );
  }

  static Future<void> openNotif(title, message) async {
    int min = 10;
    int max = 2000;
    int randomnum = min + Random().nextInt((max + 1) - min);
    SharedPreferences notif = await SharedPreferences.getInstance();
    if (notif.getString("state-notif") == "enable") {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: randomnum,
          channelKey: 'basic_channel',
          title: title,
          body: message,
          bigPicture: 'asset://assets/logo.png',
          notificationLayout: NotificationLayout.Inbox,
        ),
        actionButtons: [],
      );
    }
  }

  static Future<void> openNotifActuality(title, message, image) async {
    int min = 1;
    int max = 3000;
    int randomnum = min + Random().nextInt((max + 1) - min);
    SharedPreferences notif = await SharedPreferences.getInstance();
    if (notif.getString("state-notif") == "enable") {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: randomnum,
            channelKey: 'basic_channel',
            title: title,
            body: message,
            largeIcon: image,
            bigPicture: image,
            notificationLayout: NotificationLayout.BigPicture,
            payload: {"notification": "4o28727237626356254"}),
        actionButtons: [],
      );
    }
  }

  static Future<void> openNotifMono(title, message) async {
    int randomnum = 02;
    SharedPreferences notif = await SharedPreferences.getInstance();
    if (notif.getString("state-notif") == "enable") {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: randomnum,
          channelKey: 'basic_channel',
          title: title,
          body: message,
          bigPicture: 'asset://assets/logo.png',
          notificationLayout: NotificationLayout.Inbox,
        ),
        actionButtons: [],
      );
    }
  }
}

import 'dart:math';
import 'package:appc/func/export.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationClass {
  static initializeNotif() async {
    SharedPreferences notif = await SharedPreferences.getInstance();
    notif.setString("state-notif", "enable");
    AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription: 'APPC SERVICES NOTIFICATION',
              defaultColor: mainColor,
              channelShowBadge: false,
              ledColor: Colors.white)
        ],
        channelGroups: [
          NotificationChannelGroup(
            channelGroupName: 'basic_channel_group',
            channelGroupKey: 'basic_channel_group',
          )
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
    if (notif.getString("state-notif") != null ||
        notif.getString("state-notif") != "desable") {
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

  static Future<void> openNotifActuality(title, message) async {
    int min = 100;
    int max = 3000;
    int randomnum = min + Random().nextInt((max + 1) - min);
    SharedPreferences notif = await SharedPreferences.getInstance();
    if (notif.getString("state-notif") != null ||
        notif.getString("state-notif") != "desable") {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: randomnum,
          channelKey: 'basic_channel',
          title: title,
          body: message,

          bigPicture:
              'https://media.newyorker.com/photos/5909780a019dfc3494ea3018/master/w_2240,c_limit/Brody-Tarzan-Reboot.jpg',
          notificationLayout: NotificationLayout.BigPicture,
        ),
        actionButtons: [],
      );
    }
  }

  static Future<void> openNotifMono(title, message) async {
    int randomnum = 02;
    SharedPreferences notif = await SharedPreferences.getInstance();
    if (notif.getString("state-notif") != null ||
        notif.getString("state-notif") != "desable") {
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

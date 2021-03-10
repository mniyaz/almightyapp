import 'package:almighty/services/local_data_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_badger/flutter_app_badger.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationMessage {
  final String title;
  final String body;
  PushNotificationMessage({
    @required this.title,
    @required this.body,
  });
}

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> init() async {
    PushNotificationMessage notification;
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_stat');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions(
          const IosNotificationSettings(
              sound: true, badge: true, alert: true, provisional: false));
      _firebaseMessaging.onIosSettingsRegistered
          .listen((IosNotificationSettings setting) {});
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          showNotification(message['notification']['title'],
              message['notification']['body']);
          bool badgeSupported = await FlutterAppBadger.isAppBadgeSupported();
          if(badgeSupported){
            FlutterAppBadger.updateBadgeCount(1);
          };
        },
        onLaunch: (Map<String, dynamic> message) async {
          bool badgeSupported = await FlutterAppBadger.isAppBadgeSupported();
          if(badgeSupported){
            FlutterAppBadger.removeBadge();
          }
        },
        onResume: (Map<String, dynamic> message) async {},
      );

      // For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
      final String mobileNumber = await LocalService.getContactMobile();

      final checkResponse = await http.get(
          "https://almightysnk.com/rest/productcontroller/updatefcm/" +
              mobileNumber +
              "/$token");

      _initialized = true;
    }
  }

  void showNotification(String title, String body) async {
    await _demoNotification(title, body);
  }

  Future<void> _demoNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_ID', 'channel name', 'channel description',
        importance: Importance.high,
        playSound: true,
        styleInformation: BigTextStyleInformation(''),
        showProgress: true,
        priority: Priority.high,
        ticker: '');

    var iOSChannelSpecifics = IOSNotificationDetails(
        sound: 'default',
        presentBadge: true,
        presentSound: true,
        badgeNumber: 1,
        presentAlert: true,
        subtitle: "");
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: "");
  }
}

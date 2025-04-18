import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../firebase_options.dart';

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin localNotificationsPlugin;

// typedef BackgroundMessageHandler = Future<void> Function(RemoteMessage message);
Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage remoteMessage) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

mixin NotificationsService {
  static Future<void> init() async {
    //CONNECT THE PREVIOUS CREATED FUNCTION WITH [onBackgroundMessage] TO ENABLE
    //RECEIVING NOTIFICATION WHEN APP IN Background.
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    //CHANNEL
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        ledColor: Colors.red,
        showBadge: true,
        playSound: true,
      );
    }

    //Flutter Local Notifications Plugin (FOREGROUND) - ANDROID CHANNEL
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    //IOS Notification Setup (FOREGROUND)
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // ANDROID
  void initializeForegroundNotificationForAndroid() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message Received: ${message.messageId}');
      RemoteNotification? notification = message.notification;
      // AndroidNotification? androidNotification = message.notification?.android;
      AndroidNotification? androidNotification = notification?.android;
      if (notification != null && androidNotification != null) {
        localNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              channelDescription:
                  'This channel is used for important notifications',
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });
  }

  // GENERAL (Android & ios)
  void manageNotificationAction() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _controlNotificationNavigation(message.data);
    });
  }

  void _controlNotificationNavigation(Map<String, dynamic> data) {
    log('Notification data: $data');
    // if (data['page'] != null) {
    //   switch (data['page']) {
    //     case 'settings':
    //       print('Navigate to settings');
    //       break;
    //     case 'profile':
    //       print('Navigate to profile');
    //       break;
    //   }
    // }
  }

  // ios Notification permission
  Future<void> requestNotificationPermissions() async {
    NotificationSettings notificationSettings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      carPlay: false,
      announcement: false,
      provisional: false,
      criticalAlert: false,
    );
    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      log('GRANT PERMISSION');
      initializeForegroundNotificationForAndroid();
    } else if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.denied) {
      log('PERMISSION DENIED');
    }
  }
}

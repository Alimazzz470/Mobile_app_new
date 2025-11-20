import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taxiapp_mobile/router/app_router.dart';
import 'package:taxiapp_mobile/shared/utils/notification_formatter.dart';

import '../../../shared/providers/common_providers.dart';
import '../../dto/local_notification.dart';

final localNotificationServiceProvider =
    Provider.autoDispose<LocalNotificationService>((ref) {
  return LocalNotificationService(
    flutterLocalNotificationsPlugin:
        ref.watch(localNotificationsPluginProvider),
  );
});

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  LocalNotificationService({
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  }) : _flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin {
    _init();
  }

  Future<void> _init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  final AndroidNotificationDetails _androidNotificationDetails =
      const AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    channelDescription: 'channel description',
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  final DarwinNotificationDetails _iosNotificationDetails =
      const DarwinNotificationDetails(
    sound: "default",
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  Future<void> showNotifications(RemoteMessage message) async {
    String localizedTitle =
        mapBackendKeyToLocaleKey(message.notification?.titleLocKey ?? '');

    String localizedBody =
        mapBackendKeyToLocaleKey(message.notification?.bodyLocKey ?? '');

    await _flutterLocalNotificationsPlugin.show(
      101, // TODO: Change this to notification.id
      localizedTitle.tr(),
      localizedBody.tr(
        args: message.notification?.bodyLocArgs,
      ),
      NotificationDetails(
          android: _androidNotificationDetails, iOS: _iosNotificationDetails),
      payload: message.data['link'],
    );
  }

  Future<void> cancelNotifications(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}

void onDidReceiveBackgroundNotificationResponse(details) {
  //handle your logic here
  debugPrint("onDidReceiveBackgroundNotificationResponse: $details");
}

void onDidReceiveNotificationResponse(NotificationResponse details) {
  var context = rootNavigatorKey.currentContext;
  if (context == null) return;

  if (details.payload == null || details.payload!.isEmpty) return;
  context.go(details.payload!);
}

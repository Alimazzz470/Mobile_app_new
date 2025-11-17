import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:taxiapp_mobile/core/exceptions/unknown_exception.dart';
import 'package:taxiapp_mobile/core/services/notification/local_notification_service.dart';
import 'package:taxiapp_mobile/features/auth/providers/providers.dart';
import 'package:taxiapp_mobile/features/home/providers/get_notifications_providers.dart';
import 'package:taxiapp_mobile/network/models/notification_model.dart';
import 'package:taxiapp_mobile/router/app_router.dart';
import 'package:taxiapp_mobile/shared/providers/common_providers.dart';
import 'package:taxiapp_mobile/shared/utils/result.dart';

class NotificationService {
  final Ref ref;
  NotificationService(this.ref);

  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  // TODO: Add notification type to be used in routing

  // TODO : Add notifications strings for IOS

  Future<bool> checkPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      return true;
    } else {
      // Retry asking permission
      var status = await Permission.notification.request();
      if (status == PermissionStatus.granted) {
        return true;
      }
      return false;
    }
  }

  Future<String?> getFCMToken() async {
    try {
      if (await checkPermissions()) {
        return await messaging.getToken();
      }
      return null;
    } catch (e, s) {
      Failure(UnknownException(e.toString()), s);
      return null;
    }
  }

  Future<void> startHandlers() async {
    try {
      messaging.onTokenRefresh.listen(_updateNotificationToken);
      FirebaseMessaging.onMessageOpenedApp.listen(_handleNotification);

      final _localNotification = ref.read(localNotificationServiceProvider);

      // Foreground message handler
      FirebaseMessaging.onMessage.listen((event) {
        ref.invalidate(notificationsProvider);

        _localNotification.showNotifications(event);
      });
    } catch (e, s) {
      Failure(UnknownException(e.toString()), s);
    }
  }

  // Local notification handler

  ///
  /// To be used if user had not given notification permission but has
  /// re-enabled it by going to background or on enabling action in notification
  /// settings screen
  ///
  Future<void> setNotificationToken() async {
    try {
      if (await checkPermissions()) {
        var token = await messaging.getToken();
        var userToken = ref.read(loggedInUserProvider).fcmToken;
        debugPrint('User token: $userToken');
        if (token != null && token != userToken) {
          _updateNotificationToken(token);
        }
      }
    } catch (e, s) {
      Failure(UnknownException(e.toString()), s);
    }
  }

  Future<void> _updateNotificationToken(String token) async {
    var updateNotification =
        ref.read(authenticationRepository).updateFcmToken(token);
    updateNotification.then((value) => ref.invalidate(loggedInUserProvider),
        onError: (e, s) {
      Failure(UnknownException(e.toString()), s);
    });
  }

  void _handleNotification(RemoteMessage message) {
    try {
      ///
      /// Route to section with deeplink
      ///
      var context = rootNavigatorKey.currentContext;
      if (context == null) return;
      ref.invalidate(notificationsProvider);

      log('Link Data : ${message.data}');

      var link = message.data["link"] as String?;
      var title = message.data["messageType"] as String;
      if (link == null || title.isEmpty) return;
      context.go(link);

      /// Do any subsequent logic to re-fetch page state if its not loaded

      var type = parseNotificationType(title);
      switch (type) {
        case NotificationType.leaveCreated:
        case NotificationType.leaveUpdated:
        case NotificationType.deductionReceived:
          // NO state update is necessary, only route
          break;
        case NotificationType.advanceReceived:
        default:
          break;
      }
    } catch (e, s) {
      Failure(UnknownException(e.toString()), s);
    }
  }
}

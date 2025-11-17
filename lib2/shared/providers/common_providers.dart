import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxiapp_mobile/core/services/notification/notification_service.dart';

import '../../core/entities/user.dart';
import '../../core/exceptions/coded_exception.dart';
import '../../core/services/connectivity/connection_manager.dart';
import '../../network/data_sources/shared_data_source.dart';
import '../../network/network.dart';
import '../repositories/shared_repository.dart';
import '../repositories/shared_repository_impl.dart';
import 'package:easy_localization/easy_localization.dart';

final connectivityProvider = Provider((_) => ConnectivityManager());

typedef OnUserChange = void Function(User? user);

final loggedInUserProvider =
    NotifierProvider<UserNotifier, User>(UserNotifier.new);

final remoteNotificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService(ref);
});

final localizationProvider =
    NotifierProvider<LocalizationNotifier, Locale>(LocalizationNotifier.new);

class LocalizationNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    return const Locale('en');
  }

  void changeLocale(Locale locale, BuildContext context) {
    context.setLocale(locale);
    state = locale;
  }
}

class UserNotifier extends Notifier<User> {
  @override
  User build() {
    return User.empty();
  }

  void changeUser(User? user) {
    state = user ?? User.empty();
  }
}

final appMessageProvider =
    NotifierProvider.autoDispose<AppMessage, (CodedException?, RetryFunction)>(
        () {
  return AppMessage();
});

typedef RetryFunction = void Function()?;

class AppMessage extends AutoDisposeNotifier<(CodedException?, RetryFunction)> {
  @override
  (CodedException?, RetryFunction) build() {
    return (null, null);
  }

  void addException({
    required CodedException exception,
    RetryFunction retry,
  }) {
    state = (exception, retry);
    ref.invalidateSelf();
  }
}

typedef OnFcmTokenChange = void Function(String? fcmToken);

final localNotificationsPluginProvider =
    Provider.autoDispose<FlutterLocalNotificationsPlugin>((_) {
  return FlutterLocalNotificationsPlugin();
});

final sharedDataSourceProvider = Provider.autoDispose<SharedDataSource>((ref) {
  return SharedDataSource(ref.watch(apiClient));
});

final sharedRepositoryProvider = Provider.autoDispose<SharedRepository>((ref) {
  return SharedRepoImpl(dataSource: ref.watch(sharedDataSourceProvider));
});

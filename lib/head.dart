import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taxiapp_mobile/shared/providers/common_providers.dart';
import 'router/app_router.dart';
import 'router/route_listenable.dart';
import 'shared/helpers/app_strings.dart';
import 'shared/theme/app_theme.dart';

class Head extends ConsumerStatefulWidget {
  final String? initialLink;
  const Head(this.initialLink, {Key? key}) : super(key: key);

  @override
  ConsumerState<Head> createState() => _HeadState();
}

class _HeadState extends ConsumerState<Head> {
  RouterListenable? previous;
  late GoRouter router;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    final localizationsProvider = ref.watch(localizationProvider);

    final listenable = ref.watch(routerListenableProvider.notifier);
    if (listenable != previous) {
      previous = listenable;
      router = GoRouter(
        navigatorKey: rootNavigatorKey,
        debugLogDiagnostics: true,
        refreshListenable: previous,
        redirect: previous!.redirect,
        routes: appRoutes,
        initialLocation: widget.initialLink,
      );
    }

    log('Locale in Head : ${localizationsProvider}');
    log("Context locale : ${context.locale}");

    return ScreenUtilInit(
      designSize: const Size(430, 932),
      splitScreenMode: true,
      builder: (context, _) {
        return MaterialApp.router(
          title: APP_NAME,
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          routerConfig: router,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          themeMode: ThemeMode.light,
        );
      },
    );
  }
}

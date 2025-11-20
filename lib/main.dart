import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'firebase_options.dart';
import 'head.dart';
import 'shared/utils/shared_preferences.dart';
import 'translations/codegen_loader.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  await SharedPreferencesHelper.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Check if app was opened via notification from terminated state
  var initMsg = await FirebaseMessaging.instance.getInitialMessage();

  String link = initMsg?.data['link'] ?? '';

  final child = Head(link.isNotEmpty ? link : null);

  // Override debugPrint to do nothing on release mode
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en', ''),
          Locale('de', ''),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', ''),
        assetLoader: const CodegenLoader(),
        child: child,
      ),
    ),
  );
}

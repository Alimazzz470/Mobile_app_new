import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/exceptions/coded_exception.dart';
import '../../translations/locale_keys.g.dart';
import '../helpers/coded_exception_helper.dart';
import '../theme/app_colors.dart';

void showErrorSnackBar(
  BuildContext context, {
  CodedException? message,
  String? messageText,
  void Function()? retry,
  Duration? duration,
}) {
  if (message == null) return;

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: duration ?? const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: retry == null ? LocaleKeys.okText.tr() : LocaleKeys.retryText.tr().toUpperCase(),
      textColor: Colors.white,
      onPressed: () => retry?.call(),
    ),
    backgroundColor: ERROR_COLOR,
    content: Text(
      messageText ?? message.getString(context, displayReason: true),
      style: Theme.of(context).primaryTextTheme.displaySmall!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
    ),
  ));
}

void showSuccessSnackBar(
  BuildContext context, {
  required String message,
  Duration? duration,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: duration ?? const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: LocaleKeys.okText.tr(),
      textColor: Colors.white,
      onPressed: () {},
    ),
    backgroundColor: SUCCESS_COLOR,
    content: Text(
      message,
      style: Theme.of(context).primaryTextTheme.displaySmall!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
    ),
  ));
}

void showWarningSnackBar(
  BuildContext context, {
  required String message,
  Duration? duration,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: duration ?? const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: LocaleKeys.okText.tr(),
      textColor: Colors.white,
      onPressed: () {},
    ),
    backgroundColor: WARNING_COLOR,
    content: Text(
      message,
      style: Theme.of(context).primaryTextTheme.displaySmall!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
    ),
  ));
}

void showInfoSnackBar(
  BuildContext context, {
  required String message,
  Duration? duration,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: duration ?? const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: LocaleKeys.okText.tr(),
      textColor: Colors.white,
      onPressed: () {},
    ),
    backgroundColor: INFO_COLOR,
    content: Text(
      message,
      style: Theme.of(context).primaryTextTheme.displaySmall!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
    ),
  ));
}

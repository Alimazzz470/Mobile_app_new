import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

ThemeData appTheme = ThemeData(
  primaryColor: PRIMARY_COLOR,
  canvasColor: Colors.transparent,
  primaryTextTheme: textTheme,
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: PRIMARY_COLOR.withOpacity(0.2),
  ),
  fontFamily: 'Inter',
  scaffoldBackgroundColor: BACKGROUND_COLOR,
  colorScheme: ColorScheme.fromSeed(
    seedColor: PRIMARY_COLOR,
    error: ERROR_COLOR,
  ),
  useMaterial3: true,
  brightness: Brightness.light,
);

TextTheme textTheme = TextTheme(
  titleLarge: TextStyle(
    fontSize: 45.sp,
    fontWeight: FontWeight.w700,
    color: PRIMARY_TEXT_COLOR,
  ),
  titleMedium: TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.w700,
    color: PRIMARY_TEXT_COLOR,
  ),
  // Headline 1
  displayLarge: TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: PRIMARY_TEXT_COLOR,
  ),
  // Headline 2
  displayMedium: TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: PRIMARY_TEXT_COLOR,
  ),
  // Headline 3
  displaySmall: TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: PRIMARY_TEXT_COLOR,
  ),
  // Headline 4
  headlineMedium: TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    color: PRIMARY_TEXT_COLOR,
  ),
  // Headline 5
  headlineSmall: TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w700,
    color: PRIMARY_TEXT_COLOR,
  ),
  bodyLarge: TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: PRIMARY_TEXT_COLOR,
  ),
  bodyMedium: TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: PRIMARY_TEXT_COLOR,
  ),
  bodySmall: TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    color: PRIMARY_TEXT_COLOR,
  ),
);

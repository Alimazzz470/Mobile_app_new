import 'package:flutter/material.dart';

// App Colors
const primaryColor = Color(0xFF4F46E5); // Deep Indigo
const backgroundColor = Color(0xFFF8F9FC); // Light Grey
const surfaceColor = Colors.white;

// App Theme
final appTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: backgroundColor,
  colorScheme: const ColorScheme.light(
    primary: primaryColor,
    surface: surfaceColor,
    background: backgroundColor,
  ),
  // Define other theme properties as needed
);

import 'package:flutter/material.dart';

class AppColors {
  // Light
  static const primaryLight = Color(0xFF6200EE);
  static const secondaryLight = Color(0xFF03DAC6);
  static const bgLight = Color(0xFFF5F5F5);
  static const surfaceLight = Colors.white;
  static const textLight = Colors.black87;

  // Dark
  static const primaryDark = Color(0xFFBB86FC);
  static const secondaryDark = Color(0xFF03DAC6);
  static const bgDark = Color(0xFF121212);
  static const surfaceDark = Color(0xFF1E1E1E);
  static const textDark = Colors.white;
}

class LightTheme {
  static final themeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryLight,
    scaffoldBackgroundColor: AppColors.bgLight,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryLight,
      secondary: AppColors.secondaryLight,
      background: AppColors.bgLight,
      surface: AppColors.surfaceLight,
      onPrimary: AppColors.textLight,
      onSecondary: AppColors.textLight,
      onBackground: AppColors.textLight,
      onSurface: AppColors.textLight,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surfaceLight,
      iconTheme: IconThemeData(color: AppColors.textLight),
    ),
  );
}class DarkTheme {
  static final themeData = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.bgDark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryDark,
      secondary: AppColors.secondaryDark,
      background: AppColors.bgDark,
      surface: AppColors.surfaceDark,
      onPrimary: AppColors.textDark,
      onSecondary: AppColors.textDark,
      onBackground: AppColors.textDark,
      onSurface: AppColors.textDark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surfaceDark,
      iconTheme: IconThemeData(color: AppColors.textDark),
    ),
  );
}
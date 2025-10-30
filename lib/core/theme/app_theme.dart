import 'package:flutter/material.dart';

class AppColors {
  static const orange = Color(0xFFF5A536);
  static const teal = Color(0xFF21B2B7);
  static const red = Color(0xFFE55C4F);
}

class AppTheme {
  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(seedColor: AppColors.teal).copyWith(
      primary: AppColors.teal,
      secondary: AppColors.orange,
      tertiary: AppColors.red,
      onPrimary: Colors.white,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: Typography.blackMountainView,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Color(0xFFF7F7F7),
      ),
      appBarTheme: const AppBarTheme(centerTitle: true),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:daar_project/app/theme/colors.dart';

class AppTheme {
  static _border([Color color = AppColors.borderColor]) => OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
    ),
    borderRadius: BorderRadius.circular(12),
  );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.darkBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      iconTheme: IconThemeData(
        color: AppColors.white,
      ),
    ),
    iconTheme: IconThemeData(
      color: AppColors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      enabledBorder: _border(),
      focusedBorder: _border(AppColors.borderColorShade),
    ),
    textTheme: const TextTheme(
      // ⭐ TITOLI
      titleLarge: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20
      ),
      titleMedium: TextStyle(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),

      // ⭐ TESTO NORMALE
      bodyLarge: TextStyle(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        color: AppColors.white,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        color: AppColors.grey,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),

      // ⭐ LABEL (per TextField, Button, etc.)
      labelLarge: TextStyle(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        color: AppColors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        color: AppColors.grey,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),

      // ⭐ HEADLINE (per titoli grandi)
      headlineLarge: TextStyle(
        color: AppColors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: AppColors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBackground,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(color: AppColors.primary),
      unselectedLabelStyle: const TextStyle(color: AppColors.white),
      type: BottomNavigationBarType.fixed,
    ),
  );

  static final lightThemeMode = ThemeData.light().copyWith( // ⭐ CAMBIA dark() CON light()
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      iconTheme: IconThemeData(
        color: AppColors.black,
      ),
    ),
    iconTheme: IconThemeData(
      color: AppColors.black,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      enabledBorder: _border(),
      focusedBorder: _border(AppColors.borderColorShade),
    ),
    textTheme: const TextTheme(
      // ⭐ TITOLI
      titleLarge: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20
      ),
      titleMedium: TextStyle(
        color: AppColors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),

      // ⭐ TESTO NORMALE
      bodyLarge: TextStyle(
        color: AppColors.black,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        color: AppColors.black,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        color: AppColors.grey,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),

      // ⭐ LABEL
      labelLarge: TextStyle(
        color: AppColors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        color: AppColors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        color: AppColors.grey,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),

      // ⭐ HEADLINE
      headlineLarge: TextStyle(
        color: AppColors.black,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: AppColors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: AppColors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.background,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(color: AppColors.primary),
      unselectedLabelStyle: const TextStyle(color: AppColors.black),
      type: BottomNavigationBarType.fixed,
    ),
  );
}
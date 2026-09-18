import 'package:flutter/material.dart';

import 'renon_colors.dart';
import 'renon_spacing.dart';

class RenonTheme {
  const RenonTheme._();

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: RenonColors.palm,
      brightness: Brightness.light,
      primary: RenonColors.palm,
      secondary: RenonColors.lime,
      surface: RenonColors.paper,
      error: RenonColors.danger,
    );

    final textTheme = Typography.blackMountainView.apply(
      bodyColor: RenonColors.ink,
      displayColor: RenonColors.ink,
      fontFamily: 'Roboto',
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: RenonColors.cream,
      textTheme: textTheme.copyWith(
        displaySmall: textTheme.displaySmall?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
        ),
        headlineMedium: textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
        ),
        titleLarge: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
        ),
        titleMedium: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          color: RenonColors.muted,
          height: 1.45,
          letterSpacing: 0,
        ),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: RenonColors.cream,
        foregroundColor: RenonColors.ink,
        surfaceTintColor: Colors.transparent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(54),
          elevation: 0,
          backgroundColor: RenonColors.lime,
          foregroundColor: RenonColors.ink,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RenonRadius.lg),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(54),
          foregroundColor: RenonColors.ink,
          side: const BorderSide(color: RenonColors.line),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RenonRadius.lg),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: RenonColors.paper,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: RenonSpacing.md,
          vertical: RenonSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RenonRadius.lg),
          borderSide: const BorderSide(color: RenonColors.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RenonRadius.lg),
          borderSide: const BorderSide(color: RenonColors.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RenonRadius.lg),
          borderSide: const BorderSide(color: RenonColors.palm, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RenonRadius.lg),
          borderSide: const BorderSide(color: RenonColors.danger),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: RenonColors.paper,
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RenonRadius.lg),
          side: const BorderSide(color: RenonColors.line),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: RenonColors.smoke,
        selectedColor: RenonColors.lime,
        labelStyle: const TextStyle(
          color: RenonColors.ink,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RenonRadius.md),
        ),
        side: BorderSide.none,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: RenonColors.paper,
        selectedItemColor: RenonColors.palm,
        unselectedItemColor: RenonColors.softText,
        type: BottomNavigationBarType.fixed,
        elevation: 12,
      ),
    );
  }
}

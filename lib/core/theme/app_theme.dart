import 'package:farmer_eats/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
      ),
      useMaterial3: true,
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );

    return ThemeData(
      scaffoldBackgroundColor: base.scaffoldBackgroundColor,
      colorScheme: base.colorScheme,
      useMaterial3: base.useMaterial3,
      snackBarTheme: base.snackBarTheme,
      textTheme: GoogleFonts.beVietnamProTextTheme(base.textTheme),
      primaryTextTheme: GoogleFonts.beVietnamProTextTheme(
        base.primaryTextTheme,
      ),
      fontFamily: GoogleFonts.beVietnamPro().fontFamily,
    );
  }
}

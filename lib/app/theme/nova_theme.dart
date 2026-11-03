
import 'package:flutter/material.dart' as flutter;
import 'package:google_fonts/google_fonts.dart';

import 'nova_colors.dart';

class NovaTheme {
  NovaTheme._();

  static flutter.ThemeData get darkTheme {
    final baseTheme = flutter.ThemeData(
      useMaterial3: true,
      brightness: flutter.Brightness.dark,
    );

    final flutter.TextTheme novaTextTheme = baseTheme.textTheme.copyWith(
      displayLarge: GoogleFonts.manrope(
        fontSize: 57,
        fontWeight: flutter.FontWeight.w800,
        color: NovaColors.white,
      ),
      headlineLarge: GoogleFonts.manrope(
        fontSize: 32,
        fontWeight: flutter.FontWeight.w800,
        color: NovaColors.white,
      ),
      titleLarge: GoogleFonts.manrope(
        fontSize: 22,
        fontWeight: flutter.FontWeight.w700,
        color: NovaColors.white,
      ),
      bodyLarge: GoogleFonts.manrope(
        fontSize: 16,
        fontWeight: flutter.FontWeight.w500,
        color: NovaColors.softWhite,
      ),
      bodyMedium: GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: flutter.FontWeight.w400,
        color: NovaColors.mutedWhite,
      ),
    );

    return baseTheme.copyWith(
      scaffoldBackgroundColor: NovaColors.background,

      colorScheme: const flutter.ColorScheme.dark(
        primary: NovaColors.red,
        secondary: NovaColors.coral,
        surface: NovaColors.deepMaroon,
        error: NovaColors.negative,
        onPrimary: NovaColors.white,
        onSecondary: NovaColors.white,
        onSurface: NovaColors.white,
      ),

      textTheme: novaTextTheme,

      appBarTheme: const flutter.AppBarTheme(
        backgroundColor: flutter.Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),

      iconTheme: const flutter.IconThemeData(
        color: NovaColors.white,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planning_poker_ifood/src/core/themes/light/light_colors.dart';

class LightTheme {
  static final theme = ThemeData(
    primaryColor: LightColors.primaryColor,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: LightColors.primaryColor),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: LightColors.primaryColor, width: 2),
      ),
      floatingLabelStyle: GoogleFonts.nunito(
        color: LightColors.primaryColor,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(LightColors.primaryColor),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(LightColors.primaryColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        textStyle: WidgetStateProperty.all(
          GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        minimumSize: WidgetStateProperty.all(
          const Size(double.infinity, 48),
        ),
        foregroundColor: WidgetStateProperty.all(Colors.white),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: LightColors.primaryColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: LightColors.primaryColor,
      foregroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.nunito(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.nunito(
        fontWeight: FontWeight.bold,
      ),
      displayLarge: GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: LightColors.secondaryTextColor,
      ),
    ),
  );
}

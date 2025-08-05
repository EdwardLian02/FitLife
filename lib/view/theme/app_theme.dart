import 'package:flutter/material.dart';

class AppTheme {
  // Define the primary and secondary colors
  static const Color primaryColor = Color(0xFF7D59EE); // Purple
  static const Color secondaryColor = Colors.black; // Teal

  // Define the background and surface colors
  static const Color backgroundColor = Color(0xFFF6F6F6); // Light Gray
  static const Color surfaceColor = Colors.white;

  // Define text colors
  static const Color textColor = Colors.black87;
  static const Color textLightColor = Colors.white;

  // Light theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: Colors.black,
      surface: surfaceColor,
    ),
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(
      color: primaryColor,
      iconTheme: IconThemeData(color: textLightColor),
      titleTextStyle: TextStyle(
        color: textLightColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: textLightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
    ),
  );
}

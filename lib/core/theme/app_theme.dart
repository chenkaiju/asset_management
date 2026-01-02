import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00C853); // Emerald Green
  static const Color secondaryColor = Color(0xFF2979FF); // Royal Blue
  static const Color backgroundColor = Color(0xFF121212); // Deep Dark
  static const Color surfaceColor = Color(0xFF1E1E1E); // Surface Dark
  static const Color onSurfaceColor = Colors.white;

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    cardColor: surfaceColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: onSurfaceColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: onSurfaceColor,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: onSurfaceColor,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: onSurfaceColor, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
    ),
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: surfaceColor,
      background: backgroundColor,
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onSurface: onSurfaceColor,
      onBackground: onSurfaceColor,
    ),
    useMaterial3: true,
  );
}

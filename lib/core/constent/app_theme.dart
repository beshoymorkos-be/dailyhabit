import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF4C7FFF);
  static const Color primaryMint = Color(0xFF6DE0B9);
  static const Color secondaryDarkBlue = Color(0xFF2E63A7);

  static const Color backgroundLight = Color(0xFFE8F0FF);
  static const Color surfaceCard = Color(0xFFFFFFFF);
  static Color shadowSoft = Colors.grey.withOpacity(0.1);

  static const Gradient mainGradient = LinearGradient(
    colors: [Color(0xFF8BB8FF), Color(0xFF6DE0B9)],
    end: Alignment.bottomRight,
  );
  static const Gradient HabitGradient = LinearGradient(
    colors: [Color(0xFF6DE0B9), Color(0xFFFFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const Gradient HabitGradient2 = LinearGradient(
    colors: [Color(0xFF8BB8FF), Color(0xFFFFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient buttonGradient = LinearGradient(
    colors: [Color(0xFF8BB8FF), Color(0xFFB4EEDD)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);

  static const Color errorRed = Color(0xFFFF5252);
  static const Color streakOrange = Color(0xFFFF9800);
  static ThemeData themeWhite = ThemeData(
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(color: textPrimary),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ));
}

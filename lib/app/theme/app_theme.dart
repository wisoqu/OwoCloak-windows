import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: const Color(0xFF0B1020),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF35D0C8),
        brightness: Brightness.dark,
        surface: const Color(0xFF11172A),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF11172A),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Color(0x22FFFFFF)),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0B1020),
        foregroundColor: Colors.white,
        centerTitle: false,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData dark() {
    const background = Color(0xFF0D0F12);
    const panel = Color(0xFF15181D);
    const panel2 = Color(0xFF1B1F26);
    const line = Color(0xFF262B33);
    const text = Color(0xFFE8EAED);
    const textDim = Color(0xFF8A919C);
    const cyan = Color(0xFF4FD1C5);
    const amber = Color(0xFFE8A33D);
    final base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: cyan,
        brightness: Brightness.dark,
        surface: panel,
        primary: cyan,
        secondary: amber,
        onSurface: text,
        onSurfaceVariant: textDim,
      ),
      cardTheme: CardThemeData(
        color: panel,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: line),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: panel,
        foregroundColor: text,
        centerTitle: false,
      ),
      dividerTheme: const DividerThemeData(color: line, thickness: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: panel2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: amber),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      ),
      textTheme: base.textTheme.apply(
        bodyColor: text,
        displayColor: text,
      ),
    );
  }
}

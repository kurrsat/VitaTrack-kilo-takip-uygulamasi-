import 'package:flutter/material.dart';
/// Material 3 theme configuration
class AppTheme {
  AppTheme._();

  static const Color _deepBlue = Color(0xFF0B4DB8);
  static const Color _brightBlue = Color(0xFF1E88FF);
  static const Color _softBlue = Color(0xFF78C7FF);
  static const Color _cardGlass = Color(0x22FFFFFF);

  static ThemeData _buildTheme() {
    final colorScheme = const ColorScheme.dark(
      primary: _brightBlue,
      secondary: _softBlue,
      surface: Color(0xFF0F5FD1),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      error: Color(0xFFFF6B6B),
      onError: Colors.white,
    );

    final baseTheme = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _deepBlue,
    );

    final textTheme = baseTheme.textTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    );

    return baseTheme.copyWith(
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardTheme(
        color: _cardGlass,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.label,
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Color(0xFF0F5FD1),
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: _deepBlue,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0x14FFFFFF),
        hintStyle: const TextStyle(color: Colors.white70),
      ),
    );
  }

  static ThemeData get lightTheme => _buildTheme();

  static ThemeData get darkTheme => _buildTheme();
}

import 'package:flutter/material.dart';

class AppTheme {
  static const _seed = Color(0xFF1F6F5C);
  static const _bodyFont = 'SpaceGrotesk';
  static const _displayFont = 'PlayfairDisplay';

  static ThemeData get lightTheme {
    final base = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seed,
      ),
    );

    final textTheme = base.textTheme.apply(fontFamily: _bodyFont).copyWith(
          displayLarge: base.textTheme.displayLarge?.copyWith(
            fontFamily: _displayFont,
            fontWeight: FontWeight.w600,
          ),
          displayMedium: base.textTheme.displayMedium?.copyWith(
            fontFamily: _displayFont,
            fontWeight: FontWeight.w600,
          ),
          headlineSmall: base.textTheme.headlineSmall?.copyWith(
            fontFamily: _displayFont,
            fontWeight: FontWeight.w600,
          ),
        );

    return base.copyWith(
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        elevation: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  static ThemeData get darkTheme {
    final base = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seed,
        brightness: Brightness.dark,
      ),
    );

    final textTheme = base.textTheme.apply(fontFamily: _bodyFont).copyWith(
          displayLarge: base.textTheme.displayLarge?.copyWith(
            fontFamily: _displayFont,
            fontWeight: FontWeight.w600,
          ),
          displayMedium: base.textTheme.displayMedium?.copyWith(
            fontFamily: _displayFont,
            fontWeight: FontWeight.w600,
          ),
          headlineSmall: base.textTheme.headlineSmall?.copyWith(
            fontFamily: _displayFont,
            fontWeight: FontWeight.w600,
          ),
        );

    return base.copyWith(
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        elevation: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

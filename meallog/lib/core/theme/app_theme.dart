import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _seed = Color(0xFF0F8F6E);

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: _seed),
      scaffoldBackgroundColor: const Color(0xFFF6F8F6),
    );

    final textTheme = GoogleFonts.plusJakartaSansTextTheme(base.textTheme).copyWith(
      displayLarge: GoogleFonts.dmSerifDisplay(textStyle: base.textTheme.displayLarge),
      displayMedium: GoogleFonts.dmSerifDisplay(textStyle: base.textTheme.displayMedium),
      headlineSmall: GoogleFonts.dmSerifDisplay(textStyle: base.textTheme.headlineSmall),
    );

    return base.copyWith(
      textTheme: textTheme,
      cardTheme: CardTheme(
        elevation: 0.2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  static ThemeData get dark {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.dark),
      scaffoldBackgroundColor: const Color(0xFF0E0F0F),
    );

    final textTheme = GoogleFonts.plusJakartaSansTextTheme(base.textTheme).copyWith(
      displayLarge: GoogleFonts.dmSerifDisplay(textStyle: base.textTheme.displayLarge),
      displayMedium: GoogleFonts.dmSerifDisplay(textStyle: base.textTheme.displayMedium),
      headlineSmall: GoogleFonts.dmSerifDisplay(textStyle: base.textTheme.headlineSmall),
    );

    return base.copyWith(
      textTheme: textTheme,
      cardTheme: CardTheme(
        elevation: 0.2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

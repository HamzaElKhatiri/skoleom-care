import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color navy = Color(0xFF071B3A);
  static const Color blue = Color(0xFF0A66FF);
  static const Color sky = Color(0xFFDCEBFF);
  static const Color beige = Color(0xFFF3E8D5);
  static const Color cream = Color(0xFFFFFBF4);
  static const Color ink = Color(0xFF08111F);
  static const Color muted = Color(0xFF6E7D92);
  static const Color card = Color(0xFFFFFFFF);
  static const Color line = Color(0xFFE8EDF5);

  static ThemeData get lightTheme {
    final textTheme = GoogleFonts.poppinsTextTheme();
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: cream,
      colorScheme: ColorScheme.fromSeed(
        seedColor: blue,
        brightness: Brightness.light,
        primary: blue,
        secondary: beige,
        surface: card,
      ),
      textTheme: textTheme.copyWith(
        displayLarge: GoogleFonts.poppins(fontSize: 48, height: 0.96, fontWeight: FontWeight.w800, color: ink, letterSpacing: -2.2),
        displayMedium: GoogleFonts.poppins(fontSize: 36, height: 1.02, fontWeight: FontWeight.w800, color: ink, letterSpacing: -1.4),
        headlineSmall: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w800, color: ink, letterSpacing: -0.6),
        titleLarge: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: ink),
        titleMedium: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: ink),
        bodyLarge: GoogleFonts.poppins(fontSize: 15, height: 1.5, fontWeight: FontWeight.w500, color: ink),
        bodyMedium: GoogleFonts.poppins(fontSize: 13, height: 1.45, fontWeight: FontWeight.w500, color: muted),
        labelLarge: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 0.1),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: ink,
        elevation: 0,
        centerTitle: false,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white.withOpacity(0.94),
        indicatorColor: sky,
        labelTextStyle: WidgetStateProperty.all(GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ink,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w800),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: card,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
    );
  }

  static ThemeData get darkTheme {
    final base = lightTheme;
    return base.copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF040B16),
      colorScheme: const ColorScheme.dark(primary: blue, secondary: beige, surface: Color(0xFF0E1B2F)),
    );
  }
}

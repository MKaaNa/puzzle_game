import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _primaryColor = Color(0xFF6200EE);
  static const _secondaryColor = Color(0xFF03DAC6);
  static const _backgroundColor = Color(0xFFF5F5F5);
  static const _surfaceColor = Color(0xFFFFFFFF);
  static const _errorColor = Color(0xFFB00020);

  // Yeni tema renkleri
  static const _spaceTheme = {
    'primary': Color(0xFF1A237E),
    'secondary': Color(0xFF00BCD4),
    'background': Color(0xFF0A0A2A),
    'surface': Color(0xFF1E1E3F),
  };

  static const _natureTheme = {
    'primary': Color(0xFF2E7D32),
    'secondary': Color(0xFF81C784),
    'background': Color(0xFFE8F5E9),
    'surface': Color(0xFFC8E6C9),
  };

  static const _retroTheme = {
    'primary': Color(0xFFFF5722),
    'secondary': Color(0xFFFFC107),
    'background': Color(0xFF212121),
    'surface': Color(0xFF424242),
  };

  static ThemeData get lightTheme => _buildTheme(_primaryColor, _secondaryColor, _backgroundColor, _surfaceColor);
  static ThemeData get darkTheme => _buildTheme(_primaryColor, _secondaryColor, Colors.black, Colors.grey[900]!);
  static ThemeData get spaceTheme => _buildTheme(_spaceTheme['primary']!, _spaceTheme['secondary']!, _spaceTheme['background']!, _spaceTheme['surface']!);
  static ThemeData get natureTheme => _buildTheme(_natureTheme['primary']!, _natureTheme['secondary']!, _natureTheme['background']!, _natureTheme['surface']!);
  static ThemeData get retroTheme => _buildTheme(_retroTheme['primary']!, _retroTheme['secondary']!, _retroTheme['background']!, _retroTheme['surface']!);

  static ThemeData _buildTheme(Color primary, Color secondary, Color background, Color surface) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: background.computeLuminance() > 0.5 ? Brightness.light : Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        ThemeData(
          brightness: background.computeLuminance() > 0.5 ? Brightness.light : Brightness.dark,
        ).textTheme,
      ),
      // Yeni animasyon ve geçiş efektleri
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
} 
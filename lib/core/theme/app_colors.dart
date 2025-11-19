import 'package:flutter/material.dart';

/// Semantic palette for light/dark themes.
class AppColors {
  AppColors._();

  // Grey scale (Notion-style)
  static const grey100 = Color(0xFFF7F6F3);
  static const grey200 = Color(0xFFE9E9E6);
  static const grey300 = Color(0xFFD9D9D6);
  static const grey400 = Color(0xFFC4C4C1);
  static const grey500 = Color(0xFF9B9B97);
  static const grey600 = Color(0xFF73736E);
  static const grey700 = Color(0xFF5E5E5A);
  static const grey800 = Color(0xFF3D3D3A);
  static const grey900 = Color(0xFF1F1F1C);

  // Semantic colors
  static const primary = Color(0xFF2383E2); // Blue accent
  static const primaryDark = Color(0xFF1A6BC4);
  static const primaryLight = Color(0xFF4A9FE8);

  static const success = Color(0xFF0F7B0F);
  static const successLight = Color(0xFFE6F4E6);

  static const warning = Color(0xFFE6A700);
  static const warningLight = Color(0xFFFFF4E6);

  static const error = Color(0xFFD1242F);
  static const errorLight = Color(0xFFFFE6E6);

  static const info = Color(0xFF2383E2);
  static const infoLight = Color(0xFFE6F0FF);

  static const AppPalette _lightPalette = AppPalette(
    background: grey100,
    surface: Colors.white,
    surfaceVariant: grey200,
    textPrimary: grey900,
    textSecondary: grey600,
    textTertiary: grey500,
    textDisabled: grey400,
    border: grey300,
    borderLight: grey200,
    divider: grey200,
  );

  static const AppPalette _darkPalette = AppPalette(
    background: Color(0xFF0F0F0F),
    surface: Color(0xFF1A1A1A),
    surfaceVariant: Color(0xFF232323),
    textPrimary: Colors.white,
    textSecondary: Color(0xFFBBBBBB),
    textTertiary: Color(0xFF8A8A8A),
    textDisabled: Color(0xFF5E5E5E),
    border: Color(0xFF2F2F2F),
    borderLight: Color(0xFF3A3A3A),
    divider: Color(0xFF2C2C2C),
  );

  static Brightness? _overrideBrightness;

  static void setThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        _overrideBrightness = Brightness.dark;
        break;
      case ThemeMode.light:
        _overrideBrightness = Brightness.light;
        break;
      case ThemeMode.system:
        _overrideBrightness = null;
        break;
    }
  }

  static Brightness _effectiveBrightness() {
    final override = _overrideBrightness;
    if (override != null) return override;
    return WidgetsBinding.instance.platformDispatcher.platformBrightness;
  }

  static AppPalette get _currentPalette =>
      _effectiveBrightness() == Brightness.dark ? _darkPalette : _lightPalette;

  static AppPalette get lightPalette => _lightPalette;
  static AppPalette get darkPalette => _darkPalette;

  // Background colors
  static Color get background => _currentPalette.background;
  static Color get surface => _currentPalette.surface;
  static Color get surfaceVariant => _currentPalette.surfaceVariant;

  // Text colors
  static Color get textPrimary => _currentPalette.textPrimary;
  static Color get textSecondary => _currentPalette.textSecondary;
  static Color get textTertiary => _currentPalette.textTertiary;
  static Color get textDisabled => _currentPalette.textDisabled;

  // Border colors
  static Color get border => _currentPalette.border;
  static Color get borderLight => _currentPalette.borderLight;

  // Divider
  static Color get divider => _currentPalette.divider;
}

class AppPalette {
  const AppPalette({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.border,
    required this.borderLight,
    required this.divider,
  });

  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textDisabled;
  final Color border;
  final Color borderLight;
  final Color divider;
}

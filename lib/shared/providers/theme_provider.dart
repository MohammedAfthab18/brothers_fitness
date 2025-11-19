import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/theme/app_colors.dart';

final themeModeProvider =
    NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  static const _prefsKey = 'theme_mode';
  bool _hasLoaded = false;

  @override
  ThemeMode build() {
    AppColors.setThemeMode(ThemeMode.system);
    _restoreTheme();
    return ThemeMode.system;
  }

  Future<void> _restoreTheme() async {
    if (_hasLoaded) return;
    _hasLoaded = true;
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_prefsKey);
    final selectedMode = stored == null
        ? ThemeMode.system
        : ThemeMode.values.firstWhere(
            (mode) => mode.name == stored,
            orElse: () => ThemeMode.system,
          );
    state = selectedMode;
    AppColors.setThemeMode(selectedMode);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    AppColors.setThemeMode(mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, mode.name);
  }

  Future<void> toggleDarkMode(bool isDark) {
    return setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
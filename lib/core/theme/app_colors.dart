import 'package:flutter/material.dart';

/// Notion-inspired grey palette (Grey-100 to Grey-900).
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

  // Background colors
  static const background = grey100;
  static const surface = Colors.white;
  static const surfaceVariant = grey200;

  // Text colors
  static const textPrimary = grey900;
  static const textSecondary = grey600;
  static const textTertiary = grey500;
  static const textDisabled = grey400;

  // Border colors
  static const border = grey300;
  static const borderLight = grey200;

  // Divider
  static const divider = grey200;
}

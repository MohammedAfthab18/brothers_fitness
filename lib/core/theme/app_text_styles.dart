import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle _base({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // Display styles
  static TextStyle displayLarge({Color? color}) => _base(
    fontSize: 57,
    fontWeight: FontWeight.w600,
    color: color,
    height: 1.12,
    letterSpacing: -0.25,
  );

  static TextStyle displayMedium({Color? color}) => _base(
    fontSize: 45,
    fontWeight: FontWeight.w600,
    color: color,
    height: 1.16,
    letterSpacing: 0,
  );

  static TextStyle displaySmall({Color? color}) => _base(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    color: color,
    height: 1.22,
    letterSpacing: 0,
  );

  // Headline styles
  static TextStyle headlineLarge({Color? color}) => _base(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: color,
    height: 1.25,
    letterSpacing: 0,
  );

  static TextStyle headlineMedium({Color? color}) => _base(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: color,
    height: 1.29,
    letterSpacing: 0,
  );

  static TextStyle headlineSmall({Color? color}) => _base(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: color,
    height: 1.33,
    letterSpacing: 0,
  );

  // Title styles
  static TextStyle titleLarge({Color? color}) => _base(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: color,
    height: 1.27,
    letterSpacing: 0,
  );

  static TextStyle titleMedium({Color? color}) => _base(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: color,
    height: 1.5,
    letterSpacing: 0.15,
  );

  static TextStyle titleSmall({Color? color}) => _base(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: color,
    height: 1.43,
    letterSpacing: 0.1,
  );

  // Body styles
  static TextStyle bodyLarge({Color? color}) => _base(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: color,
    height: 1.5,
    letterSpacing: 0.5,
  );

  static TextStyle bodyMedium({Color? color}) => _base(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: color,
    height: 1.43,
    letterSpacing: 0.25,
  );

  static TextStyle bodySmall({Color? color}) => _base(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: color,
    height: 1.33,
    letterSpacing: 0.4,
  );

  // Label styles
  static TextStyle labelLarge({Color? color}) => _base(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: color,
    height: 1.43,
    letterSpacing: 0.1,
  );

  static TextStyle labelMedium({Color? color}) => _base(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: color,
    height: 1.33,
    letterSpacing: 0.5,
  );

  static TextStyle labelSmall({Color? color}) => _base(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: color,
    height: 1.45,
    letterSpacing: 0.5,
  );

  // Helper method to add fontWeight to any style
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }
}

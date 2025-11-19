import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dimensions.dart';
import 'app_text_styles.dart';

/// Notion-inspired theme configuration.
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return _themeFrom(
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        primaryContainer: AppColors.primaryLight,
        onPrimaryContainer: AppColors.primaryDark,
        secondary: AppColors.grey600,
        onSecondary: Colors.white,
        error: AppColors.error,
        onError: Colors.white,
        surface: AppColors.lightPalette.surface,
        onSurface: AppColors.lightPalette.textPrimary,
        surfaceContainerHighest: AppColors.lightPalette.surfaceVariant,
        onSurfaceVariant: AppColors.lightPalette.textSecondary,
        outline: AppColors.lightPalette.border,
      ),
      palette: AppColors.lightPalette,
    );
  }

  static ThemeData get darkTheme {
    return _themeFrom(
      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryLight,
        onPrimary: Colors.black,
        primaryContainer: AppColors.primaryDark,
        onPrimaryContainer: Colors.white,
        secondary: AppColors.grey400,
        onSecondary: Colors.black,
        error: AppColors.errorLight,
        onError: Colors.black,
        surface: AppColors.darkPalette.surface,
        onSurface: AppColors.darkPalette.textPrimary,
        surfaceContainerHighest: AppColors.darkPalette.surfaceVariant,
        onSurfaceVariant: AppColors.darkPalette.textSecondary,
        outline: AppColors.darkPalette.border,
      ),
      palette: AppColors.darkPalette,
    );
  }

  static ThemeData _themeFrom({
    required ColorScheme colorScheme,
    required AppPalette palette,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: palette.background,
      cardTheme: CardThemeData(
        color: palette.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          side: BorderSide(color: palette.border, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: palette.surface,
        foregroundColor: palette.textPrimary,
        titleTextStyle: AppTextStyles.titleLarge(color: palette.textPrimary),
        centerTitle: false,
        toolbarHeight: AppDimensions.appBarHeight,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge(color: palette.textPrimary),
        displayMedium: AppTextStyles.displayMedium(color: palette.textPrimary),
        displaySmall: AppTextStyles.displaySmall(color: palette.textPrimary),
        headlineLarge: AppTextStyles.headlineLarge(color: palette.textPrimary),
        headlineMedium:
            AppTextStyles.headlineMedium(color: palette.textPrimary),
        headlineSmall: AppTextStyles.headlineSmall(color: palette.textPrimary),
        titleLarge: AppTextStyles.titleLarge(color: palette.textPrimary),
        titleMedium: AppTextStyles.titleMedium(color: palette.textPrimary),
        titleSmall: AppTextStyles.titleSmall(color: palette.textPrimary),
        bodyLarge: AppTextStyles.bodyLarge(color: palette.textPrimary),
        bodyMedium: AppTextStyles.bodyMedium(color: palette.textPrimary),
        bodySmall: AppTextStyles.bodySmall(color: palette.textPrimary),
        labelLarge: AppTextStyles.labelLarge(color: palette.textPrimary),
        labelMedium: AppTextStyles.labelMedium(color: palette.textPrimary),
        labelSmall: AppTextStyles.labelSmall(color: palette.textPrimary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: palette.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: BorderSide(color: palette.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: BorderSide(color: palette.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing4,
          vertical: AppDimensions.spacing3,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing6,
            vertical: AppDimensions.spacing3,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          textStyle: AppTextStyles.labelLarge(),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: BorderSide(color: palette.border),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing6,
            vertical: AppDimensions.spacing3,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          textStyle: AppTextStyles.labelLarge(),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing4,
            vertical: AppDimensions.spacing2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          textStyle: AppTextStyles.labelLarge(),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: palette.divider,
        thickness: 1,
        space: 1,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: palette.surface,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        ),
        titleTextStyle: AppTextStyles.titleLarge(color: palette.textPrimary),
        contentTextStyle: AppTextStyles.bodyMedium(color: palette.textPrimary),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: palette.surface,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimensions.radiusLarge),
          ),
        ),
      ),
    );
  }
}

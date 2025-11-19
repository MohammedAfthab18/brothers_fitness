import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';

/// Notion-style search field.
class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    this.hint,
    this.controller,
    this.onChanged,
    this.onSubmitted,
  });

  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      style: AppTextStyles.bodyMedium(),
      decoration: InputDecoration(
        hintText: hint ?? 'Search...',
        hintStyle: AppTextStyles.bodyMedium(color: AppColors.textTertiary),
        prefixIcon: Icon(
          LucideIcons.search,
          size: AppDimensions.iconMedium,
          color: AppColors.textTertiary,
        ),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing4,
          vertical: AppDimensions.spacing3,
        ),
      ),
    );
  }
}

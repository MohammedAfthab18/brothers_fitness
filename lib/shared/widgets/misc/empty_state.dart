import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';

/// Empty state widget.
class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.message, this.icon, this.action});

  final String message;
  final Widget? icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(height: AppDimensions.spacing4),
            ],
            Text(
              message,
              style: AppTextStyles.bodyMedium(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              const SizedBox(height: AppDimensions.spacing6),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import 'base_card.dart';

/// Dashboard stat card matching React design.
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.color = StatCardColor.blue,
  });

  final Widget icon;
  final String label;
  final String value;
  final StatCardColor color;

  Color get _iconBgColor {
    switch (color) {
      case StatCardColor.blue:
        return AppColors.infoLight;
      case StatCardColor.orange:
        return AppColors.warningLight;
      case StatCardColor.yellow:
        return AppColors.warningLight;
      case StatCardColor.green:
        return AppColors.successLight;
    }
  }

  Color get _iconColor {
    switch (color) {
      case StatCardColor.blue:
        return AppColors.info;
      case StatCardColor.orange:
        return AppColors.warning;
      case StatCardColor.yellow:
        return AppColors.warning;
      case StatCardColor.green:
        return AppColors.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimensions.spacing3),
            decoration: BoxDecoration(
              color: _iconBgColor,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            ),
            child: IconTheme(
              data: IconThemeData(
                color: _iconColor,
                size: AppDimensions.iconLarge,
              ),
              child: icon,
            ),
          ),
          const SizedBox(height: AppDimensions.spacing4),
          Text(
            label,
            style: AppTextStyles.bodySmall(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppDimensions.spacing1),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(value, style: AppTextStyles.headlineMedium()),
            ),
          ),
        ],
      ),
    );
  }
}

enum StatCardColor { blue, orange, yellow, green }

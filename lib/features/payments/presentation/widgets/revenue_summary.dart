import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/cards/base_card.dart';

/// Revenue summary widget.
class RevenueSummary extends StatelessWidget {
  const RevenueSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Row(
        children: [
          Icon(
            LucideIcons.trendingUp,
            size: AppDimensions.iconLarge,
            color: AppColors.success,
          ),
          const SizedBox(width: AppDimensions.spacing4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Revenue',
                style: AppTextStyles.bodySmall(color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppDimensions.spacing1),
              Text('\$18,450', style: AppTextStyles.headlineLarge()),
            ],
          ),
        ],
      ),
    );
  }
}

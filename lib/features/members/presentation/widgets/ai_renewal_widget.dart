import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

/// AI renewal insights widget matching React design.
class AIRenewalWidget extends StatelessWidget {
  const AIRenewalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.grey900, AppColors.grey700],
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      ),
      padding: const EdgeInsets.all(AppDimensions.spacing6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.trendingUp,
                size: AppDimensions.iconMedium,
                color: Colors.white,
              ),
              const SizedBox(width: AppDimensions.spacing2),
              Text(
                'AI Insights',
                style: AppTextStyles.titleMedium(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacing4),
          // Renewal likelihood
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Renewal Likelihood',
                style: AppTextStyles.bodySmall(color: AppColors.grey300),
              ),
              const SizedBox(height: AppDimensions.spacing2),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.grey800,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.85,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacing3),
                  Text(
                    '85%',
                    style: AppTextStyles.headlineMedium(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacing4),
          // Recommended plan
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recommended Plan',
                style: AppTextStyles.bodySmall(color: AppColors.grey300),
              ),
              const SizedBox(height: AppDimensions.spacing1),
              Text(
                'Premium Annual',
                style: AppTextStyles.withWeight(
                  AppTextStyles.bodyMedium(color: Colors.white),
                  FontWeight.w600,
                ),
              ),
              Text(
                'Based on attendance & engagement',
                style: AppTextStyles.labelSmall(color: AppColors.grey400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';

/// AI predictions section matching React design.
class AIPredictionsSection extends StatelessWidget {
  const AIPredictionsSection({super.key});

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
      padding: const EdgeInsets.all(AppDimensions.spacing8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      LucideIcons.trendingUp,
                      size: AppDimensions.iconLarge,
                      color: Colors.white,
                    ),
                    const SizedBox(width: AppDimensions.spacing2),
                    Text(
                      'Smart AI Predictions',
                      style: AppTextStyles.titleLarge(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.spacing6),
                Text(
                  'TensorFlow Lite models predict renewal likelihood and optimal contact timing',
                  style: AppTextStyles.bodyMedium(color: AppColors.grey300),
                ),
                const SizedBox(height: AppDimensions.spacing6),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'High Renewal Risk',
                            style: AppTextStyles.bodySmall(
                              color: AppColors.grey400,
                            ),
                          ),
                          const SizedBox(height: AppDimensions.spacing1),
                          Text(
                            '8',
                            style: AppTextStyles.headlineLarge(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Optimal Contact Time',
                            style: AppTextStyles.bodySmall(
                              color: AppColors.grey400,
                            ),
                          ),
                          const SizedBox(height: AppDimensions.spacing1),
                          Text(
                            '3PM',
                            style: AppTextStyles.headlineLarge(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Success Rate',
                            style: AppTextStyles.bodySmall(
                              color: AppColors.grey400,
                            ),
                          ),
                          const SizedBox(height: AppDimensions.spacing1),
                          Text(
                            '92%',
                            style: AppTextStyles.headlineLarge(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          PrimaryButton(
            label: 'View Details',
            onPressed: () {
              // TODO: Show details
            },
          ),
        ],
      ),
    );
  }
}

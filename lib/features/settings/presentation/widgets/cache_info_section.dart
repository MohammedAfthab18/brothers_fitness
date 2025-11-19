import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/buttons/secondary_button.dart';
import '../../../../shared/widgets/cards/base_card.dart';

/// Cache info section.
class CacheInfoSection extends StatelessWidget {
  const CacheInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cache Management', style: AppTextStyles.titleMedium()),
          const SizedBox(height: AppDimensions.spacing4),
          Text(
            'Clear cached data to free up storage',
            style: AppTextStyles.bodyMedium(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppDimensions.spacing4),
          SecondaryButton(
            label: 'Clear Cache',
            onPressed: () {
              // TODO: Clear cache
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/cards/base_card.dart';

/// Recent activity section matching React design.
class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Activity', style: AppTextStyles.titleMedium()),
          const SizedBox(height: AppDimensions.spacing4),
          _ActivityItem(
            action: 'New member registered',
            name: 'James Wilson',
            time: '2 hours ago',
          ),
          const SizedBox(height: AppDimensions.spacing3),
          _ActivityItem(
            action: 'Payment received',
            name: 'Emily Rodriguez',
            time: '5 hours ago',
          ),
          const SizedBox(height: AppDimensions.spacing3),
          _ActivityItem(
            action: 'Membership renewed',
            name: 'Olivia Martinez',
            time: '1 day ago',
          ),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  const _ActivityItem({
    required this.action,
    required this.name,
    required this.time,
  });

  final String action;
  final String name;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacing3),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(
              top: 6,
              right: AppDimensions.spacing3,
            ),
            decoration: BoxDecoration(
              color: AppColors.grey400,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(action, style: AppTextStyles.bodySmall()),
                Text(
                  '$name • $time',
                  style: AppTextStyles.labelSmall(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/cards/base_card.dart';

/// Upcoming reminders section matching React design.
class UpcomingRemindersSection extends StatelessWidget {
  const UpcomingRemindersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Upcoming Reminders', style: AppTextStyles.titleMedium()),
              Icon(
                LucideIcons.calendar,
                size: AppDimensions.iconMedium,
                color: AppColors.textTertiary,
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacing4),
          _ReminderItem(
            name: 'Sarah Johnson',
            action: 'Membership expires',
            date: 'Nov 20',
          ),
          const SizedBox(height: AppDimensions.spacing3),
          _ReminderItem(
            name: 'Michael Chen',
            action: 'Payment due',
            date: 'Nov 18',
          ),
          const SizedBox(height: AppDimensions.spacing3),
          _ReminderItem(
            name: 'Staff Meeting',
            action: 'Team sync',
            date: 'Nov 19',
          ),
        ],
      ),
    );
  }
}

class _ReminderItem extends StatelessWidget {
  const _ReminderItem({
    required this.name,
    required this.action,
    required this.date,
  });

  final String name;
  final String action;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacing3),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.withWeight(
                    AppTextStyles.bodySmall(),
                    FontWeight.w500,
                  ),
                ),
                Text(
                  action,
                  style: AppTextStyles.labelSmall(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            date,
            style: AppTextStyles.labelSmall(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

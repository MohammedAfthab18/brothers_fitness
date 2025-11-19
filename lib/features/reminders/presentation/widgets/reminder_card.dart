import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/cards/base_card.dart';

/// Reminder card widget matching React design.
class ReminderCard extends StatelessWidget {
  const ReminderCard({
    super.key,
    required this.member,
    this.urgent = false,
    this.compact = false,
  });

  final Map<String, dynamic> member;
  final bool urgent;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final daysLeft = member['daysLeft'] as int;
    final renewalLikelihood = member['renewalLikelihood'] as double? ?? 0.0;

    return BaseCard(
      padding: const EdgeInsets.all(AppDimensions.spacing6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: compact ? 40 : 48,
                height: compact ? 40 : 48,
                decoration: BoxDecoration(
                  color: AppColors.grey100,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    member['photo'] as String? ?? '👤',
                    style: TextStyle(fontSize: compact ? 20 : 24),
                  ),
                ),
              ),
              const SizedBox(width: AppDimensions.spacing3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member['name'] as String,
                      style: compact
                          ? AppTextStyles.bodySmall()
                          : AppTextStyles.bodyMedium(),
                    ),
                    Text(
                      member['plan'] as String,
                      style: AppTextStyles.labelSmall(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacing4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Days Left',
                style: AppTextStyles.bodySmall(color: AppColors.textSecondary),
              ),
              Text(
                '$daysLeft ${daysLeft == 1 ? 'day' : 'days'}',
                style: AppTextStyles.withWeight(
                  AppTextStyles.bodySmall(),
                  FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacing2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'End Date',
                style: AppTextStyles.bodySmall(color: AppColors.textSecondary),
              ),
              Text(
                member['endDate'] as String,
                style: AppTextStyles.withWeight(
                  AppTextStyles.bodySmall(),
                  FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacing4),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: 'WhatsApp',
                  icon: Icon(LucideIcons.phone, size: 16),
                  onPressed: () {
                    // TODO: Send WhatsApp
                  },
                  isFullWidth: true,
                ),
              ),
              const SizedBox(width: AppDimensions.spacing2),
              IconButton(
                icon: Icon(
                  LucideIcons.mail,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
                onPressed: () {
                  // TODO: Send email
                },
              ),
            ],
          ),
          if (!compact) ...[
            const SizedBox(height: AppDimensions.spacing4),
            Divider(color: AppColors.border),
            const SizedBox(height: AppDimensions.spacing4),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppColors.grey200,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: renewalLikelihood,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.spacing3),
                Text(
                  '${(renewalLikelihood * 100).toInt()}% likely',
                  style: AppTextStyles.labelSmall(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spacing1),
            Text(
              'AI renewal prediction',
              style: AppTextStyles.labelSmall(color: AppColors.textSecondary),
            ),
          ],
        ],
      ),
    );
  }
}

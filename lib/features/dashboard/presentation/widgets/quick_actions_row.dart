import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/cards/base_card.dart';

/// Quick actions row matching React design.
class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Actions', style: AppTextStyles.titleMedium()),
          const SizedBox(height: AppDimensions.spacing4),
          Row(
            children: [
              _ActionButton(
                icon: LucideIcons.plus,
                label: 'Add Member',
                onTap: () {
                  // TODO: Navigate to add member
                },
              ),
              const SizedBox(width: AppDimensions.spacing4),
              _ActionButton(
                icon: LucideIcons.creditCard,
                label: 'Add Plan',
                onTap: () {
                  // TODO: Navigate to add plan
                },
              ),
              const SizedBox(width: AppDimensions.spacing4),
              _ActionButton(
                icon: LucideIcons.send,
                label: 'Broadcast Message',
                onTap: () {
                  // TODO: Open broadcast dialog
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing4,
          vertical: AppDimensions.spacing3,
        ),
        decoration: BoxDecoration(
          color: AppColors.grey100,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: AppDimensions.iconMedium,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: AppDimensions.spacing2),
            Text(
              label,
              style: AppTextStyles.withWeight(
                AppTextStyles.bodySmall(),
                FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

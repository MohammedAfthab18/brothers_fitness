import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/cards/base_card.dart';

/// Plan card widget matching React design.
class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.plan,
    this.onTap,
    this.onEdit,
    this.onToggle,
  });

  final Map<String, dynamic> plan;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    final isActive = plan['isActive'] as bool? ?? true;

    return BaseCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  plan['title'] as String,
                  style: AppTextStyles.titleMedium(),
                ),
              ),
              Switch(value: isActive, onChanged: (_) => onToggle?.call()),
            ],
          ),
          const SizedBox(height: AppDimensions.spacing4),
          Text('\$${plan['price']}', style: AppTextStyles.headlineLarge()),
          const SizedBox(height: AppDimensions.spacing1),
          Text(
            '${plan['duration']} days',
            style: AppTextStyles.bodySmall(color: AppColors.textSecondary),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onEdit,
                  icon: Icon(LucideIcons.edit, size: 16),
                  label: Text('Edit'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spacing3,
                      vertical: AppDimensions.spacing2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

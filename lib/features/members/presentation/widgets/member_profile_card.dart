import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/cards/base_card.dart';
import '../../../../shared/widgets/indicators/status_badge.dart';

/// Member profile card matching React design.
class MemberProfileCard extends StatelessWidget {
  const MemberProfileCard({super.key, required this.member});

  final Map<String, dynamic> member;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      padding: const EdgeInsets.all(AppDimensions.spacing8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Photo
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: AppColors.grey100,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusLarge,
                  ),
                ),
                child: Center(
                  child: Text(
                    member['photo'] as String? ?? '👤',
                    style: const TextStyle(fontSize: 48),
                  ),
                ),
              ),
              const SizedBox(width: AppDimensions.spacing6),
              // Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member['name'] as String,
                    style: AppTextStyles.headlineLarge(),
                  ),
                  const SizedBox(height: AppDimensions.spacing2),
                  Row(
                    children: [
                      Icon(
                        LucideIcons.phone,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: AppDimensions.spacing1 + 2),
                      Text(
                        member['phone'] as String,
                        style: AppTextStyles.bodySmall(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.spacing4),
                      Icon(
                        LucideIcons.mail,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: AppDimensions.spacing1 + 2),
                      Text(
                        member['email'] as String? ?? '',
                        style: AppTextStyles.bodySmall(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.spacing3),
                  StatusBadge(status: member['status'] as MemberStatus),
                ],
              ),
            ],
          ),
          // Actions
          Row(
            children: [
              IconButton(
                icon: Icon(
                  LucideIcons.edit,
                  size: AppDimensions.iconMedium,
                  color: AppColors.textSecondary,
                ),
                onPressed: () {
                  // TODO: Navigate to edit
                },
              ),
              IconButton(
                icon: Icon(
                  LucideIcons.trash2,
                  size: AppDimensions.iconMedium,
                  color: AppColors.textSecondary,
                ),
                onPressed: () {
                  // TODO: Delete member
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

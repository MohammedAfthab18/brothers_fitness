import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../data/models/member/member.dart';
import '../../../../shared/widgets/cards/base_card.dart';
import '../../../../shared/widgets/indicators/status_badge.dart';
import '../../utils/member_status_utils.dart';

/// Member profile card matching React design.
class MemberProfileCard extends StatelessWidget {
  const MemberProfileCard({
    super.key,
    required this.member,
    this.onEdit,
    this.onDelete,
  });

  final Member member;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

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
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusLarge),
                ),
                child: Center(
                  child: Text(
                    _initials(member.fullName),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppDimensions.spacing6),
              // Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.fullName,
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
                        member.phone,
                        style: AppTextStyles.bodySmall(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.spacing4),
                      Icon(
                        LucideIcons.messageCircle,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: AppDimensions.spacing1 + 2),
                      Text(
                        member.whatsappNumber,
                        style: AppTextStyles.bodySmall(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.spacing3),
                  StatusBadge(
                    status: memberStatusFromString(member.status),
                  ),
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
                onPressed: onEdit,
                tooltip: 'Edit',
              ),
              IconButton(
                icon: Icon(
                  LucideIcons.trash2,
                  size: AppDimensions.iconMedium,
                  color: AppColors.textSecondary,
                ),
                onPressed: onDelete,
                tooltip: 'Delete',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String _initials(String name) {
  final parts = name.trim().split(' ').where((p) => p.isNotEmpty).toList();
  if (parts.isEmpty) return '👤';
  final buffer = StringBuffer();
  for (final part in parts.take(2)) {
    buffer.write(part[0].toUpperCase());
  }
  return buffer.toString();
}

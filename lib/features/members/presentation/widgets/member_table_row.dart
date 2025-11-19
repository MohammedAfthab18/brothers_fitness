import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/indicators/status_badge.dart';

/// Member table row matching React design.
class MemberTableRow extends StatelessWidget {
  const MemberTableRow({super.key, required this.member, this.onTap});

  final Map<String, dynamic> member;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing6,
          vertical: AppDimensions.spacing4,
        ),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.grey200)),
        ),
        child: Row(
          children: [
            // Member (with photo)
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.grey100,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        member['photo'] as String? ?? '👤',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacing3),
                  Text(
                    member['name'] as String,
                    style: AppTextStyles.withWeight(
                      AppTextStyles.bodyMedium(),
                      FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Phone
            Expanded(
              child: Text(
                member['phone'] as String,
                style: AppTextStyles.bodySmall(color: AppColors.textSecondary),
              ),
            ),
            // Plan
            Expanded(
              child: Text(
                member['plan'] as String,
                style: AppTextStyles.bodySmall(),
              ),
            ),
            // Duration
            Expanded(
              flex: 2,
              child: Text(
                '${member['start']} → ${member['end']}',
                style: AppTextStyles.bodySmall(color: AppColors.textSecondary),
              ),
            ),
            // Status
            Expanded(
              child: StatusBadge(status: member['status'] as MemberStatus),
            ),
            // Actions
            SizedBox(
              width: 60,
              child: IconButton(
                icon: Icon(
                  LucideIcons.chevronRight,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
                onPressed: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

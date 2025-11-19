import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../data/models/member/member.dart';
import '../../../../shared/widgets/indicators/status_badge.dart';
import '../../utils/member_status_utils.dart';

/// Member table row matching React design.
class MemberTableRow extends StatelessWidget {
  const MemberTableRow({super.key, required this.member, this.onTap});

  final Member member;
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
                  _Avatar(name: member.fullName),
                  const SizedBox(width: AppDimensions.spacing3),
                  Text(
                    member.fullName,
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
                member.phone,
                style: AppTextStyles.bodySmall(color: AppColors.textSecondary),
              ),
            ),
            // Plan
            Expanded(
              child: Text(
                member.planName,
                style: AppTextStyles.bodySmall(),
              ),
            ),
            // Duration
            Expanded(
              flex: 2,
              child: Text(
                '${AppDateUtils.formatDisplayDate(member.planStartDate)} → ${AppDateUtils.formatDisplayDate(member.expiryDate)}',
                style: AppTextStyles.bodySmall(color: AppColors.textSecondary),
              ),
            ),
            // Status
            Expanded(
              child: StatusBadge(
                status: memberStatusFromString(member.status),
              ),
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

class _Avatar extends StatelessWidget {
  const _Avatar({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final initials = name.isNotEmpty
        ? name
            .trim()
            .split(' ')
            .where((part) => part.isNotEmpty)
            .take(2)
            .map((part) => part[0].toUpperCase())
            .join()
        : '?';
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.grey100,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
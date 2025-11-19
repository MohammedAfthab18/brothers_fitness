import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';

/// Status badge matching React design.
class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final MemberStatus status;

  Color get _backgroundColor {
    switch (status) {
      case MemberStatus.active:
        return AppColors.successLight;
      case MemberStatus.expiring:
        return AppColors.warningLight;
      case MemberStatus.expired:
        return AppColors.errorLight;
    }
  }

  Color get _textColor {
    switch (status) {
      case MemberStatus.active:
        return AppColors.success;
      case MemberStatus.expiring:
        return AppColors.warning;
      case MemberStatus.expired:
        return AppColors.error;
    }
  }

  Color get _borderColor {
    switch (status) {
      case MemberStatus.active:
        return AppColors.successLight;
      case MemberStatus.expiring:
        return AppColors.warningLight;
      case MemberStatus.expired:
        return AppColors.errorLight;
    }
  }

  IconData get _icon {
    switch (status) {
      case MemberStatus.active:
        return LucideIcons.checkCircle;
      case MemberStatus.expiring:
        return LucideIcons.clock;
      case MemberStatus.expired:
        return LucideIcons.xCircle;
    }
  }

  String get _label {
    switch (status) {
      case MemberStatus.active:
        return 'Active';
      case MemberStatus.expiring:
        return 'Expiring';
      case MemberStatus.expired:
        return 'Expired';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing3,
        vertical: AppDimensions.spacing1,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon, size: 14, color: _textColor),
          const SizedBox(width: AppDimensions.spacing1 + 2),
          Text(_label, style: AppTextStyles.labelSmall(color: _textColor)),
        ],
      ),
    );
  }
}

enum MemberStatus { active, expiring, expired }

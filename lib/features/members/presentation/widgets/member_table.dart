import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../data/models/member/member.dart';
import '../../../../shared/widgets/cards/base_card.dart';
import 'member_table_row.dart';

/// Notion-style members table matching React design.
class MemberTable extends StatelessWidget {
  const MemberTable({
    super.key,
    required this.members,
    this.onMemberSelected,
  });

  final List<Member> members;
  final void Function(Member member)? onMemberSelected;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _TableHeader(hasActions: onMemberSelected != null),
          if (members.isEmpty)
            Padding(
              padding: const EdgeInsets.all(AppDimensions.spacing6),
              child: Text(
                'No members found. Try adjusting filters or add a new member.',
                style: AppTextStyles.bodySmall(color: AppColors.textSecondary),
              ),
            )
          else
            ...members.map(
              (member) => MemberTableRow(
                member: member,
                onTap: onMemberSelected != null
                    ? () => onMemberSelected!(member)
                    : null,
              ),
            ),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader({required this.hasActions});

  final bool hasActions;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing6,
        vertical: AppDimensions.spacing4,
      ),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _HeaderLabel('Member'),
          ),
          Expanded(child: _HeaderLabel('Phone')),
          Expanded(child: _HeaderLabel('Plan')),
          Expanded(flex: 2, child: _HeaderLabel('Duration')),
          Expanded(child: _HeaderLabel('Status')),
          if (hasActions)
            const SizedBox(
              width: 60,
              child: _HeaderLabel('Actions'),
            ),
        ],
      ),
    );
  }
}

class _HeaderLabel extends StatelessWidget {
  const _HeaderLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.withWeight(
        AppTextStyles.labelMedium(),
        FontWeight.w600,
      ),
    );
  }
}

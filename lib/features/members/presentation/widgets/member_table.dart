import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/route_constants.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/cards/base_card.dart';
import '../../../../shared/widgets/indicators/status_badge.dart';
import 'member_table_row.dart';

/// Notion-style members table matching React design.
class MemberTable extends StatelessWidget {
  const MemberTable({super.key});

  // TODO: Replace with actual data from provider
  final List<Map<String, dynamic>> _sampleMembers = const [
    {
      'id': '1',
      'name': 'Sarah Johnson',
      'phone': '+1 234-567-8901',
      'plan': 'Premium Annual',
      'start': '2024-01-15',
      'end': '2025-01-15',
      'status': MemberStatus.active,
      'photo': '👩‍🦰',
    },
    {
      'id': '2',
      'name': 'Michael Chen',
      'phone': '+1 234-567-8902',
      'plan': 'Basic Monthly',
      'start': '2024-10-20',
      'end': '2024-11-20',
      'status': MemberStatus.expiring,
      'photo': '👨',
    },
    {
      'id': '3',
      'name': 'Emily Rodriguez',
      'phone': '+1 234-567-8903',
      'plan': 'Standard Quarterly',
      'start': '2024-08-01',
      'end': '2024-11-01',
      'status': MemberStatus.expired,
      'photo': '👩',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          // Table header
          Container(
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
                  child: Text(
                    'Member',
                    style: AppTextStyles.withWeight(
                      AppTextStyles.labelMedium(),
                      FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Phone',
                    style: AppTextStyles.withWeight(
                      AppTextStyles.labelMedium(),
                      FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Plan',
                    style: AppTextStyles.withWeight(
                      AppTextStyles.labelMedium(),
                      FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Duration',
                    style: AppTextStyles.withWeight(
                      AppTextStyles.labelMedium(),
                      FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Status',
                    style: AppTextStyles.withWeight(
                      AppTextStyles.labelMedium(),
                      FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: Text(
                    'Actions',
                    style: AppTextStyles.withWeight(
                      AppTextStyles.labelMedium(),
                      FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Table rows
          ..._sampleMembers.map(
             (member) => Builder(
               builder: (context) => MemberTableRow(
                 member: member,
                 onTap: () {
                   final id = member['id'] as String;
                   context.push(RouteConstants.memberDetailPath(id));
                 },
               ),
             ),
          ),
        ],
      ),
    );
  }
}

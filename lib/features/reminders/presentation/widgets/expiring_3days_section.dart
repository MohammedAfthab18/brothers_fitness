import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/reminder_card.dart';

/// Expiring in 3 days section matching React design.
class Expiring3DaysSection extends StatelessWidget {
  const Expiring3DaysSection({super.key});

  // TODO: Load from provider
  final List<Map<String, dynamic>> _expiring3Days = const [
    {
      'id': '1',
      'name': 'James Wilson',
      'plan': 'Premium Monthly',
      'endDate': '2024-11-23',
      'photo': '👨‍🦱',
      'daysLeft': 3,
      'renewalLikelihood': 0.82,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Expiring in 3 Days', style: AppTextStyles.titleLarge()),
            Text(
              '${_expiring3Days.length} members',
              style: AppTextStyles.bodySmall(color: AppColors.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spacing4),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: AppDimensions.spacing4,
            mainAxisSpacing: AppDimensions.spacing4,
            childAspectRatio: 1.1,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _expiring3Days.length,
          itemBuilder: (context, index) {
            return ReminderCard(member: _expiring3Days[index]);
          },
        ),
      ],
    );
  }
}

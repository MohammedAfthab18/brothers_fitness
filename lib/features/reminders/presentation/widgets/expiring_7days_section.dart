import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/reminder_card.dart';

/// Expiring in 7 days section matching React design.
class Expiring7DaysSection extends StatelessWidget {
  const Expiring7DaysSection({super.key});

  // TODO: Load from provider
  final List<Map<String, dynamic>> _expiring7Days = const [
    {
      'id': '1',
      'name': 'Olivia Martinez',
      'plan': 'Basic Annual',
      'endDate': '2024-11-27',
      'photo': '👩‍🦱',
      'daysLeft': 7,
      'renewalLikelihood': 0.90,
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
            Text('Expiring in 7 Days', style: AppTextStyles.titleLarge()),
            Text(
              '${_expiring7Days.length} members',
              style: AppTextStyles.bodySmall(color: AppColors.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spacing4),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: AppDimensions.spacing4,
            mainAxisSpacing: AppDimensions.spacing4,
            childAspectRatio: 1.0,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _expiring7Days.length,
          itemBuilder: (context, index) {
            return ReminderCard(member: _expiring7Days[index], compact: true);
          },
        ),
      ],
    );
  }
}

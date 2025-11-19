import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/layouts/page_header.dart';
import '../widgets/reminder_card.dart';

/// Expiring today section matching React design.
class ExpiringTodaySection extends StatelessWidget {
  const ExpiringTodaySection({super.key});

  // TODO: Load from provider
  final List<Map<String, dynamic>> _expiringToday = const [
    {
      'id': '1',
      'name': 'Sarah Johnson',
      'plan': 'Premium Annual',
      'endDate': '2024-11-20',
      'photo': '👩‍🦰',
      'daysLeft': 0,
      'renewalLikelihood': 0.78,
    },
    {
      'id': '2',
      'name': 'Michael Chen',
      'plan': 'Basic Monthly',
      'endDate': '2024-11-20',
      'photo': '👨',
      'daysLeft': 0,
      'renewalLikelihood': 0.65,
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
            Text('Expiring Today', style: AppTextStyles.titleLarge()),
            Text(
              '${_expiringToday.length} members',
              style: AppTextStyles.bodySmall(color: AppColors.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spacing4),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppDimensions.spacing4,
            mainAxisSpacing: AppDimensions.spacing4,
            childAspectRatio: 1.2,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _expiringToday.length,
          itemBuilder: (context, index) {
            return ReminderCard(member: _expiringToday[index], urgent: true);
          },
        ),
      ],
    );
  }
}

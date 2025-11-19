import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/cards/base_card.dart';

/// Attendance timeline widget matching React design.
class AttendanceTimeline extends StatelessWidget {
  const AttendanceTimeline({super.key});

  // TODO: Load from provider
  final List<Map<String, String>> _sampleAttendance = const [
    {'date': 'Nov 18, 2024', 'time': '06:45 AM', 'type': 'Check-in'},
    {'date': 'Nov 17, 2024', 'time': '07:15 AM', 'type': 'Check-in'},
    {'date': 'Nov 16, 2024', 'time': '06:30 AM', 'type': 'Check-in'},
    {'date': 'Nov 15, 2024', 'time': '07:00 AM', 'type': 'Check-in'},
  ];

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Attendance Timeline', style: AppTextStyles.titleMedium()),
          const SizedBox(height: AppDimensions.spacing4),
          ..._sampleAttendance.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.spacing3),
              child: _AttendanceItem(
                date: item['date']!,
                time: item['time']!,
                type: item['type']!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AttendanceItem extends StatelessWidget {
  const _AttendanceItem({
    required this.date,
    required this.time,
    required this.type,
  });

  final String date;
  final String time;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacing3),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: AppTextStyles.withWeight(
                  AppTextStyles.bodySmall(),
                  FontWeight.w500,
                ),
              ),
              Text(
                time,
                style: AppTextStyles.labelSmall(color: AppColors.textSecondary),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacing3,
              vertical: AppDimensions.spacing1,
            ),
            decoration: BoxDecoration(
              color: AppColors.successLight,
              borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
            ),
            child: Text(
              type,
              style: AppTextStyles.labelSmall(color: AppColors.success),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../data/models/attendance/attendance.dart';
import '../../../../shared/widgets/cards/base_card.dart';
import '../../providers/member_details_provider.dart';

/// Attendance timeline widget matching React design.
class AttendanceTimeline extends ConsumerWidget {
  const AttendanceTimeline({super.key, required this.memberId});

  final String memberId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceAsync = ref.watch(memberAttendanceProvider(memberId));

    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Attendance Timeline', style: AppTextStyles.titleMedium()),
          const SizedBox(height: AppDimensions.spacing4),
          attendanceAsync.when(
            data: (attendance) {
              if (attendance.isEmpty) {
                return Text(
                  'No recent attendance records.',
                  style: AppTextStyles.bodySmall(
                    color: AppColors.textSecondary,
                  ),
                );
              }
              return Column(
                children: attendance
                    .map(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppDimensions.spacing3,
                        ),
                        child: _AttendanceItem(entry: entry),
                      ),
                    )
                    .toList(),
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.all(AppDimensions.spacing2),
              child: CircularProgressIndicator(),
            ),
            error: (error, stackTrace) => Text(
              'Unable to load attendance',
              style: AppTextStyles.bodySmall(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _AttendanceItem extends StatelessWidget {
  const _AttendanceItem({required this.entry});

  final Attendance entry;

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
                AppDateUtils.formatDisplayDate(entry.date),
                style: AppTextStyles.withWeight(
                  AppTextStyles.bodySmall(),
                  FontWeight.w500,
                ),
              ),
              Text(
                DateFormat.jm().format(entry.checkInTime),
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
              entry.checkOutTime == null ? 'Checked in' : 'Completed',
              style: AppTextStyles.labelSmall(
                color: entry.checkOutTime == null
                    ? AppColors.warning
                    : AppColors.success,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

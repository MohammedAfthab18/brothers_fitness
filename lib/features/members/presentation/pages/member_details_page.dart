import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/constants/route_constants.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/cards/base_card.dart';
import '../../../../shared/widgets/indicators/status_badge.dart';
import '../../../../shared/widgets/layouts/sidebar_layout.dart';
import '../widgets/ai_renewal_widget.dart';
import '../widgets/attendance_timeline.dart';
import '../widgets/member_profile_card.dart';
import '../widgets/notes_section.dart';
import '../widgets/payments_history_widget.dart';

/// Member details page matching React design.
class MemberDetailsPage extends ConsumerWidget {
  const MemberDetailsPage({super.key, required this.memberId});

  final String memberId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Load member data from provider
    final member = {
      'id': memberId,
      'name': 'Sarah Johnson',
      'phone': '+1 234-567-8901',
      'email': 'sarah@email.com',
      'photo': '👩‍🦰',
      'status': MemberStatus.active,
      'plan': 'Premium Annual',
      'monthlyFee': 1200.0,
      'startDate': '2024-01-15',
      'endDate': '2025-01-15',
      'daysRemaining': 32,
      'totalPaid': 4800.0,
    };

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SidebarLayout(
        currentRoute: RouteConstants.members,
        onRouteChanged: (route) {
          context.go(route);
        },
        onLogout: () {
          context.go(RouteConstants.login);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacing8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                TextButton.icon(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(
                    LucideIcons.chevronLeft,
                    size: AppDimensions.iconMedium,
                  ),
                  label: Text(
                    'Back to Members',
                    style: AppTextStyles.withWeight(
                      AppTextStyles.bodySmall(),
                      FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.spacing6),
                // Profile card
                MemberProfileCard(member: member),
                const SizedBox(height: AppDimensions.spacing6),
                // Main content grid
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left column (2/3)
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          // Membership details
                          BaseCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Membership Details',
                                  style: AppTextStyles.titleMedium(),
                                ),
                                const SizedBox(height: AppDimensions.spacing4),
                                GridView.count(
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  mainAxisSpacing: AppDimensions.spacing4,
                                  crossAxisSpacing: AppDimensions.spacing4,
                                  childAspectRatio: 3,
                                  children: [
                                    _DetailItem(
                                      label: 'Current Plan',
                                      value: member['plan'] as String,
                                    ),
                                    _DetailItem(
                                      label: 'Monthly Fee',
                                      value: '\$${member['monthlyFee']}',
                                    ),
                                    _DetailItem(
                                      label: 'Start Date',
                                      value: member['startDate'] as String,
                                    ),
                                    _DetailItem(
                                      label: 'End Date',
                                      value: member['endDate'] as String,
                                    ),
                                    _DetailItem(
                                      label: 'Days Remaining',
                                      value: '${member['daysRemaining']} days',
                                    ),
                                    _DetailItem(
                                      label: 'Total Paid',
                                      value: '\$${member['totalPaid']}',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppDimensions.spacing6),
                          // Attendance timeline
                          const AttendanceTimeline(),
                          const SizedBox(height: AppDimensions.spacing6),
                          // Payment history
                          const PaymentsHistoryWidget(),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppDimensions.spacing6),
                    // Right column (1/3)
                    Expanded(
                      child: Column(
                        children: [
                          // AI Insights
                          const AIRenewalWidget(),
                          const SizedBox(height: AppDimensions.spacing6),
                          // Notes
                          const NotesSection(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  const _DetailItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppDimensions.spacing1),
        Text(value, style: AppTextStyles.bodyMedium()),
      ],
    );
  }
}

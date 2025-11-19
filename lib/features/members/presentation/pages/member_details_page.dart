import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/route_constants.dart';
import '../../../../core/router/route_guards.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../data/models/member/member.dart';
import '../../../../data/repositories/members_repository.dart';
import '../../../../shared/widgets/cards/base_card.dart';
import '../../../../shared/widgets/layouts/sidebar_layout.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../providers/member_details_provider.dart';
import '../../providers/members_list_provider.dart';
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
    return AuthGuard(
      builder: (context, ref) {
        final memberAsync = ref.watch(memberDetailsProvider(memberId));
        return Scaffold(
          body: SidebarLayout(
            currentRoute: RouteConstants.members,
            onRouteChanged: (route) {
              context.go(route);
            },
            onLogout: () async {
              await ref.read(authControllerProvider.notifier).logout();
              if (context.mounted) {
                context.go(RouteConstants.login);
              }
            },
            child: memberAsync.when(
              data: (member) => _MemberDetailsView(member: member),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.spacing6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Failed to load member details',
                        style: AppTextStyles.titleMedium(),
                      ),
                      const SizedBox(height: AppDimensions.spacing2),
                      Text(
                        error.toString(),
                        style: AppTextStyles.bodySmall(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spacing4),
                      OutlinedButton(
                        onPressed: () {
                          ref.invalidate(memberDetailsProvider(memberId));
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MemberDetailsView extends ConsumerWidget {
  const _MemberDetailsView({required this.member});

  final Member member;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
              onPressed: () => context.pop(),
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
            MemberProfileCard(
              member: member,
              onEdit: () {
                context.push(RouteConstants.memberEditPath(member.id));
              },
              onDelete: () => _confirmDelete(context, ref),
            ),
            const SizedBox(height: AppDimensions.spacing6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _MembershipDetails(member: member),
                      const SizedBox(height: AppDimensions.spacing6),
                      AttendanceTimeline(memberId: member.id),
                      const SizedBox(height: AppDimensions.spacing6),
                      PaymentsHistoryWidget(memberId: member.id),
                    ],
                  ),
                ),
                const SizedBox(width: AppDimensions.spacing6),
                Expanded(
                  child: Column(
                    children: [
                      const AIRenewalWidget(),
                      const SizedBox(height: AppDimensions.spacing6),
                      NotesSection(member: member),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete member'),
            content: Text(
              'Are you sure you want to delete ${member.fullName}? '
              'This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirmed || !context.mounted) return;

    final repository = ref.read(membersRepositoryProvider);
    await repository.deleteMember(member.id);
    ref.invalidate(membersListProvider);
    if (context.mounted) {
      context.go(RouteConstants.members);
    }
  }
}

class _MembershipDetails extends StatelessWidget {
  const _MembershipDetails({required this.member});

  final Member member;

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(symbol: '\$');
    final detailItems = [
      _DetailItem(
        label: 'Current Plan',
        value: member.planName,
      ),
      _DetailItem(
        label: 'Plan Price',
        value: currency.format(member.planPrice),
      ),
      _DetailItem(
        label: 'Last Paid',
        value: AppDateUtils.formatDisplayDate(member.lastPaidDate),
      ),
      _DetailItem(
        label: 'Expiry Date',
        value: AppDateUtils.formatDisplayDate(member.expiryDate),
      ),
      _DetailItem(
        label: 'Days Remaining',
        value:
            '${member.daysUntilExpiry > 0 ? member.daysUntilExpiry : 0} days',
      ),
      _DetailItem(
        label: 'Attendance Count',
        value: '${member.attendanceCount} visits',
      ),
    ];

    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Membership Details', style: AppTextStyles.titleMedium()),
          const SizedBox(height: AppDimensions.spacing4),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: AppDimensions.spacing4,
            crossAxisSpacing: AppDimensions.spacing4,
            childAspectRatio: 3,
            children: detailItems,
          ),
        ],
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

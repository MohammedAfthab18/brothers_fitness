import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/constants/route_constants.dart';

import '../../../../core/router/route_guards.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/inputs/search_field.dart';
import '../../../../shared/widgets/layouts/page_header.dart';
import '../../../../shared/widgets/layouts/sidebar_layout.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../providers/member_filters_provider.dart';
import '../../providers/member_search_provider.dart';
import '../../providers/members_list_provider.dart';
import '../widgets/member_table.dart';

/// Members list page matching React design.
class MembersListPage extends ConsumerWidget {
  const MembersListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membersAsync = ref.watch(filteredMembersProvider);
    final statusFilter = ref.watch(memberStatusFilterProvider);

    return AuthGuard(
      builder: (context, ref) {
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.spacing8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PageHeader(
                      title: 'Members',
                      subtitle: 'Manage your gym members',
                      action: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            tooltip: 'Refresh',
                            onPressed: () {
                              ref.invalidate(membersListProvider);
                            },
                            icon: const Icon(LucideIcons.refreshCw),
                          ),
                          const SizedBox(width: AppDimensions.spacing2),
                          PrimaryButton(
                            label: 'Add Member',
                            icon: Icon(LucideIcons.plus, size: 20),
                            onPressed: () {
                              context.push(RouteConstants.memberCreate);
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SearchField(
                            hint:
                                'Search members by name, phone, or plan...',
                            onChanged: (value) {
                              ref
                                  .read(memberSearchQueryProvider.notifier)
                                  .updateQuery(value);
                            },
                          ),
                        ),
                        const SizedBox(width: AppDimensions.spacing4),
                        _StatusFilterDropdown(
                          value: statusFilter,
                          onChanged: (filter) {
                            if (filter != null) {
                              ref
                                  .read(memberStatusFilterProvider.notifier)
                                  .setFilter(filter);
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.spacing6),
                    membersAsync.when(
                      data: (members) => MemberTable(
                        members: members,
                        onMemberSelected: (member) {
                          context.push(
                            RouteConstants.memberDetailPath(member.id),
                          );
                        },
                      ),
                      loading: () => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(AppDimensions.spacing8),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      error: (error, stackTrace) => Padding(
                        padding: const EdgeInsets.all(AppDimensions.spacing6),
                        child: Column(
                          children: [
                            Text(
                              'Failed to load members',
                              style: AppTextStyles.titleSmall(
                                color: AppColors.textPrimary,
                              ),
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
                                ref.invalidate(membersListProvider);
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StatusFilterDropdown extends StatelessWidget {
  const _StatusFilterDropdown({
    required this.value,
    required this.onChanged,
  });

  final MemberStatusFilter value;
  final ValueChanged<MemberStatusFilter?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<MemberStatusFilter>(
      value: value,
      onChanged: onChanged,
      items: MemberStatusFilter.values
          .map(
            (filter) => DropdownMenuItem(
              value: filter,
              child: Text(_label(filter)),
            ),
          )
          .toList(),
    );
  }

  String _label(MemberStatusFilter filter) {
    switch (filter) {
      case MemberStatusFilter.all:
        return 'All statuses';
      case MemberStatusFilter.active:
        return 'Active';
      case MemberStatusFilter.expiring:
        return 'Expiring';
      case MemberStatusFilter.expired:
        return 'Expired';
    }
  }
}

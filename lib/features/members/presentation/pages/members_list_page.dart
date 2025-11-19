import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/constants/route_constants.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/inputs/search_field.dart';
import '../../../../shared/widgets/layouts/page_header.dart';
import '../../../../shared/widgets/layouts/sidebar_layout.dart';
import '../widgets/member_table.dart';

/// Members list page matching React design.
class MembersListPage extends ConsumerWidget {
  const MembersListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                PageHeader(
                  title: 'Members',
                  subtitle: 'Manage your gym members',
                  action: PrimaryButton(
                    label: 'Add Member',
                  icon: Icon(LucideIcons.plus, size: 20),
                  onPressed: () {
                    context.push(RouteConstants.memberCreate);
                  },
                  ),
                ),
                // Search and filters
                Row(
                  children: [
                    Expanded(
                      child: SearchField(
                        hint: 'Search members by name, phone, or plan...',
                        onChanged: (value) {
                          // TODO: Implement search
                        },
                      ),
                    ),
                    const SizedBox(width: AppDimensions.spacing4),
                    OutlinedButton.icon(
                      onPressed: () {
                        // TODO: Open filters
                      },
                      icon: Icon(
                        LucideIcons.filter,
                        size: AppDimensions.iconMedium,
                      ),
                      label: Text(
                        'Filters',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.spacing4,
                          vertical: AppDimensions.spacing3,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.spacing6),
                // Members table
                const MemberTable(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

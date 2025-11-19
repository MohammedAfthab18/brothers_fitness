import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../shared/widgets/cards/stat_card.dart';
import '../../../../shared/widgets/layouts/page_header.dart';
import '../../../../shared/widgets/layouts/sidebar_layout.dart';
import '../widgets/quick_actions_row.dart';
import '../widgets/recent_activity_section.dart';
import '../widgets/upcoming_reminders_section.dart';

/// Dashboard page matching React design.
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SidebarLayout(
        currentRoute: '/dashboard',
        onRouteChanged: (route) {
          // TODO: Navigate using router
        },
        onLogout: () {
          // TODO: Handle logout
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacing8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PageHeader(
                  title: 'Dashboard',
                  subtitle: 'Welcome back! Here\'s what\'s happening today.',
                ),
                // Stats grid
                GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: AppDimensions.spacing6,
                  crossAxisSpacing: AppDimensions.spacing6,
                  childAspectRatio: 1.2,
                  children: [
                    StatCard(
                      icon: Icon(LucideIcons.users),
                      label: 'Active Members',
                      value: '245',
                      color: StatCardColor.blue,
                    ),
                    StatCard(
                      icon: Icon(LucideIcons.alertCircle),
                      label: 'Expiring Today',
                      value: '3',
                      color: StatCardColor.orange,
                    ),
                    StatCard(
                      icon: Icon(LucideIcons.clock),
                      label: 'Expiring This Week',
                      value: '12',
                      color: StatCardColor.yellow,
                    ),
                    StatCard(
                      icon: Icon(LucideIcons.trendingUp),
                      label: 'Total Revenue',
                      value: '\$18,450',
                      color: StatCardColor.green,
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.spacing8),
                // Quick Actions
                const QuickActionsRow(),
                const SizedBox(height: AppDimensions.spacing8),
                // Two column layout
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: const UpcomingRemindersSection()),
                    const SizedBox(width: AppDimensions.spacing6),
                    Expanded(child: const RecentActivitySection()),
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/constants/route_constants.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/router/route_guards.dart';
import '../../../../shared/widgets/cards/stat_card.dart';
import '../../../../shared/widgets/layouts/page_header.dart';
import '../../../../shared/widgets/layouts/sidebar_layout.dart';
import '../../../auth/providers/auth_provider.dart';
import '../widgets/quick_actions_row.dart';
import '../widgets/recent_activity_section.dart';
import '../widgets/upcoming_reminders_section.dart';

/// Dashboard page matching React design.
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AuthGuard(
      builder: (context, ref) {
        return Scaffold(
          body: SidebarLayout(
            currentRoute: RouteConstants.dashboard,
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
                    const PageHeader(
                      title: 'Dashboard',
                      subtitle: 'Welcome back! Here\'s what\'s happening today.',
                    ),
                    const SizedBox(height: AppDimensions.spacing6),
                    const _StatsGrid(),
                    const SizedBox(height: AppDimensions.spacing8),
                    const QuickActionsRow(),
                    const SizedBox(height: AppDimensions.spacing8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(child: UpcomingRemindersSection()),
                        SizedBox(width: AppDimensions.spacing6),
                        Expanded(child: RecentActivitySection()),
                      ],
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

class _StatsGrid extends StatelessWidget {
  const _StatsGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        int crossAxisCount = 1;
        if (width >= 1200) {
          crossAxisCount = 4;
        } else if (width >= 900) {
          crossAxisCount = 3;
        } else if (width >= 600) {
          crossAxisCount = 2;
        }

        return GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: AppDimensions.spacing6,
            crossAxisSpacing: AppDimensions.spacing6,
            childAspectRatio: 1.2,
          ),
          children: const [
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
        );
      },
    );
  }
}

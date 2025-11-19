import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/route_constants.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../shared/widgets/layouts/page_header.dart';
import '../../../../shared/widgets/layouts/sidebar_layout.dart';
import '../widgets/ai_predictions_section.dart';
import '../widgets/expiring_3days_section.dart';
import '../widgets/expiring_7days_section.dart';
import '../widgets/expiring_today_section.dart';

/// Reminders page matching React design.
class RemindersPage extends ConsumerWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SidebarLayout(
        currentRoute: RouteConstants.reminders,
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
                const PageHeader(
                  title: 'Expiry Reminders',
                  subtitle: 'Track and notify members about upcoming renewals',
                ),
                // AI Predictions
                const AIPredictionsSection(),
                const SizedBox(height: AppDimensions.spacing6),
                // Expiring Today
                const ExpiringTodaySection(),
                const SizedBox(height: AppDimensions.spacing6),
                // Expiring in 3 Days
                const Expiring3DaysSection(),
                const SizedBox(height: AppDimensions.spacing6),
                // Expiring in 7 Days
                const Expiring7DaysSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/route_constants.dart';

import '../../../../core/router/route_guards.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../shared/widgets/layouts/page_header.dart';
import '../../../../shared/widgets/layouts/sidebar_layout.dart';
import '../../../auth/providers/auth_provider.dart';
import '../widgets/ai_predictions_section.dart';
import '../widgets/expiring_3days_section.dart';
import '../widgets/expiring_7days_section.dart';
import '../widgets/expiring_today_section.dart';

/// Reminders page matching React design.
class RemindersPage extends ConsumerWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AuthGuard(
      builder: (context, ref) {
        return Scaffold(
          body: SidebarLayout(
            currentRoute: RouteConstants.reminders,
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
                  children: const [
                    PageHeader(
                      title: 'Expiry Reminders',
                      subtitle:
                          'Track and notify members about upcoming renewals',
                    ),
                    AIPredictionsSection(),
                    SizedBox(height: AppDimensions.spacing6),
                    ExpiringTodaySection(),
                    SizedBox(height: AppDimensions.spacing6),
                    Expiring3DaysSection(),
                    SizedBox(height: AppDimensions.spacing6),
                    Expiring7DaysSection(),
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/constants/route_constants.dart';

import '../../../../core/router/route_guards.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/layouts/page_header.dart';
import '../../../../shared/widgets/layouts/sidebar_layout.dart';
import '../../../auth/providers/auth_provider.dart';
import '../widgets/plan_card.dart';

/// Plans list page matching React design.
class PlansListPage extends ConsumerWidget {
  const PlansListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Load plans from provider
    final plans = [
      {
        'id': '1',
        'title': 'Basic Monthly',
        'price': 50.0,
        'duration': 30,
        'isActive': true,
      },
      {
        'id': '2',
        'title': 'Standard Quarterly',
        'price': 120.0,
        'duration': 90,
        'isActive': true,
      },
      {
        'id': '3',
        'title': 'Premium Monthly',
        'price': 80.0,
        'duration': 30,
        'isActive': true,
      },
      {
        'id': '4',
        'title': 'Premium Annual',
        'price': 900.0,
        'duration': 365,
        'isActive': true,
      },
    ];

    return AuthGuard(
      builder: (context, ref) {
        return Scaffold(
          body: SidebarLayout(
            currentRoute: RouteConstants.plans,
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
                      title: 'Plans & Pricing',
                      subtitle: 'Manage subscription plans',
                      action: PrimaryButton(
                        label: 'Add Plan',
                        icon: Icon(LucideIcons.plus, size: 20),
                        onPressed: () {
                          // TODO: Navigate to add plan
                        },
                      ),
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.maxWidth;
                        int crossAxisCount = 1;
                        if (width >= 1400) {
                          crossAxisCount = 4;
                        } else if (width >= 1024) {
                          crossAxisCount = 3;
                        } else if (width >= 720) {
                          crossAxisCount = 2;
                        }

                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: AppDimensions.spacing6,
                            mainAxisSpacing: AppDimensions.spacing6,
                            childAspectRatio: 0.8,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: plans.length,
                          itemBuilder: (context, index) {
                            return PlanCard(plan: plans[index]);
                          },
                        );
                      },
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

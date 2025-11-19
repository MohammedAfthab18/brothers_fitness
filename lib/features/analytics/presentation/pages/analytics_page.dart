import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/route_constants.dart';
import '../../../../core/router/route_guards.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/cards/base_card.dart';
import '../../../../shared/widgets/layouts/page_header.dart';
import '../../../../shared/widgets/layouts/sidebar_layout.dart';
import '../../../auth/providers/auth_provider.dart';

class AnalyticsPage extends ConsumerWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AuthGuard(
      builder: (context, ref) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(onPressed: () => context.pop()),
            title: const Text('Analytics'),
          ),
          body: SidebarLayout(
            currentRoute: RouteConstants.analytics,
            onRouteChanged: (route) {
              context.go(route);
            },
            onLogout: () async {
              await ref.read(authControllerProvider.notifier).logout();
              if (context.mounted) {
                context.go(RouteConstants.login);
              }
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final isTwoColumn = width > 1100;
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(AppDimensions.spacing8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PageHeader(
                        title: 'Analytics',
                        subtitle: 'Deep dive into revenue, attendance, and growth',
                      ),
                      const SizedBox(height: AppDimensions.spacing6),
                      Wrap(
                        spacing: AppDimensions.spacing6,
                        runSpacing: AppDimensions.spacing6,
                        children: List.generate(
                          4,
                          (index) => SizedBox(
                            width: _cardWidth(width, isTwoColumn),
                            child: const _AnalyticsCard(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _AnalyticsCard extends StatelessWidget {
  const _AnalyticsCard();

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Coming soon', style: AppTextStyles.titleMedium()),
          const SizedBox(height: AppDimensions.spacing2),
          Text(
            'Analytics visualizations will appear here.',
            style: AppTextStyles.bodySmall(),
          ),
        ],
      ),
    );
  }
}

double _cardWidth(double availableWidth, bool isTwoColumn) {
  final rawWidth = isTwoColumn
      ? (availableWidth / 2) - AppDimensions.spacing6 * 1.5
      : availableWidth;
  final minWidth = 280.0;
  return rawWidth.clamp(minWidth, availableWidth);
}


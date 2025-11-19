import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/layouts/page_header.dart';
import '../../../../shared/widgets/layouts/sidebar_layout.dart';
import '../widgets/payment_card.dart';
import '../widgets/revenue_summary.dart';

/// Payments list page matching React design.
class PaymentsListPage extends ConsumerWidget {
  const PaymentsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Load payments from provider
    final payments = [
      {
        'id': '1',
        'memberName': 'Sarah Johnson',
        'amount': 1200.0,
        'date': 'Oct 15, 2024',
        'status': 'Paid',
      },
      {
        'id': '2',
        'memberName': 'Michael Chen',
        'amount': 50.0,
        'date': 'Oct 20, 2024',
        'status': 'Paid',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SidebarLayout(
        currentRoute: '/payments',
        onRouteChanged: (route) {
          // TODO: Navigate
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
                PageHeader(
                  title: 'Payments',
                  subtitle: 'View and manage all payments',
                  action: PrimaryButton(
                    label: 'Add Payment',
                    icon: Icon(LucideIcons.plus, size: 20),
                    onPressed: () {
                      // TODO: Navigate to add payment
                    },
                  ),
                ),
                // Revenue summary
                const RevenueSummary(),
                const SizedBox(height: AppDimensions.spacing8),
                // Payments list
                ...payments.map(
                  (payment) => Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppDimensions.spacing4,
                    ),
                    child: PaymentCard(payment: payment),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

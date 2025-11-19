import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/cards/base_card.dart';

/// Payment history widget matching React design.
class PaymentsHistoryWidget extends StatelessWidget {
  const PaymentsHistoryWidget({super.key});

  // TODO: Load from provider
  final List<Map<String, dynamic>> _samplePayments = const [
    {'date': 'Oct 15, 2024', 'amount': 1200.0, 'status': 'Paid'},
    {'date': 'Sep 15, 2024', 'amount': 1200.0, 'status': 'Paid'},
    {'date': 'Aug 15, 2024', 'amount': 1200.0, 'status': 'Paid'},
  ];

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment History', style: AppTextStyles.titleMedium()),
          const SizedBox(height: AppDimensions.spacing4),
          ..._samplePayments.map(
            (payment) => Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.spacing3),
              child: _PaymentItem(
                date: payment['date'] as String,
                amount: payment['amount'] as double,
                status: payment['status'] as String,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentItem extends StatelessWidget {
  const _PaymentItem({
    required this.date,
    required this.amount,
    required this.status,
  });

  final String date;
  final double amount;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacing3),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$$amount',
                style: AppTextStyles.withWeight(
                  AppTextStyles.bodySmall(),
                  FontWeight.w500,
                ),
              ),
              Text(
                date,
                style: AppTextStyles.labelSmall(color: AppColors.textSecondary),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacing3,
              vertical: AppDimensions.spacing1,
            ),
            decoration: BoxDecoration(
              color: AppColors.successLight,
              borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
            ),
            child: Text(
              status,
              style: AppTextStyles.labelSmall(color: AppColors.success),
            ),
          ),
        ],
      ),
    );
  }
}

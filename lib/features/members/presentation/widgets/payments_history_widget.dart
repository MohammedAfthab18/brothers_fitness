import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../data/models/payment/payment.dart';
import '../../../../shared/widgets/cards/base_card.dart';
import '../../providers/member_details_provider.dart';

/// Payment history widget matching React design.
class PaymentsHistoryWidget extends ConsumerWidget {
  const PaymentsHistoryWidget({super.key, required this.memberId});

  final String memberId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentsAsync = ref.watch(memberPaymentsProvider(memberId));
    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment History', style: AppTextStyles.titleMedium()),
          const SizedBox(height: AppDimensions.spacing4),
          paymentsAsync.when(
            data: (payments) {
              if (payments.isEmpty) {
                return Text(
                  'No payments recorded yet.',
                  style: AppTextStyles.bodySmall(
                    color: AppColors.textSecondary,
                  ),
                );
              }
              return Column(
                children: payments
                    .map(
                      (payment) => Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppDimensions.spacing3,
                        ),
                        child: _PaymentItem(payment: payment),
                      ),
                    )
                    .toList(),
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.all(AppDimensions.spacing2),
              child: CircularProgressIndicator(),
            ),
            error: (error, stackTrace) => Text(
              'Unable to load payments',
              style: AppTextStyles.bodySmall(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentItem extends StatelessWidget {
  const _PaymentItem({required this.payment});

  final Payment payment;

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
                NumberFormat.currency(symbol: '\$').format(payment.amount),
                style: AppTextStyles.withWeight(
                  AppTextStyles.bodySmall(),
                  FontWeight.w500,
                ),
              ),
              Text(
                AppDateUtils.formatDisplayDate(payment.paidAt),
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
              'Paid',
              style: AppTextStyles.labelSmall(color: AppColors.success),
            ),
          ),
        ],
      ),
    );
  }
}

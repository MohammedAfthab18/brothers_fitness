import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/cards/base_card.dart';

/// Payment card widget.
class PaymentCard extends StatelessWidget {
  const PaymentCard({super.key, required this.payment, this.onTap});

  final Map<String, dynamic> payment;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                payment['memberName'] as String,
                style: AppTextStyles.titleMedium(),
              ),
              const SizedBox(height: AppDimensions.spacing1),
              Text(
                payment['date'] as String,
                style: AppTextStyles.bodySmall(color: AppColors.textSecondary),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${payment['amount']}',
                style: AppTextStyles.titleMedium(),
              ),
              const SizedBox(height: AppDimensions.spacing1),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacing3,
                  vertical: AppDimensions.spacing1,
                ),
                decoration: BoxDecoration(
                  color: AppColors.successLight,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusRound,
                  ),
                ),
                child: Text(
                  payment['status'] as String,
                  style: AppTextStyles.labelSmall(color: AppColors.success),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

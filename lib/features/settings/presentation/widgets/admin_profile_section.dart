import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/cards/base_card.dart';
import '../../../../shared/widgets/inputs/custom_text_field.dart';

/// Admin profile section.
class AdminProfileSection extends StatelessWidget {
  const AdminProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Admin Profile', style: AppTextStyles.titleMedium()),
          const SizedBox(height: AppDimensions.spacing6),
          CustomTextField(label: 'Display Name', hint: 'Admin'),
          const SizedBox(height: AppDimensions.spacing4),
          CustomTextField(
            label: 'Email',
            hint: 'admin@brothersfitness.com',
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }
}

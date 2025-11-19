import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/cards/base_card.dart';
import '../../../../shared/widgets/inputs/custom_text_field.dart';

/// WhatsApp configuration section.
class WhatsAppConfigSection extends StatelessWidget {
  const WhatsAppConfigSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('WhatsApp Configuration', style: AppTextStyles.titleMedium()),
          const SizedBox(height: AppDimensions.spacing6),
          CustomTextField(
            label: 'Phone Number ID',
            hint: 'Enter WhatsApp Phone Number ID',
          ),
          const SizedBox(height: AppDimensions.spacing4),
          CustomTextField(
            label: 'Access Token',
            hint: 'Enter access token',
            obscureText: true,
          ),
        ],
      ),
    );
  }
}

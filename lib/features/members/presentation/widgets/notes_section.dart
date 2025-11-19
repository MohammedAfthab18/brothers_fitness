import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/cards/base_card.dart';

/// Notes section widget matching React design.
class NotesSection extends StatelessWidget {
  const NotesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Notes', style: AppTextStyles.titleMedium()),
          const SizedBox(height: AppDimensions.spacing4),
          TextField(
            maxLines: 8,
            style: AppTextStyles.bodyMedium(),
            decoration: InputDecoration(
              hintText: 'Add notes about this member...',
              hintStyle: AppTextStyles.bodyMedium(
                color: AppColors.textTertiary,
              ),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                borderSide: BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                borderSide: BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
              contentPadding: const EdgeInsets.all(AppDimensions.spacing4),
            ),
          ),
          const SizedBox(height: AppDimensions.spacing3),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: 'Save Note',
              onPressed: () {
                // TODO: Save note
              },
              isFullWidth: true,
            ),
          ),
        ],
      ),
    );
  }
}

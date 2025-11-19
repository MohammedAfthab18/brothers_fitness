import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/buttons/secondary_button.dart';
import '../../../../shared/widgets/cards/base_card.dart';
import '../../../../shared/widgets/inputs/custom_text_field.dart';
import '../../../../shared/widgets/layouts/sidebar_layout.dart';

/// Add/Edit member page matching React design.
class AddEditMemberPage extends ConsumerStatefulWidget {
  const AddEditMemberPage({super.key, this.memberId});

  final String? memberId;

  @override
  ConsumerState<AddEditMemberPage> createState() => _AddEditMemberPageState();
}

class _AddEditMemberPageState extends ConsumerState<AddEditMemberPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.memberId != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SidebarLayout(
        currentRoute: '/members',
        onRouteChanged: (route) {
          // TODO: Navigate
        },
        onLogout: () {
          // TODO: Handle logout
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacing8),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  TextButton.icon(
                    onPressed: () {
                      // TODO: Navigate back
                    },
                    icon: Icon(
                      LucideIcons.chevronLeft,
                      size: AppDimensions.iconMedium,
                    ),
                    label: Text(
                      'Back to Members',
                      style: AppTextStyles.withWeight(
                        AppTextStyles.bodySmall(),
                        FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacing6),
                  // Header
                  Text(
                    isEdit ? 'Edit Member' : 'Add New Member',
                    style: AppTextStyles.headlineLarge(),
                  ),
                  const SizedBox(height: AppDimensions.spacing2),
                  Text(
                    'Fill in the member details below',
                    style: AppTextStyles.bodyMedium(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacing8),
                  // Form sections
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1024),
                    child: Column(
                      children: [
                        // Personal Information
                        BaseCard(
                          padding: const EdgeInsets.all(AppDimensions.spacing8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Personal Information',
                                style: AppTextStyles.titleMedium(),
                              ),
                              const SizedBox(height: AppDimensions.spacing6),
                              // Photo upload
                              Row(
                                children: [
                                  Container(
                                    width: 96,
                                    height: 96,
                                    decoration: BoxDecoration(
                                      color: AppColors.grey100,
                                      borderRadius: BorderRadius.circular(
                                        AppDimensions.radiusLarge,
                                      ),
                                    ),
                                    child: Icon(
                                      LucideIcons.upload,
                                      size: 32,
                                      color: AppColors.textTertiary,
                                    ),
                                  ),
                                  const SizedBox(width: AppDimensions.spacing6),
                                  SecondaryButton(
                                    label: 'Upload Photo',
                                    onPressed: () {
                                      // TODO: Upload photo
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppDimensions.spacing6),
                              // Form fields
                              GridView.count(
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                mainAxisSpacing: AppDimensions.spacing6,
                                crossAxisSpacing: AppDimensions.spacing6,
                                childAspectRatio: 1.5,
                                children: [
                                  CustomTextField(
                                    label: 'Full Name',
                                    hint: 'John Doe',
                                  ),
                                  CustomTextField(
                                    label: 'Phone Number',
                                    hint: '+1 234-567-8900',
                                    keyboardType: TextInputType.phone,
                                  ),
                                  CustomTextField(
                                    label: 'Email',
                                    hint: 'john@example.com',
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  CustomTextField(
                                    label: 'Date of Birth',
                                    hint: 'YYYY-MM-DD',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spacing6),
                        // Membership Details
                        BaseCard(
                          padding: const EdgeInsets.all(AppDimensions.spacing8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Membership Details',
                                style: AppTextStyles.titleMedium(),
                              ),
                              const SizedBox(height: AppDimensions.spacing6),
                              GridView.count(
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                mainAxisSpacing: AppDimensions.spacing6,
                                crossAxisSpacing: AppDimensions.spacing6,
                                childAspectRatio: 1.5,
                                children: [
                                  CustomTextField(
                                    label: 'Select Plan',
                                    hint: 'Choose a plan',
                                  ),
                                  CustomTextField(
                                    label: 'Start Date',
                                    hint: 'YYYY-MM-DD',
                                  ),
                                  CustomTextField(
                                    label: 'End Date',
                                    hint: 'Auto-calculated',
                                  ),
                                  CustomTextField(
                                    label: 'Payment Amount',
                                    hint: '\$0.00',
                                    keyboardType: TextInputType.number,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spacing6),
                        // Additional Information
                        BaseCard(
                          padding: const EdgeInsets.all(AppDimensions.spacing8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Additional Information',
                                style: AppTextStyles.titleMedium(),
                              ),
                              const SizedBox(height: AppDimensions.spacing6),
                              CustomTextField(
                                label: 'Notes',
                                hint: 'Add any additional notes...',
                                maxLines: 4,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spacing6),
                        // Actions
                        Row(
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                label: isEdit ? 'Update Member' : 'Add Member',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // TODO: Save member
                                  }
                                },
                                isFullWidth: true,
                              ),
                            ),
                            const SizedBox(width: AppDimensions.spacing4),
                            SecondaryButton(
                              label: 'Cancel',
                              onPressed: () {
                                // TODO: Navigate back
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/route_constants.dart';
import '../../../../core/router/route_guards.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../data/models/member/member.dart';
import '../../../../data/repositories/members_repository.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/buttons/secondary_button.dart';
import '../../../../shared/widgets/cards/base_card.dart';
import '../../../../shared/widgets/inputs/custom_text_field.dart';
import '../../../../shared/widgets/layouts/sidebar_layout.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../providers/member_details_provider.dart';
import '../../providers/members_list_provider.dart';
import '../../utils/member_status_utils.dart';
import '../../../../shared/widgets/indicators/status_badge.dart';

/// Add/Edit member page matching React design.
class AddEditMemberPage extends ConsumerStatefulWidget {
  const AddEditMemberPage({super.key, this.memberId});

  final String? memberId;

  @override
  ConsumerState<AddEditMemberPage> createState() => _AddEditMemberPageState();
}

class _AddEditMemberPageState extends ConsumerState<AddEditMemberPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _planNameController = TextEditingController();
  final _planPriceController = TextEditingController();
  final _planDurationController = TextEditingController(text: '30');
  final _lastPaidAmountController = TextEditingController();
  final _lastPaidDateController =
      TextEditingController(text: AppDateUtils.formatInputDate(DateTime.now()));
  final _expiryDateController = TextEditingController(
    text: AppDateUtils.formatInputDate(
      DateTime.now().add(const Duration(days: 30)),
    ),
  );

  MemberStatus _selectedStatus = MemberStatus.active;
  bool _isSubmitting = false;
  bool _hasPrefilled = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _whatsappController.dispose();
    _planNameController.dispose();
    _planPriceController.dispose();
    _planDurationController.dispose();
    _lastPaidAmountController.dispose();
    _lastPaidDateController.dispose();
    _expiryDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.memberId != null;
    final memberAsync = widget.memberId == null
        ? const AsyncValue<Member?>.data(null)
        : ref.watch(memberDetailsProvider(widget.memberId!));

    return AuthGuard(
      builder: (context, ref) {
        return memberAsync.when(
          data: (member) {
            if (member != null && !_hasPrefilled) {
              _prefillMember(member);
            }

            return Scaffold(
              body: SidebarLayout(
                currentRoute: RouteConstants.members,
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton.icon(
                            onPressed: () => context.pop(),
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
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1024),
                            child: Column(
                              children: [
                                BaseCard(
                                  padding: const EdgeInsets.all(
                                    AppDimensions.spacing8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Personal Information',
                                        style: AppTextStyles.titleMedium(),
                                      ),
                                      const SizedBox(
                                          height: AppDimensions.spacing6),
                                      GridView.count(
                                        crossAxisCount: 2,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        mainAxisSpacing:
                                            AppDimensions.spacing6,
                                        crossAxisSpacing:
                                            AppDimensions.spacing6,
                                        childAspectRatio: 1.5,
                                        children: [
                                          CustomTextField(
                                            label: 'Full Name',
                                            controller: _nameController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'Name is required';
                                              }
                                              return null;
                                            },
                                          ),
                                          CustomTextField(
                                            label: 'Phone Number',
                                            controller: _phoneController,
                                            keyboardType: TextInputType.phone,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'Phone is required';
                                              }
                                              return null;
                                            },
                                          ),
                                          CustomTextField(
                                            label: 'WhatsApp Number',
                                            controller: _whatsappController,
                                            keyboardType: TextInputType.phone,
                                          ),
                                          DropdownButtonFormField<MemberStatus>(
                                            // ignore: deprecated_member_use
                                            value: _selectedStatus,
                                            decoration: const InputDecoration(
                                              labelText: 'Status',
                                            ),
                                            items: MemberStatus.values
                                                .map(
                                                  (status) =>
                                                      DropdownMenuItem(
                                                    value: status,
                                                    child: Text(
                                                      status.name[0]
                                                              .toUpperCase() +
                                                          status.name
                                                              .substring(1),
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged: (status) {
                                              if (status != null) {
                                                setState(() {
                                                  _selectedStatus = status;
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: AppDimensions.spacing6),
                                BaseCard(
                                  padding: const EdgeInsets.all(
                                    AppDimensions.spacing8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Membership Details',
                                        style: AppTextStyles.titleMedium(),
                                      ),
                                      const SizedBox(
                                          height: AppDimensions.spacing6),
                                      GridView.count(
                                        crossAxisCount: 2,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        mainAxisSpacing:
                                            AppDimensions.spacing6,
                                        crossAxisSpacing:
                                            AppDimensions.spacing6,
                                        childAspectRatio: 1.5,
                                        children: [
                                          CustomTextField(
                                            label: 'Plan Name',
                                            controller: _planNameController,
                                            hint: 'Premium Annual',
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'Plan name is required';
                                              }
                                              return null;
                                            },
                                          ),
                                          CustomTextField(
                                            label: 'Plan Price',
                                            controller: _planPriceController,
                                            hint: '1200',
                                            keyboardType:
                                                TextInputType.number,
                                          ),
                                          CustomTextField(
                                            label: 'Plan Duration (days)',
                                            controller: _planDurationController,
                                            keyboardType:
                                                TextInputType.number,
                                          ),
                                          CustomTextField(
                                            label: 'Last Paid Amount',
                                            controller:
                                                _lastPaidAmountController,
                                            keyboardType:
                                                TextInputType.number,
                                          ),
                                          CustomTextField(
                                            label: 'Last Paid Date',
                                            controller:
                                                _lastPaidDateController,
                                            readOnly: true,
                                            onTap: () =>
                                                _pickDate(_lastPaidDateController),
                                          ),
                                          CustomTextField(
                                            label: 'Expiry Date',
                                            controller: _expiryDateController,
                                            readOnly: true,
                                            onTap: () =>
                                                _pickDate(_expiryDateController),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: AppDimensions.spacing6),
                                Row(
                                  children: [
                                    Expanded(
                                      child: PrimaryButton(
                                        label: isEdit
                                            ? 'Update Member'
                                            : 'Add Member',
                                        isFullWidth: true,
                                        isLoading: _isSubmitting,
                                        onPressed: _isSubmitting
                                            ? null
                                            : () => _handleSubmit(member),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: AppDimensions.spacing4,
                                    ),
                                    SecondaryButton(
                                      label: 'Cancel',
                                      onPressed: () => context.pop(),
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
          },
          loading: () => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          error: (error, stackTrace) => Scaffold(
            body: Center(
              child: Text(
                'Failed to load member data',
                style: AppTextStyles.bodyMedium(),
              ),
            ),
          ),
        );
      },
    );
  }

  void _prefillMember(Member member) {
    _nameController.text = member.fullName;
    _phoneController.text = member.phone;
    _whatsappController.text = member.whatsappNumber;
    _planNameController.text = member.planName;
    _planPriceController.text = member.planPrice.toStringAsFixed(2);
    _planDurationController.text = member.planDurationDays.toString();
    _lastPaidAmountController.text = member.lastPaidAmount.toStringAsFixed(2);
    _lastPaidDateController.text =
        AppDateUtils.formatInputDate(member.lastPaidDate);
    _expiryDateController.text =
        AppDateUtils.formatInputDate(member.expiryDate);
    _selectedStatus = memberStatusFromString(member.status);
    _hasPrefilled = true;
  }

  Future<void> _pickDate(TextEditingController controller) async {
    final initialDate =
        AppDateUtils.tryParseInput(controller.text) ?? DateTime.now();
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: initialDate,
    );
    if (date != null) {
      controller.text = AppDateUtils.formatInputDate(date);
    }
  }

  Future<void> _handleSubmit(Member? existingMember) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _isSubmitting = true);

    final repository = ref.read(membersRepositoryProvider);
    final now = DateTime.now();
    final id = existingMember?.id ?? const Uuid().v4();
    final planId = existingMember?.planId ?? const Uuid().v4();
    final lastPaidDate =
        AppDateUtils.tryParseInput(_lastPaidDateController.text) ?? now;
    final expiryDate =
        AppDateUtils.tryParseInput(_expiryDateController.text) ??
        now.add(const Duration(days: 30));

    final member = Member(
      id: id,
      fullName: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      whatsappNumber: _whatsappController.text.trim().isEmpty
          ? _phoneController.text.trim()
          : _whatsappController.text.trim(),
      status: memberStatusToString(_selectedStatus),
      planId: planId,
      planName: _planNameController.text.trim(),
      planPrice: double.tryParse(_planPriceController.text) ?? 0,
      planDurationDays: int.tryParse(_planDurationController.text) ?? 30,
      lastPaidAmount: double.tryParse(_lastPaidAmountController.text) ?? 0,
      lastPaidDate: lastPaidDate,
      expiryDate: expiryDate,
      attendanceCount: existingMember?.attendanceCount ?? 0,
      photoBase64: existingMember?.photoBase64,
      notes: existingMember?.notes ?? const [],
      createdAt: existingMember?.createdAt ?? now,
      updatedAt: now,
      lastSyncedAt: existingMember?.lastSyncedAt,
      isSynced: false,
    );

    if (existingMember == null) {
      await repository.createMember(member);
    } else {
      await repository.updateMember(member);
      ref.invalidate(memberDetailsProvider(member.id));
    }
    ref.invalidate(membersListProvider);

    setState(() => _isSubmitting = false);

    if (!mounted) return;
    context.go(RouteConstants.memberDetailPath(member.id));
  }
}

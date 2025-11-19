import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/route_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/inputs/custom_text_field.dart';
import '../../providers/auth_provider.dart';
import '../../providers/auth_state_provider.dart';
import '../widgets/login_image_panel.dart';

/// Notion-style login page matching React design.
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    ref.listen(authStateProvider, (previous, next) {
      next.whenData((user) {
        if (user != null && mounted) {
          context.go(RouteConstants.dashboard);
        }
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    await ref
        .read(authControllerProvider.notifier)
        .login(_emailController.text.trim(), _passwordController.text.trim());

    final state = ref.read(authControllerProvider);
    if (state.hasError && mounted) {
      final message = state.error?.toString() ?? 'Failed to sign in';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } else if (mounted) {
      context.go(RouteConstants.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authStatus = ref.watch(authControllerProvider);
    final isLoading = authStatus.isLoading;

    return Scaffold(
      body: Row(
        children: [
          // Left side - Login form
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimensions.spacing12),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 448),
                  child: SizedBox(
                    width: double.infinity,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppDimensions.spacing8),
                          Text(
                            'Welcome back',
                            style: AppTextStyles.headlineLarge(),
                          ),
                          const SizedBox(height: AppDimensions.spacing2),
                          Text(
                            'Sign in to your Brothers Fitness account',
                            style: AppTextStyles.bodyMedium(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: AppDimensions.spacing8),
                          CustomTextField(
                            label: 'Email',
                            hint: 'admin@brothersfitness.com',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: AppDimensions.spacing4),
                          CustomTextField(
                            label: 'Password',
                            hint: '••••••••',
                            controller: _passwordController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: AppDimensions.spacing6),
                          PrimaryButton(
                            label: 'Continue',
                            onPressed: isLoading ? null : _handleLogin,
                            isFullWidth: true,
                            isLoading: isLoading,
                          ),
                          const SizedBox(height: AppDimensions.spacing4),
                          Center(
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot password? Reset here',
                                style: AppTextStyles.bodySmall(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Right side - Image panel
          const LoginImagePanel(),
        ],
      ),
    );
  }
}

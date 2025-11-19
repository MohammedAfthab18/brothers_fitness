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

/// Notion-style login page with improved error handling
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController(text: 'admin@brothersfitness.com');
  final _passwordController = TextEditingController(text: 'password123');
  final _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Listen to auth state changes
    ref.listenManual(authStateProvider, (previous, next) {
      next.whenData((user) {
        if (user != null && mounted) {
          // Clear error message on successful login
          setState(() => _errorMessage = null);
          // Navigate to dashboard
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
    // Clear previous error
    setState(() => _errorMessage = null);

    // Validate form
    if (!_formKey.currentState!.validate()) return;
    
    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    try {
      // Attempt login
      await ref.read(authControllerProvider.notifier).login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      // Check for errors
      final state = ref.read(authControllerProvider);
      if (state.hasError) {
        final error = state.error.toString();
        setState(() {
          if (error.contains('wrong-password') || error.contains('user-not-found')) {
            _errorMessage = 'Invalid email or password. Please try again.';
          } else if (error.contains('too-many-requests')) {
            _errorMessage = 'Too many failed attempts. Please try again later.';
          } else if (error.contains('network')) {
            _errorMessage = 'Network error. Please check your internet connection.';
          } else if (error.contains('permission-denied')) {
            _errorMessage = 'Access denied. Please contact your administrator.';
          } else {
            _errorMessage = 'Login failed. Please try again.';
          }
        });
        
        // Show snackbar for additional context
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_errorMessage!),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred. Please try again.';
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage!),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
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
                          
                          // Error message display
                          if (_errorMessage != null) ...[
                            const SizedBox(height: AppDimensions.spacing6),
                            Container(
                              padding: const EdgeInsets.all(AppDimensions.spacing4),
                              decoration: BoxDecoration(
                                color: AppColors.errorLight,
                                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                                border: Border.all(color: AppColors.error),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: AppColors.error,
                                    size: AppDimensions.iconMedium,
                                  ),
                                  const SizedBox(width: AppDimensions.spacing3),
                                  Expanded(
                                    child: Text(
                                      _errorMessage!,
                                      style: AppTextStyles.bodySmall(
                                        color: AppColors.error,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          
                          const SizedBox(height: AppDimensions.spacing8),
                          
                          // Email field
                          CustomTextField(
                            label: 'Email',
                            hint: 'admin@brothersfitness.com',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            enabled: !isLoading,
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
                          
                          // Password field
                          CustomTextField(
                            label: 'Password',
                            hint: '••••••••',
                            controller: _passwordController,
                            obscureText: true,
                            enabled: !isLoading,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: AppDimensions.spacing6),
                          
                          // Login button
                          PrimaryButton(
                            label: 'Continue',
                            onPressed: isLoading ? null : _handleLogin,
                            isFullWidth: true,
                            isLoading: isLoading,
                          ),
                          
                          const SizedBox(height: AppDimensions.spacing4),
                          
                          // Help text
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'Default credentials for testing:',
                                  style: AppTextStyles.bodySmall(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: AppDimensions.spacing1),
                                Text(
                                  'admin@brothersfitness.com / password123',
                                  style: AppTextStyles.bodySmall(
                                    color: AppColors.textTertiary,
                                  ),
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
            ),
          ),
          // Right side - Image panel
          const LoginImagePanel(),
        ],
      ),
    );
  }
}
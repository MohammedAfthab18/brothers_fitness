import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Right side image panel for login page matching React design.
class LoginImagePanel extends StatelessWidget {
  const LoginImagePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.grey900, AppColors.grey700],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacing12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('💪', style: TextStyle(fontSize: 96)),
                const SizedBox(height: AppDimensions.spacing6),
                Text(
                  'Manage Your Gym',
                  style: AppTextStyles.headlineLarge(color: Colors.white),
                ),
                const SizedBox(height: AppDimensions.spacing4),
                Text(
                  'Effortlessly track members, renewals, and growth',
                  style: AppTextStyles.bodyLarge(color: AppColors.grey300),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

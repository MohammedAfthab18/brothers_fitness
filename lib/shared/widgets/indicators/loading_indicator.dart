import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Simple loading indicator.
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.size = 24, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.primary),
      ),
    );
  }
}

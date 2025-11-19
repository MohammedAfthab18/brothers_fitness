import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';

/// Notion-style base card widget.
class BaseCard extends StatelessWidget {
  const BaseCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.margin,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: padding ?? const EdgeInsets.all(AppDimensions.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        child: content,
      );
    }

    if (margin != null) {
      return Container(margin: margin, child: content);
    }

    return content;
  }
}

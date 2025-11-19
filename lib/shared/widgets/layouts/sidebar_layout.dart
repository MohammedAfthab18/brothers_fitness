import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';

/// Notion-style sidebar layout matching React design.
class SidebarLayout extends StatelessWidget {
  const SidebarLayout({
    super.key,
    required this.child,
    this.currentRoute,
    this.onRouteChanged,
    this.onLogout,
  });

  final Widget child;
  final String? currentRoute;
  final ValueChanged<String>? onRouteChanged;
  final VoidCallback? onLogout;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Sidebar
        Container(
          width: 256, // w-64 in Tailwind = 256px
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border(right: BorderSide(color: AppColors.border)),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(AppDimensions.spacing6),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.border)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Brothers Fitness', style: AppTextStyles.titleLarge()),
                    const SizedBox(height: AppDimensions.spacing1),
                    Text(
                      'Management System',
                      style: AppTextStyles.bodySmall(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              // Navigation
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.spacing4),
                  child: Column(
                    children: [
                      _NavItem(
                        icon: LucideIcons.home,
                        label: 'Dashboard',
                        isActive: currentRoute == '/dashboard',
                        onTap: () => onRouteChanged?.call('/dashboard'),
                      ),
                      _NavItem(
                        icon: LucideIcons.users,
                        label: 'Members',
                        isActive: currentRoute == '/members',
                        onTap: () => onRouteChanged?.call('/members'),
                      ),
                      _NavItem(
                        icon: LucideIcons.bell,
                        label: 'Expiry Reminders',
                        isActive: currentRoute == '/reminders',
                        onTap: () => onRouteChanged?.call('/reminders'),
                      ),
                      _NavItem(
                        icon: LucideIcons.creditCard,
                        label: 'Plans & Pricing',
                        isActive: currentRoute == '/plans',
                        onTap: () => onRouteChanged?.call('/plans'),
                      ),
                      _NavItem(
                        icon: LucideIcons.barChart3,
                        label: 'Analytics',
                        isActive: currentRoute == '/analytics',
                        onTap: () => onRouteChanged?.call('/analytics'),
                      ),
                      _NavItem(
                        icon: LucideIcons.settings,
                        label: 'Settings',
                        isActive: currentRoute == '/settings',
                        onTap: () => onRouteChanged?.call('/settings'),
                      ),
                    ],
                  ),
                ),
              ),
              // Logout
              Container(
                padding: const EdgeInsets.all(AppDimensions.spacing4),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: AppColors.border)),
                ),
                child: _NavItem(
                  icon: LucideIcons.logOut,
                  label: 'Logout',
                  onTap: onLogout,
                ),
              ),
            ],
          ),
        ),
        // Main content
        Expanded(child: child),
      ],
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing3,
          vertical: AppDimensions.spacing2,
        ),
        margin: const EdgeInsets.only(bottom: AppDimensions.spacing1),
        decoration: BoxDecoration(
          color: isActive ? AppColors.grey100 : Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: AppDimensions.iconMedium,
              color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
            ),
            const SizedBox(width: AppDimensions.spacing3),
             Text(
               label,
               style: AppTextStyles.withWeight(
                 AppTextStyles.bodySmall(
                   color: isActive
                       ? AppColors.textPrimary
                       : AppColors.textSecondary,
                 ),
                 FontWeight.w500,
               ),
             ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/route_constants.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../shared/widgets/layouts/page_header.dart';
import '../../../../shared/widgets/layouts/sidebar_layout.dart';
import '../widgets/admin_profile_section.dart';
import '../widgets/cache_info_section.dart';
import '../widgets/theme_section.dart';
import '../widgets/whatsapp_config_section.dart';

/// Settings page matching React design.
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SidebarLayout(
        currentRoute: RouteConstants.settings,
        onRouteChanged: (route) {
          context.go(route);
        },
        onLogout: () {
          context.go(RouteConstants.login);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacing8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PageHeader(
                  title: 'Settings',
                  subtitle: 'Manage your app preferences',
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    children: [
                      const AdminProfileSection(),
                      const SizedBox(height: AppDimensions.spacing6),
                      const ThemeSection(),
                      const SizedBox(height: AppDimensions.spacing6),
                      const WhatsAppConfigSection(),
                      const SizedBox(height: AppDimensions.spacing6),
                      const CacheInfoSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

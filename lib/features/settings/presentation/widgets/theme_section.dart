import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/providers/theme_provider.dart';
import '../../../../shared/widgets/cards/base_card.dart';

/// Theme section.
class ThemeSection extends ConsumerWidget {
  const ThemeSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final themeNotifier = ref.read(themeModeProvider.notifier);

    String labelForMode(ThemeMode mode) {
      return switch (mode) {
        ThemeMode.system => 'System default',
        ThemeMode.light => 'Light',
        ThemeMode.dark => 'Dark',
      };
    }

    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Appearance', style: AppTextStyles.titleMedium()),
          const SizedBox(height: AppDimensions.spacing2),
          Text(
            'Choose how Brothers Fitness adapts to your display.',
            style: AppTextStyles.bodySmall(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppDimensions.spacing6),
          SwitchListTile.adaptive(
            value: themeMode == ThemeMode.dark,
            onChanged: (value) => themeNotifier.toggleDarkMode(value),
            title: Text(
              'Dark mode toggle',
              style: AppTextStyles.bodyMedium(),
            ),
            subtitle: Text(
              valueDescription(themeMode),
              style: AppTextStyles.bodySmall(color: AppColors.textSecondary),
            ),
            contentPadding: EdgeInsets.zero,
          ),
          const Divider(),
          const SizedBox(height: AppDimensions.spacing4),
          Text('Quick select', style: AppTextStyles.labelLarge()),
          const SizedBox(height: AppDimensions.spacing2),
          Wrap(
            spacing: AppDimensions.spacing4,
            runSpacing: AppDimensions.spacing2,
            children: ThemeMode.values.map((mode) {
              return ChoiceChip(
                label: Text(labelForMode(mode)),
                selected: themeMode == mode,
                onSelected: (_) => themeNotifier.setThemeMode(mode),
              );
            }).toList(),
          ),
          const SizedBox(height: AppDimensions.spacing6),
          Text('Radio options', style: AppTextStyles.labelLarge()),
          ...ThemeMode.values.map(
            (mode) => RadioListTile<ThemeMode>(
              value: mode,
              // ignore: deprecated_member_use
              groupValue: themeMode,
              contentPadding: EdgeInsets.zero,
              title: Text(labelForMode(mode)),
              subtitle: Text(
                mode == ThemeMode.system
                    ? 'Match macOS / Windows setting automatically'
                    : 'Force ${labelForMode(mode).toLowerCase()} across the app',
                style:
                    AppTextStyles.bodySmall(color: AppColors.textSecondary),
              ),
              // ignore: deprecated_member_use
              onChanged: (value) {
                if (value != null) themeNotifier.setThemeMode(value);
              },
            ),
          ),
          const SizedBox(height: AppDimensions.spacing4),
          DropdownMenu<ThemeMode>(
            initialSelection: themeMode,
            label: const Text('Dropdown selection'),
            onSelected: (mode) {
              if (mode != null) {
                themeNotifier.setThemeMode(mode);
              }
            },
            dropdownMenuEntries: ThemeMode.values
                .map(
                  (mode) => DropdownMenuEntry(
                    value: mode,
                    label: labelForMode(mode),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  String valueDescription(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'Following system setting';
      case ThemeMode.light:
        return 'Forces light palettes';
      case ThemeMode.dark:
        return 'Forces dark palettes';
    }
  }
}

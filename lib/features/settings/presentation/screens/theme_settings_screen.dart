import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/features/settings/providers/settings_providers.dart';

class ThemeSettingsScreen extends ConsumerWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeModeProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const AppBarComponent(title: '主题设置'),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _buildThemeOption(
            context,
            ref,
            title: '跟随系统',
            subtitle: '自动适配系统深色/浅色模式',
            icon: Icons.settings_brightness_outlined,
            mode: AppThemeMode.system,
            currentMode: currentThemeMode,
            colorScheme: colorScheme,
          ),
          _buildThemeOption(
            context,
            ref,
            title: '浅色模式',
            subtitle: '始终使用浅色主题',
            icon: Icons.light_mode_outlined,
            mode: AppThemeMode.light,
            currentMode: currentThemeMode,
            colorScheme: colorScheme,
          ),
          _buildThemeOption(
            context,
            ref,
            title: '深色模式',
            subtitle: '始终使用深色主题',
            icon: Icons.dark_mode_outlined,
            mode: AppThemeMode.dark,
            currentMode: currentThemeMode,
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String subtitle,
    required IconData icon,
    required AppThemeMode mode,
    required AppThemeMode currentMode,
    required ColorScheme colorScheme,
  }) {
    final isSelected = currentMode == mode;
    final primaryColor = colorScheme.primary;
    final surfaceColor = colorScheme.surface;
    final onSurfaceColor = colorScheme.onSurface;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(color: primaryColor, width: 1.5)
            : Border.all(color: Colors.transparent, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isSelected
                ? primaryColor.withOpacity(0.12)
                : onSurfaceColor.withOpacity(0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: isSelected ? primaryColor : onSurfaceColor.withOpacity(0.6),
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? primaryColor : onSurfaceColor,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: onSurfaceColor.withOpacity(0.5),
            fontSize: 12,
          ),
        ),
        trailing: isSelected
            ? Icon(Icons.check_circle, color: primaryColor, size: 22)
            : Icon(Icons.circle_outlined,
                color: onSurfaceColor.withOpacity(0.3), size: 22),
        onTap: () => ref.read(themeModeProvider.notifier).setThemeMode(mode),
      ),
    );
  }
}

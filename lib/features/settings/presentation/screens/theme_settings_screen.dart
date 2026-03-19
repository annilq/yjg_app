import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/features/settings/providers/settings_providers.dart';

class ThemeSettingsScreen extends ConsumerWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: const AppBarComponent(
        title: '主题设置',
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _buildThemeOption(
            context,
            ref,
            title: '跟随系统',
            icon: Icons.settings_brightness,
            mode: AppThemeMode.system,
            currentMode: currentThemeMode,
          ),
          _buildThemeOption(
            context,
            ref,
            title: '浅色模式',
            icon: Icons.light_mode,
            mode: AppThemeMode.light,
            currentMode: currentThemeMode,
          ),
          _buildThemeOption(
            context,
            ref,
            title: '深色模式',
            icon: Icons.dark_mode,
            mode: AppThemeMode.dark,
            currentMode: currentThemeMode,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required IconData icon,
    required AppThemeMode mode,
    required AppThemeMode currentMode,
  }) {
    final isSelected = currentMode == mode;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: isSelected
            ? Border.all(color: Theme.of(context).primaryColor, width: 1.5)
            : null,
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? Theme.of(context).primaryColor : Colors.grey),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Theme.of(context).primaryColor : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: isSelected
            ? Icon(Icons.check, color: Theme.of(context).primaryColor)
            : null,
        onTap: () {
          ref.read(themeModeProvider.notifier).setThemeMode(mode);
        },
      ),
    );
  }
}
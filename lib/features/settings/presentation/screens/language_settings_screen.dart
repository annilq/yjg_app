import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/features/settings/providers/settings_providers.dart';

class LanguageSettingsScreen extends ConsumerWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(languageProvider);

    return Scaffold(
      appBar: const AppBarComponent(
        title: '语言切换',
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _buildLanguageOption(
            context,
            ref,
            title: '中文',
            subtitle: '简体中文',
            icon: Icons.language,
            language: AppLanguage.chinese,
            currentLanguage: currentLanguage,
          ),
          _buildLanguageOption(
            context,
            ref,
            title: 'English',
            subtitle: 'English',
            icon: Icons.language,
            language: AppLanguage.english,
            currentLanguage: currentLanguage,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String subtitle,
    required IconData icon,
    required AppLanguage language,
    required AppLanguage currentLanguage,
  }) {
    final isSelected = currentLanguage == language;

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
        subtitle: Text(subtitle),
        trailing: isSelected
            ? Icon(Icons.check, color: Theme.of(context).primaryColor)
            : null,
        onTap: () {
          ref.read(languageProvider.notifier).setLanguage(language);
        },
      ),
    );
  }
}
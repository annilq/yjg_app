import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(title: '设置'),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _buildSettingsItem(
            context,
            title: '语言切换',
            icon: Icons.language_outlined,
            onTap: () => context.push('/settings/language'),
          ),
          _buildSettingsItem(
            context,
            title: '通知设置',
            icon: Icons.notifications_outlined,
            onTap: () => context.push('/settings/notification'),
          ),
          _buildSettingsItem(
            context,
            title: '关于页面',
            icon: Icons.info_outline,
            onTap: () => context.push('/settings/about'),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: colorScheme.primary),
        title: Text(
          title,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.normal,
          ),
        ),
        trailing: Icon(
          CupertinoIcons.chevron_right,
          color: colorScheme.onSurfaceVariant,
          size: 20,
        ),
        onTap: onTap,
      ),
    );
  }
}

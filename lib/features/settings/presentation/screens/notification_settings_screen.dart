import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/features/settings/providers/settings_providers.dart';

class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(notificationSettingsProvider);

    return Scaffold(
      appBar: const AppBarComponent(title: '通知设置'),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _buildSectionHeader(context, '推送设置'),
          _buildSwitchTile(
            context: context,
            title: '接收推送',
            subtitle: '开启后您将收到消息推送',
            value: settings.pushEnabled,
            onChanged: (value) {
              ref.read(notificationSettingsProvider.notifier).togglePushEnabled(value);
            },
          ),
          _buildSwitchTile(
            context: context,
            title: '声音',
            subtitle: '收到通知时播放声音',
            value: settings.soundEnabled,
            onChanged: settings.pushEnabled
                ? (value) {
                    ref.read(notificationSettingsProvider.notifier).toggleSoundEnabled(value);
                  }
                : null,
            enabled: settings.pushEnabled,
          ),
          _buildSwitchTile(
            context: context,
            title: '震动',
            subtitle: '收到通知时震动',
            value: settings.vibrationEnabled,
            onChanged: settings.pushEnabled
                ? (value) {
                    ref.read(notificationSettingsProvider.notifier).toggleVibrationEnabled(value);
                  }
                : null,
            enabled: settings.pushEnabled,
          ),
          const SizedBox(height: 16),
          _buildSectionHeader(context, '通知类型'),
          _buildSwitchTile(
            context: context,
            title: '流程通知',
            subtitle: '审批通知、待办提醒等',
            value: settings.workFlowNotification,
            onChanged: settings.pushEnabled
                ? (value) {
                    ref.read(notificationSettingsProvider.notifier).toggleWorkFlowNotification(value);
                  }
                : null,
            enabled: settings.pushEnabled,
          ),
          _buildSwitchTile(
            context: context,
            title: '公告通知',
            subtitle: '系统公告、企业通知等',
            value: settings.noticeNotification,
            onChanged: settings.pushEnabled
                ? (value) {
                    ref.read(notificationSettingsProvider.notifier).toggleNoticeNotification(value);
                  }
                : null,
            enabled: settings.pushEnabled,
          ),
          _buildSwitchTile(
            context: context,
            title: '消息通知',
            subtitle: '私信、群聊消息等',
            value: settings.messageNotification,
            onChanged: settings.pushEnabled
                ? (value) {
                    ref.read(notificationSettingsProvider.notifier).toggleMessageNotification(value);
                  }
                : null,
            enabled: settings.pushEnabled,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool>? onChanged,
    bool enabled = true,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            color: enabled ? colorScheme.onSurface : colorScheme.onSurfaceVariant,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: textTheme.bodySmall?.copyWith(
            color: enabled ? colorScheme.onSurfaceVariant : colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: colorScheme.primary,
          activeTrackColor: colorScheme.primary.withValues(alpha: 0.4),
        ),
      ),
    );
  }
}

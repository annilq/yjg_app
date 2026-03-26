import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';
import 'package:flutter_app/shared/widgets/index.dart';
import 'package:flutter_app/features/settings/providers/settings_providers.dart';

class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(notificationSettingsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? DarkColors.surface : LightColors.surface;

    return Scaffold(
      backgroundColor: isDark ? DarkColors.background : LightColors.background,
      appBar: AppBarComponent(title: '通知设置'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.lg),
            // 推送设置分组
            Text('推送设置',
                style: AppTypography.labelMedium.copyWith(
                    color: isDark
                        ? DarkColors.textSecondary
                        : LightColors.textSecondary)),
            const SizedBox(height: AppSpacing.sm),
            Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: AppRadius.allSm,
              ),
              child: Column(children: [
                _switchRow(context, '接收推送', '开启后将收到消息推送',
                    s.pushEnabled, (v) {
                  ref
                      .read(notificationSettingsProvider.notifier)
                      .togglePushEnabled(v);
                }),
                _switchRow(context, '声音', '收到通知时播放声音',
                    s.soundEnabled, s.pushEnabled ? (v) {
                  ref
                      .read(notificationSettingsProvider.notifier)
                      .toggleSoundEnabled(v);
                } : null,
                    disabled: !s.pushEnabled),
                _switchRow(context, '震动', '收到通知时震动',
                    s.vibrationEnabled, s.pushEnabled ? (v) {
                  ref
                      .read(notificationSettingsProvider.notifier)
                      .toggleVibrationEnabled(v);
                } : null,
                    disabled: !s.pushEnabled, isLast: true),
              ]),
            ),
            const SizedBox(height: AppSpacing.xl),
            // 通知类型分组
            Text('通知类型',
                style: AppTypography.labelMedium.copyWith(
                    color: isDark
                        ? DarkColors.textSecondary
                        : LightColors.textSecondary)),
            const SizedBox(height: AppSpacing.sm),
            Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: AppRadius.allSm,
              ),
              child: Column(children: [
                _switchRow(context, '流程通知', '审批通知、待办提醒等',
                    s.workFlowNotification, s.pushEnabled ? (v) {
                  ref
                      .read(notificationSettingsProvider.notifier)
                      .toggleWorkFlowNotification(v);
                } : null,
                    disabled: !s.pushEnabled),
                _switchRow(context, '公告通知', '系统公告、企业通知等',
                    s.noticeNotification, s.pushEnabled ? (v) {
                  ref
                      .read(notificationSettingsProvider.notifier)
                      .toggleNoticeNotification(v);
                } : null,
                    disabled: !s.pushEnabled),
                _switchRow(context, '消息通知', '私信、群聊消息等',
                    s.messageNotification, s.pushEnabled ? (v) {
                  ref
                      .read(notificationSettingsProvider.notifier)
                      .toggleMessageNotification(v);
                } : null,
                    disabled: !s.pushEnabled, isLast: true),
              ]),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _switchRow(
    BuildContext context,
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool>? onChanged, {
    bool disabled = false,
    bool isLast = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).colorScheme.primary;
    final textColor = disabled
        ? (isDark ? DarkColors.textTertiary : LightColors.textTertiary)
        : null;

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.md),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                    color: isDark ? DarkColors.border : LightColors.border,
                    width: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: AppTypography.bodyMedium.copyWith(color: textColor)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: AppTypography.caption.copyWith(
                        color: isDark
                            ? DarkColors.textTertiary
                            : LightColors.textTertiary)),
              ],
            ),
          ),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeColor: primary,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';
import 'package:flutter_app/shared/widgets/index.dart';
import 'package:flutter_app/features/profile/providers/profile_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? DarkColors.surface : LightColors.surface;

    final items = [
      (CupertinoIcons.globe, '语言切换', '/settings/language'),
      (CupertinoIcons.bell, '通知设置', '/settings/notification'),
      (CupertinoIcons.info_circle, '关于', '/settings/about'),
    ];

    return Scaffold(
      backgroundColor: isDark ? DarkColors.background : LightColors.background,
      appBar: AppBarComponent(title: '设置'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.lg),
            Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: AppRadius.allSm,
              ),
              child: Column(
                children: items.asMap().entries.map((e) {
                  final i = e.key;
                  final (icon, label, route) = e.value;
                  return _menuItem(
                    context,
                    ref,
                    icon,
                    label,
                    route,
                    bgColor,
                    isLast: i == items.length - 1,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(
    BuildContext ctx,
    WidgetRef ref,
    IconData icon,
    String label,
    String route,
    Color bgColor, {
    bool isLast = false,
  }) {
    final primary = Theme.of(ctx).colorScheme.primary;
    final isDark = Theme.of(ctx).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        ctx.push(route);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: isDark ? DarkColors.border : LightColors.border,
                    width: 0.5,
                  ),
                ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: primary),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: Text(label, style: AppTypography.bodyMedium)),
            Icon(
              CupertinoIcons.chevron_right,
              size: 14,
              color: isDark
                  ? DarkColors.textTertiary
                  : LightColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}

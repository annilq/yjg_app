import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';

/// 待办菜单组件 - 一行三个卡片
class BacklogMenuComponent extends StatelessWidget {
  final int backlogCount;
  final int remindCount;

  const BacklogMenuComponent({
    super.key,
    required this.backlogCount,
    required this.remindCount,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: (isDark ? DarkColors.surface : LightColors.surface),
        borderRadius: AppRadius.cardRadius,
      ),
      child: Padding(
        padding: AppSpacing.allSm,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Expanded(
              child: _MenuItemCard(
                icon: CupertinoIcons.mail,
                iconColor: AppColors.error,
                title: '待处理',
                count: backlogCount,
                onTap: () => context.push('/office/backlog'),
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: _MenuItemCard(
                icon: CupertinoIcons.paperplane,
                iconColor: AppColors.primary,
                title: '已发起',
                count: 0,
                onTap: () => context.push('/office/relatedtome'),
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: _MenuItemCard(
                icon: CupertinoIcons.bell,
                iconColor: AppColors.warning,
                title: '提醒',
                count: remindCount,
                onTap: () => context.push('/notices'),
              ),
            ),
          ],
          ),
        ),
      ),
    );
  }
}

/// 单个菜单卡片
class _MenuItemCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final int count;
  final VoidCallback onTap;

  const _MenuItemCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    final bgColor = isDark
        ? DarkColors.surfaceVariant
        : LightColors.surfaceVariant;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: AppRadius.allSm,
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: AppTypography.bodyMedium.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: AppTypography.weightMedium,
                    ),
                  ),
                  if (count > 0)
                    Text(
                      '$count',
                      style: AppTypography.titleLarge.copyWith(
                        color: iconColor,
                        fontWeight: AppTypography.weightBold,
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

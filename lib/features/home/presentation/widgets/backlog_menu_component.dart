import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';

/// 待办菜单组件 - Flat Design 风格
///
/// 特点：
/// - 无阴影，使用边框分隔
/// - 统一圆角和间距
/// - 清晰的颜色语义
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
      ),
      child: Column(
        children: [
          // 第一行：待处理 + 已发起
          IntrinsicHeight(
            child: Row(
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
                SizedBox(width: AppSpacing.elementGap),
                Expanded(
                  child: _MenuItemCard(
                    icon: CupertinoIcons.paperplane,
                    iconColor: AppColors.primary,
                    title: '已发起',
                    count: 0,
                    onTap: () => context.push('/office/relatedtome'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.elementGap),
          // 第二行：提醒 + 发起
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _MenuItemCard(
                    icon: CupertinoIcons.bell,
                    iconColor: AppColors.warning,
                    title: '提醒',
                    count: remindCount,
                    onTap: () => context.push('/notices'),
                  ),
                ),
                SizedBox(width: AppSpacing.elementGap),
                Expanded(
                  child: _MenuItemCard(
                    icon: CupertinoIcons.add_circled,
                    iconColor: AppColors.success,
                    title: '发起',
                    count: 0,
                    onTap: () => context.push('/start'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 单个菜单卡片 - Flat Design 风格
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

    // 背景色
    final bgColor = isDark ? DarkColors.surfaceVariant : LightColors.surfaceVariant;
    final textColor = colorScheme.onSurface;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: AppRadius.allSm,
          border: Border.all(
            color: isDark ? DarkColors.border : LightColors.borderLight,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // 左侧图标
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconColor.withAlpha(38), // 15% opacity
                borderRadius: AppRadius.allSm,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 18,
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            // 中间文字
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: AppTypography.weightSemibold,
                      color: textColor,
                    ),
                  ),
                  if (count > 0) ...[
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      '$count 条待办',
                      style: AppTypography.caption.copyWith(
                        color: iconColor,
                        fontWeight: AppTypography.weightMedium,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // 右侧箭头
            Icon(
              CupertinoIcons.chevron_right,
              size: 14,
              color: isDark ? DarkColors.textTertiary : LightColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
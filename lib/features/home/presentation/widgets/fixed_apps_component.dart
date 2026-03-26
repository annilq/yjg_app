import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';

/// 固定应用组件 - Flat Design 风格
///
/// 特点：
/// - 无阴影，使用边框分隔
/// - 2x2 网格布局
/// - 语义化图标颜色
class FixedAppsComponent extends StatelessWidget {
  const FixedAppsComponent({super.key});

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
        child: Column(
          children: [
            // 第一行：考勤打卡 + 签到
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: _AppItemCard(
                      icon: CupertinoIcons.time,
                      iconColor: AppColors.error,
                      title: '考勤打卡',
                      onTap: () {
                        // TODO: 跳转到考勤打卡
                      },
                    ),
                  ),
                  SizedBox(width: AppSpacing.elementGap),
                  Expanded(
                    child: _AppItemCard(
                      icon: CupertinoIcons.checkmark_circle,
                      iconColor: AppColors.success,
                      title: '签到',
                      onTap: () {
                        // TODO: 跳转到签到
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.elementGap),
            // 第二行：工作报告 + 工作任务
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: _AppItemCard(
                      icon: CupertinoIcons.pencil,
                      iconColor: AppColors.warning,
                      title: '工作报告',
                      onTap: () {
                        // TODO: 跳转到工作报告
                      },
                    ),
                  ),
                  SizedBox(width: AppSpacing.elementGap),
                  Expanded(
                    child: _AppItemCard(
                      icon: CupertinoIcons.checkmark_seal,
                      iconColor: AppColors.primary,
                      title: '工作任务',
                      onTap: () {
                        // TODO: 跳转到工作任务
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 单个应用卡片 - Flat Design 风格
class _AppItemCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback onTap;

  const _AppItemCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: isDark
              ? DarkColors.surfaceVariant
              : LightColors.surfaceVariant,
          borderRadius: AppRadius.allSm,
        ),
        child: Row(
          children: [
            // 左侧图标
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconColor.withAlpha(38),
                borderRadius: AppRadius.allSm,
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            SizedBox(width: AppSpacing.sm),
            // 中间文字
            Expanded(
              child: Text(
                title,
                style: AppTypography.bodySmall.copyWith(
                  fontWeight: AppTypography.weightSemibold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            // 右侧箭头
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

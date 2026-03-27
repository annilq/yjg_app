import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';

/// 空状态卡片组件 - Flat Design 风格
///
/// 特点：
/// - 白色色块背景，与页面背景区分
/// - 极简设计，通用 empty 图标 + 文字说明
/// - 无边框，纯色块
/// - 可选操作按钮
class EmptyCard extends StatelessWidget {
  final String? message;
  final String? actionText;
  final VoidCallback? onAction;

  const EmptyCard({super.key, this.message, this.actionText, this.onAction});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).colorScheme.primary;
    final textSecondary = isDark
        ? DarkColors.textSecondary
        : LightColors.textSecondary;
    final cardBg = isDark ? DarkColors.surface : LightColors.surface;

    return Container(
      decoration: BoxDecoration(color: cardBg, borderRadius: AppRadius.allSm),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 图标区域 - 主色浅底圆形
          Icon(CupertinoIcons.tray, size: 32, color: primary.withAlpha(180)),
          const SizedBox(height: AppSpacing.sm),
          // 文字说明
          Text(
            message ?? '暂无数据',
            style: AppTypography.bodyMedium.copyWith(
              color: textSecondary,
              fontWeight: AppTypography.weightMedium,
            ),
            textAlign: TextAlign.center,
          ),
          // 可选操作按钮
          if (actionText != null && onAction != null) ...[
            const SizedBox(height: AppSpacing.lg),
            GestureDetector(
              onTap: onAction,
              child: Text(
                actionText!,
                style: AppTypography.bodyMedium.copyWith(
                  color: primary,
                  fontWeight: AppTypography.weightSemibold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

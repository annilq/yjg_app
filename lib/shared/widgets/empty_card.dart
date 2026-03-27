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
/// - 可选图标颜色（用于不同场景）
class EmptyCard extends StatelessWidget {
  final String? message;
  final String? actionText;
  final VoidCallback? onAction;
  final Color? iconColor;

  const EmptyCard({
    super.key,
    this.message,
    this.actionText,
    this.onAction,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).colorScheme.primary;
    final textSecondary = isDark
        ? DarkColors.textSecondary
        : LightColors.textSecondary;
    final cardBg = isDark ? DarkColors.surface : LightColors.surface;

    // 使用传入的颜色，或默认使用主色
    final displayIconColor = iconColor ?? primary;

    return Container(
      decoration: BoxDecoration(color: cardBg, borderRadius: AppRadius.allSm),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 图标区域 - 浅底圆形
          Container(
            width: 64,
            height: 64,
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl),
            decoration: BoxDecoration(
              color: displayIconColor.withAlpha(isDark ? 30 : 15),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Icon(
              CupertinoIcons.tray,
              size: 32,
              color: displayIconColor.withAlpha(200),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
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
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';
import 'package:flutter_app/shared/widgets/business_icon_component.dart';

/// 卡片项组件 - Flat Design 风格
///
/// 特点：
/// - 纯色块背景，无 border
/// - 统一 Token
/// - 点击缩放动画
class CardItemComponent extends StatefulWidget {
  final String formKey;
  final String? status;
  final String title;
  final String? extra;
  final String? content;
  final VoidCallback onTap;
  final EdgeInsets margin;

  const CardItemComponent({
    super.key,
    required this.formKey,
    this.status,
    required this.title,
    this.extra,
    this.content,
    required this.onTap,
    this.margin = AppSpacing.horizontalLg,
  });

  @override
  State<CardItemComponent> createState() => _CardItemComponentState();

  static Widget iconContainer({required String formKey, double size = 40}) {
    return BusinessIcon(formKey: formKey, size: size);
  }

  /// 数量徽章
  static Widget countBadge(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: AppRadius.allSm,
      ),
      child: Text(
        '$count',
        style: AppTypography.caption.copyWith(
          color: AppColors.white,
          fontWeight: AppTypography.weightSemibold,
        ),
      ),
    );
  }

  /// 状态徽章
  static Widget statusBadge(String status) {
    Color color;
    String text;

    switch (status) {
      case 'pending':
        color = AppColors.warning;
        text = '待处理';
        break;
      case 'completed':
        color = AppColors.success;
        text = '已完成';
        break;
      default:
        color = AppColors.primary;
        text = '进行中';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: AppRadius.allSm,
      ),
      child: Text(
        text,
        style: AppTypography.caption.copyWith(
          color: color,
          fontWeight: AppTypography.weightMedium,
        ),
      ),
    );
  }
}

class _CardItemComponentState extends State<CardItemComponent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final status = widget.status != null
        ? CardItemComponent.statusBadge(widget.status!)
        : null;

    return AnimatedBuilder(
      animation: _scale,
      builder: (context, child) => Transform.scale(scale: _scale.value, child: child),
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) => _controller.reverse(),
        onTapCancel: () => _controller.reverse(),
        onTap: widget.onTap,
        child: Container(
          margin: widget.margin,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: isDark ? DarkColors.surface : LightColors.surface,
            borderRadius: AppRadius.allSm,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BusinessIcon(formKey: widget.formKey, size: 36),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: AppTypography.bodyMedium.copyWith(
                        fontWeight: AppTypography.weightMedium,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (widget.extra != null) ...[
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      widget.extra!,
                      style: AppTypography.caption.copyWith(
                        color: isDark
                            ? DarkColors.textSecondary
                            : LightColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(width: AppSpacing.xs),
                  Icon(
                    CupertinoIcons.chevron_right,
                    size: 14,
                    color: isDark
                        ? DarkColors.textTertiary
                        : LightColors.textTertiary,
                  ),
                ],
              ),
              if ((widget.content != null && widget.content != "") || status != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    if (widget.content != null && widget.content != "")
                      Expanded(
                        child: Text(
                          widget.content!,
                          style: AppTypography.caption.copyWith(
                            color: isDark
                                ? DarkColors.textSecondary
                                : LightColors.textSecondary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    if (status != null) ...[
                      const SizedBox(width: AppSpacing.sm),
                      status,
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

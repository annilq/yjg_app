import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';
import 'package:flutter_app/shared/widgets/business_icon_component.dart';

/// 卡片项组件 - Flat Design 风格
///
/// 特点：
/// - 无阴影，使用边框分隔
/// - 统一圆角和间距
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

  /// 数量徽章 - Flat Design 风格
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

  /// 状态徽章 - Flat Design 风格
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
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.985).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _handleTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final icon = BusinessIcon(formKey: widget.formKey, size: 40);
    final status = (widget.status != null
        ? CardItemComponent.statusBadge(widget.status!)
        : null);

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(scale: _scaleAnimation.value, child: child);
      },
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.onTap,
        child: Container(
          margin: widget.margin,
          padding: AppSpacing.cardPaddingAll,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border.all(
              color: isDark ? DarkColors.border : LightColors.border,
              width: 1,
            ),
            borderRadius: AppRadius.cardRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  icon,
                  SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.title,
                            style: AppTypography.titleMedium.copyWith(
                              color: colorScheme.onSurface,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (widget.extra != null) ...[
                          SizedBox(width: AppSpacing.sm),
                          Text(
                            widget.extra!,
                            style: AppTypography.bodySmall.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_right,
                    size: 16,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              if (widget.content != null || status != null) ...[
                SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    if (widget.content != null) ...[
                      Expanded(
                        child: Text(
                          widget.content!,
                          style: AppTypography.bodyMedium.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                    if (status != null) ...[
                      SizedBox(width: AppSpacing.sm),
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

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class CardItemComponent extends StatefulWidget {
  final Widget icon;
  final String title;
  final String? extra;
  final String? content;
  final Widget? footer;
  final VoidCallback onTap;
  final EdgeInsets margin;

  const CardItemComponent({
    super.key,
    required this.icon,
    required this.title,
    this.extra,
    this.content,
    this.footer,
    required this.onTap,
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  @override
  State<CardItemComponent> createState() => _CardItemComponentState();

  static Widget iconContainer({
    required IconData icon,
    required Color color,
    double size = 20,
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }

  static Widget countBadge(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppTheme.errorColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '$count',
        style: const TextStyle(
          color: AppTheme.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static Widget statusBadge(String status) {
    Color color;
    String text;

    switch (status) {
      case 'pending':
        color = AppTheme.warningColor;
        text = '待处理';
        break;
      case 'completed':
        color = AppTheme.secondaryColor;
        text = '已完成';
        break;
      default:
        color = AppTheme.primaryColor;
        text = '进行中';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w500,
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
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: Container(
        margin: widget.margin,
        child: Material(
          color: isDark ? AppTheme.darkGray : AppTheme.white,
          borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
          elevation: 0,
          child: InkWell(
            onTap: widget.onTap,
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
            splashColor: AppTheme.primaryColor.withValues(alpha: 0.1),
            highlightColor: AppTheme.primaryColor.withValues(alpha: 0.05),
            child: Container(
              padding: const EdgeInsets.all(AppTheme.cardPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                border: Border.all(
                  color: isDark 
                      ? Colors.white.withValues(alpha: 0.1)
                      : AppTheme.lightGray,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      widget.icon,
                      const SizedBox(width: 12),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.title,
                                style: AppTheme.titleStyle.copyWith(
                                  color: isDark ? AppTheme.white : AppTheme.darkGray,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (widget.extra != null) ...[
                              const SizedBox(width: 8),
                              Text(
                                widget.extra!,
                                style: AppTheme.smallStyle.copyWith(
                                  color: isDark 
                                      ? AppTheme.mediumGray.withValues(alpha: 0.8)
                                      : AppTheme.mediumGray,
                                  fontSize: 12,
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
                        color: isDark ? AppTheme.mediumGray : AppTheme.mediumGray,
                      ),
                    ],
                  ),
                  if (widget.content != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      widget.content!,
                      style: AppTheme.bodyStyle.copyWith(
                        color: isDark 
                            ? AppTheme.white.withValues(alpha: 0.9)
                            : AppTheme.darkGray,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (widget.footer != null) ...[
                    const SizedBox(height: 8),
                    widget.footer!,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

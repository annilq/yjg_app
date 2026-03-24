import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/theme/app_theme.dart';
import 'package:flutter_app/shared/widgets/business_icon_component.dart';

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
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  @override
  State<CardItemComponent> createState() => _CardItemComponentState();

  static Widget iconContainer({required String formKey, double size = 40}) {
    return BusinessIcon(formKey: formKey, size: size);
  }

  // Flat Design: countBadge padding 缩小, borderRadius: 8
  static Widget countBadge(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppTheme.errorColor,
        borderRadius: BorderRadius.circular(8),
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

  // Flat Design: statusBadge padding 缩小, borderRadius: 6, fontSize 11
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
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
    final textTheme = Theme.of(context).textTheme;

    final icon = BusinessIcon(formKey: widget.formKey, size: 40);
    final status = (widget.status != null
        ? CardItemComponent.statusBadge(widget.status!)
        : null);

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(scale: _scaleAnimation.value, child: child);
      },
      child: Container(
        margin: widget.margin,
        child: Material(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.flatRadius),
          elevation: 0,
          child: InkWell(
            onTap: widget.onTap,
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            borderRadius: BorderRadius.circular(AppTheme.flatRadius),
            child: Container(
              padding: const EdgeInsets.all(AppTheme.flatPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      icon,
                      const SizedBox(width: 12),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.onSurface,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (widget.extra != null) ...[
                              const SizedBox(width: 8),
                              Text(
                                widget.extra!,
                                style: TextStyle(
                                  color: colorScheme.onSurfaceVariant,
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
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                  if (widget.content != null || status != null) ...[
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        if (widget.content != null) ...[
                          Expanded(
                            child: Text(
                              widget.content!,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                        if (status != null) ...[
                          const SizedBox(width: 8),
                          status,
                        ],
                      ],
                    ),
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

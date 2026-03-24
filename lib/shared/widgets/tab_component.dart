import 'package:flutter/material.dart';

class TabComponent extends StatelessWidget {
  final List<TabItem> items;
  final int activeIndex;
  final double? height;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? borderRadius;
  final bool showRipple;

  const TabComponent({
    super.key,
    required this.items,
    required this.activeIndex,
    this.height,
    this.margin,
    this.padding,
    this.borderRadius,
    this.showRipple = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = colorScheme.surfaceContainerHighest;

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: height ?? 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 24),
        color: backgroundColor,
      ),
      child: Row(
        children: List.generate(items.length, (index) {
          final item = items[index];
          final bool isActive = activeIndex == index;
          return Expanded(
            child: _TabItemWidget(
              item: item,
              isActive: isActive,
              isFirst: index == 0,
              isLast: index == items.length - 1,
              borderRadius: borderRadius ?? 24,
              padding:
                  padding ??
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              showRipple: showRipple,
            ),
          );
        }),
      ),
    );
  }
}

class _TabItemWidget extends StatefulWidget {
  final TabItem item;
  final bool isActive;
  final bool isFirst;
  final bool isLast;
  final double borderRadius;
  final EdgeInsets padding;
  final bool showRipple;

  const _TabItemWidget({
    required this.item,
    required this.isActive,
    required this.isFirst,
    required this.isLast,
    required this.borderRadius,
    required this.padding,
    required this.showRipple,
  });

  @override
  State<_TabItemWidget> createState() => _TabItemWidgetState();
}

class _TabItemWidgetState extends State<_TabItemWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(_TabItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _animationController.forward().then((_) {
          _animationController.reverse();
        });
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final primaryColor = colorScheme.primary;
    final onSurfaceColor = colorScheme.onSurface;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(scale: _scaleAnimation.value, child: child);
      },
      child: GestureDetector(
        onTapDown: (_) {
          if (widget.showRipple) {
            _animationController.forward();
          }
        },
        onTapUp: (_) {
          if (widget.showRipple) {
            _animationController.reverse();
          }
        },
        onTapCancel: () {
          if (widget.showRipple) {
            _animationController.reverse();
          }
        },
        onTap: widget.item.onTap,
        child: Container(
          padding: widget.padding,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.isActive ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.horizontal(
              left: widget.isFirst
                  ? Radius.circular(widget.borderRadius)
                  : Radius.zero,
              right: widget.isLast
                  ? Radius.circular(widget.borderRadius)
                  : Radius.zero,
            ),
            boxShadow: widget.isActive
                ? [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              color: widget.isActive ? colorScheme.onPrimary : onSurfaceColor,
              fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w500,
              fontSize: 14,
              letterSpacing: widget.isActive ? 0.5 : 0,
            ),
            child: Text(widget.item.text),
          ),
        ),
      ),
    );
  }
}

class TabItem {
  final String text;
  final Function() onTap;

  const TabItem({required this.text, required this.onTap});
}

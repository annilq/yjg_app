import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';

/// 标签组件 - Flat Design 风格
///
/// 特点：
/// - 选中态：主色背景 + 白字
/// - 滑块跟随选中项平滑移动
/// - 无 border，纯色块
class TabComponent extends StatelessWidget {
  final List<TabItem> items;
  final int activeIndex;
  final double? height;
  final EdgeInsets? margin;

  const TabComponent({
    super.key,
    required this.items,
    required this.activeIndex,
    this.height,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? DarkColors.surface : LightColors.surface;
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      margin: margin ?? AppSpacing.horizontalLg,
      height: height ?? 44,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppRadius.allSm,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final count = items.length;
          if (count == 0) return const SizedBox.shrink();

          final itemWidth = constraints.maxWidth / count;

          return Stack(
            children: [
              // 滑块 - 主色背景
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                left: activeIndex * itemWidth + 3,
                top: 3,
                bottom: 3,
                width: itemWidth - 6,
                child: Container(
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: AppRadius.allSm,
                  ),
                ),
              ),
              // 选项
              Row(
                children: List.generate(count, (index) {
                  final item = items[index];
                  final isActive = activeIndex == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: item.onTap,
                      behavior: HitTestBehavior.opaque,
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: AppTypography.bodyMedium.copyWith(
                            color: isActive
                                ? AppColors.white
                                : (isDark
                                    ? DarkColors.textSecondary
                                    : LightColors.textSecondary),
                            fontWeight: isActive
                                ? AppTypography.weightSemibold
                                : AppTypography.weightMedium,
                          ),
                          child: Text(item.text),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}

class TabItem {
  final String text;
  final VoidCallback onTap;

  const TabItem({required this.text, required this.onTap});
}

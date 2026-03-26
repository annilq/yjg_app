import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';

/// 标签组件 - iOS Segmented Control 风格
///
/// 特点：
/// - 灰色背景 + 白色滑块
/// - 滑块跟随选中项平滑移动
/// - 选中黑字，未选中灰字
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
    final bgColor = isDark ? DarkColors.surfaceVariant : LightColors.surfaceVariant;
    final sliderColor = isDark ? DarkColors.surface : LightColors.surface;

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
              // 滑块
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                left: activeIndex * itemWidth,
                top: 3,
                bottom: 3,
                width: itemWidth,
                child: Container(
                  decoration: BoxDecoration(
                    color: sliderColor,
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
                                ? Theme.of(context).colorScheme.primary
                                : (isDark ? DarkColors.textTertiary : LightColors.textTertiary),
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

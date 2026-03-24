import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';

/// Flat Design 风格的 AppBar 组件
///
/// 特点：
/// - 纯色背景（非渐变）
/// - 底部边框分隔
/// - 无阴影
/// - 支持自定义颜色和样式
class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showSearch;
  final Function()? onSearchPressed;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool automaticallyImplyLeading;
  final Widget? leading;
  final double? elevation;
  final bool centerTitle;

  const AppBarComponent({
    super.key,
    this.title,
    this.showSearch = false,
    this.onSearchPressed,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.automaticallyImplyLeading = true,
    this.leading,
    this.elevation = 0,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    // 默认颜色
    final bgColor = backgroundColor ?? (isDark ? DarkColors.surface : AppColors.primaryDark);
    final fgColor = foregroundColor ?? AppColors.white;

    return AppBar(
      title: title != null
          ? Text(
              title!,
              style: AppTypography.headlineMedium.copyWith(color: fgColor),
            )
          : null,
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      surfaceTintColor: AppColors.transparent,
      elevation: elevation,
      scrolledUnderElevation: 0,
      centerTitle: centerTitle,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading ?? _buildDefaultLeading(context, fgColor),
      actions: [
        if (showSearch && onSearchPressed != null)
          IconButton(
            icon: Icon(CupertinoIcons.search, color: fgColor),
            onPressed: onSearchPressed,
          ),
        ...?actions,
      ],
      // Flat Design: 底部边框替代阴影
      shape: Border(
        bottom: BorderSide(
          color: isDark ? DarkColors.border : LightColors.border,
          width: 1,
        ),
      ),
    );
  }

  /// 构建默认返回按钮
  Widget? _buildDefaultLeading(BuildContext context, Color color) {
    if (!automaticallyImplyLeading) return null;
    if (!Navigator.of(context).canPop()) return null;

    return IconButton(
      icon: Icon(CupertinoIcons.chevron_left, color: color),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// 简洁版 AppBar（仅标题）
class SimpleAppBar extends AppBarComponent {
  const SimpleAppBar({super.key, required String super.title, super.actions});
}

/// 带搜索的 AppBar
class SearchAppBar extends AppBarComponent {
  const SearchAppBar({
    super.key,
    required String super.title,
    required Function() onSearchPressed,
    super.actions,
  }) : super(showSearch: true, onSearchPressed: onSearchPressed);
}

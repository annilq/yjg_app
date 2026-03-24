import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showSearch;
  final Function()? onSearchPressed;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool automaticallyImplyLeading;

  const AppBarComponent({
    super.key,
    this.title,
    this.showSearch = false,
    this.onSearchPressed,
    this.actions,
    this.backgroundColor,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = backgroundColor ?? (isDark ? AppTheme.primaryColorDark : AppTheme.primaryColor);
    final onBgColor = AppTheme.white;

    return AppBar(
      title: title != null
          ? Text(
              title!,
              style: TextStyle(
                color: onBgColor,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            )
          : null,
      backgroundColor: bgColor,
      surfaceTintColor: Colors.transparent,
      actions: [
        if (showSearch && onSearchPressed != null)
          IconButton(
            icon: Icon(CupertinoIcons.search, color: onBgColor),
            onPressed: onSearchPressed,
          ),
        ...?actions,
      ],
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: automaticallyImplyLeading && Navigator.of(context).canPop()
          ? IconButton(
              icon: Icon(CupertinoIcons.chevron_left, color: onBgColor),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

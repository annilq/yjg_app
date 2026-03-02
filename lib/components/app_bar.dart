import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showSearch;
  final Function()? onSearchPressed;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? elevation;
  final bool automaticallyImplyLeading;

  const CustomAppBar({
    Key? key,
    this.title,
    this.showSearch = false,
    this.onSearchPressed,
    this.actions,
    this.backgroundColor,
    this.elevation,
    this.automaticallyImplyLeading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(
                color: AppTheme.white,
                fontWeight: FontWeight.w600,
              ),
            )
          : null,
      backgroundColor: backgroundColor ?? AppTheme.primaryColor,
      actions: [
        if (showSearch && onSearchPressed != null)
          IconButton(
            icon: const Icon(CupertinoIcons.search),
            color: AppTheme.white,
            onPressed: onSearchPressed,
          ),
        ...?actions,
      ],
      elevation: elevation ?? 0,
      centerTitle: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: automaticallyImplyLeading && Navigator.of(context).canPop()
          ? IconButton(
              icon: const Icon(CupertinoIcons.chevron_left),
              color: AppTheme.white,
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

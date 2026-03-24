import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showSearch;
  final Function()? onSearchPressed;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? elevation;
  final bool automaticallyImplyLeading;

  const AppBarComponent({
    super.key,
    this.title,
    this.showSearch = false,
    this.onSearchPressed,
    this.actions,
    this.backgroundColor,
    this.elevation,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      title: title != null
          ? Text(
              title!,
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            )
          : null,
      backgroundColor: backgroundColor ?? colorScheme.surface,
      actions: [
        if (showSearch && onSearchPressed != null)
          IconButton(
            icon: const Icon(CupertinoIcons.search),
            color: colorScheme.onSurface,
            onPressed: onSearchPressed,
          ),
        ...?actions,
      ],
      elevation: elevation ?? 0,
      centerTitle: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: automaticallyImplyLeading && GoRouter.of(context).canPop()
          ? IconButton(
              icon: const Icon(CupertinoIcons.chevron_left),
              color: colorScheme.onSurface,
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

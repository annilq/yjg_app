import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';

/// Flat Design 风格的按钮组件
///
/// 特点：
/// - 无阴影
/// - 统一圆角 (4px)
/// - 标准内边距
/// - 支持多种变体
class ButtonComponent extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final String? text;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;

  const ButtonComponent({
    super.key,
    required this.onPressed,
    this.child,
    this.text,
    this.variant = ButtonVariant.filled,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
  }) : assert(
          child != null || text != null,
          'Either child or text must be provided',
        );

  /// 主要按钮（填充样式）
  factory ButtonComponent.primary({
    Key? key,
    required VoidCallback? onPressed,
    Widget? child,
    String? text,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? icon,
  }) {
    return ButtonComponent(
      key: key,
      onPressed: onPressed,
      text: text,
      variant: ButtonVariant.filled,
      size: size,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      icon: icon,
      child: child,
    );
  }

  /// 次要按钮（描边样式）
  factory ButtonComponent.secondary({
    Key? key,
    required VoidCallback? onPressed,
    Widget? child,
    String? text,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? icon,
  }) {
    return ButtonComponent(
      key: key,
      onPressed: onPressed,
      text: text,
      variant: ButtonVariant.outlined,
      size: size,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      icon: icon,
      child: child,
    );
  }

  /// 文字按钮
  factory ButtonComponent.text({
    Key? key,
    required VoidCallback? onPressed,
    Widget? child,
    String? text,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? icon,
  }) {
    return ButtonComponent(
      key: key,
      onPressed: onPressed,
      text: text,
      variant: ButtonVariant.text,
      size: size,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      icon: icon,
      child: child,
    );
  }

  /// 幽灵按钮（带背景的文字按钮）
  factory ButtonComponent.ghost({
    Key? key,
    required VoidCallback? onPressed,
    Widget? child,
    String? text,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? icon,
  }) {
    return ButtonComponent(
      key: key,
      onPressed: onPressed,
      text: text,
      variant: ButtonVariant.ghost,
      size: size,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      icon: icon,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    // 构建子组件
    Widget buttonChild = _buildChild(context);

    // 应用尺寸约束
    if (isFullWidth) {
      buttonChild = SizedBox(
        width: double.infinity,
        child: Center(child: buttonChild),
      );
    }

    // 根据变体返回对应按钮
    switch (variant) {
      case ButtonVariant.filled:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: _filledStyle(context, isDark),
          child: buttonChild,
        );
      case ButtonVariant.outlined:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: _outlinedStyle(context, isDark),
          child: buttonChild,
        );
      case ButtonVariant.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: _textStyle(context),
          child: buttonChild,
        );
      case ButtonVariant.ghost:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: _ghostStyle(context, isDark),
          child: buttonChild,
        );
    }
  }

  /// 构建按钮内容
  Widget _buildChild(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: _getLoadingSize(),
        width: _getLoadingSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            variant == ButtonVariant.filled
                ? AppColors.white
                : Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    }

    if (child != null) {
      return child!;
    }

    // 构建带图标的文字
    if (icon != null && text != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: _getIconSize()),
          SizedBox(width: AppSpacing.sm),
          Text(text!),
        ],
      );
    }

    return Text(text!);
  }

  /// 获取加载指示器大小
  double _getLoadingSize() {
    switch (size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 20;
      case ButtonSize.large:
        return 24;
    }
  }

  /// 获取图标大小
  double _getIconSize() {
    switch (size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 18;
      case ButtonSize.large:
        return 20;
    }
  }

  /// 获取内边距
  EdgeInsets _getPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        );
      case ButtonSize.medium:
        return AppSpacing.buttonPadding;
      case ButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.xxl,
          vertical: AppSpacing.md,
        );
    }
  }

  /// 填充按钮样式
  ButtonStyle _filledStyle(BuildContext context, bool isDark) {
    return ElevatedButton.styleFrom(
      elevation: 0,
      shadowColor: AppColors.transparent,
      backgroundColor: isDark ? AppColors.primaryLight : AppColors.primary,
      foregroundColor: isDark ? DarkColors.background : AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.buttonRadius,
      ),
      padding: _getPadding(),
      textStyle: AppTypography.labelLarge,
      minimumSize: const Size(64, 44),
    );
  }

  /// 描边按钮样式
  ButtonStyle _outlinedStyle(BuildContext context, bool isDark) {
    return OutlinedButton.styleFrom(
      foregroundColor: isDark ? AppColors.primaryLight : AppColors.primary,
      side: BorderSide(
        color: isDark ? DarkColors.border : LightColors.border,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.buttonRadius,
      ),
      padding: _getPadding(),
      textStyle: AppTypography.labelLarge,
      minimumSize: const Size(64, 44),
    );
  }

  /// 文字按钮样式
  ButtonStyle _textStyle(BuildContext context) {
    return TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.buttonRadius,
      ),
      padding: _getPadding(),
      textStyle: AppTypography.labelLarge,
      minimumSize: const Size(64, 44),
    );
  }

  /// 幽灵按钮样式
  ButtonStyle _ghostStyle(BuildContext context, bool isDark) {
    return TextButton.styleFrom(
      foregroundColor: isDark ? AppColors.primaryLight : AppColors.primary,
      backgroundColor: isDark
          ? AppColors.primary.withAlpha(26)
          : AppColors.primary.withAlpha(26),
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.buttonRadius,
      ),
      padding: _getPadding(),
      textStyle: AppTypography.labelLarge,
      minimumSize: const Size(64, 44),
    );
  }
}

/// 按钮变体
enum ButtonVariant {
  filled, // 填充样式
  outlined, // 描边样式
  text, // 纯文字
  ghost, // 幽灵样式（带背景的文字按钮）
}

/// 按钮尺寸
enum ButtonSize {
  small, // 小
  medium, // 中（默认）
  large, // 大
}

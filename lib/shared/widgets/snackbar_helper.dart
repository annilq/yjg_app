import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';

/// SnackBar 工具类 - Flat Design 风格
///
/// 特点：
/// - 统一的视觉风格，符合项目设计理念
/// - 成功/错误/信息类型区分
/// - 图标 + 文字，提升信息传达效率
/// - 平滑动画，自然减速
///
/// 使用示例：
/// ```dart
/// // 普通 SnackBar
/// SnackBarHelper.show(context, '操作成功');
///
/// // 成功 SnackBar
/// SnackBarHelper.success(context, '保存成功');
///
/// // 错误 SnackBar
/// SnackBarHelper.error(context, '网络连接失败');
///
/// // 信息 SnackBar
/// SnackBarHelper.info(context, '正在同步数据...');
/// ```
class SnackBarHelper {
  SnackBarHelper._();

  /// 显示普通 SnackBar
  static void show(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    _showSnackBar(context, message, duration: duration, actionLabel: actionLabel, onAction: onAction);
  }

  /// 显示成功 SnackBar
  static void success(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    String actionLabel = '好的',
    VoidCallback? onAction,
  }) {
    _showSnackBar(
      context,
      message,
      type: SnackBarType.success,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  /// 显示错误 SnackBar
  static void error(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
    String actionLabel = '关闭',
    VoidCallback? onAction,
  }) {
    _showSnackBar(
      context,
      message,
      type: SnackBarType.error,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  /// 显示信息 SnackBar
  static void info(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    _showSnackBar(
      context,
      message,
      type: SnackBarType.info,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  static void _showSnackBar(
    BuildContext context,
    String message, {
    SnackBarType type = SnackBarType.info,
    required Duration duration,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    if (!context.mounted) return;

    try {
      final isDark = Theme.of(context).brightness == Brightness.dark;

      // 根据类型确定颜色
      final (bgColor, textColor, iconColor, iconData) = _getColorsAndIcon(type, isDark);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(iconData, size: 18, color: iconColor),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  message,
                  style: AppTypography.bodyMedium.copyWith(
                    color: textColor,
                    fontWeight: AppTypography.weightMedium,
                  ),
                ),
              ),
            ],
          ),
          duration: duration,
          elevation: 0,
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(AppSpacing.lg),
          animation: CurvedAnimation(
            parent: ModalRoute.of(context)?.animation ?? const AlwaysStoppedAnimation(1),
            curve: Curves.easeOutCubic,
          ),
          action: actionLabel != null
              ? SnackBarAction(
                  label: actionLabel,
                  textColor: iconColor,
                  onPressed: onAction ?? () {},
                )
              : null,
        ),
      );
    } catch (e) {
      // 备选方案：使用 CupertinoAlertDialog
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: const Text('确定'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      );
    }
  }

  /// 获取颜色和图标
  static (Color, Color, Color, IconData) _getColorsAndIcon(SnackBarType type, bool isDark) {
    switch (type) {
      case SnackBarType.success:
        return (
          isDark ? DarkColors.successBg : LightColors.successBg,
          isDark ? DarkColors.textPrimary : LightColors.textPrimary,
          AppColors.success,
          CupertinoIcons.checkmark_circle_fill,
        );
      case SnackBarType.error:
        return (
          isDark ? DarkColors.errorBg : LightColors.errorBg,
          isDark ? DarkColors.textPrimary : LightColors.textPrimary,
          AppColors.error,
          CupertinoIcons.xmark_circle_fill,
        );
      case SnackBarType.info:
      default:
        return (
          isDark ? DarkColors.infoBg : LightColors.infoBg,
          isDark ? DarkColors.textPrimary : LightColors.textPrimary,
          AppColors.info,
          CupertinoIcons.info_circle_fill,
        );
    }
  }

  // 兼容旧接口
  @Deprecated('Use show() instead')
  static void showSnackBar(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    show(
      context,
      message,
      duration: duration,
      actionLabel: action?.label,
      onAction: action?.onPressed,
    );
  }

  /// 通过GlobalKey显示SnackBar（兼容旧接口）
  static void showSnackBarWithKey(
    GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
      ),
    );
  }

  @Deprecated('Use success() instead')
  static void showSuccessSnackBar(BuildContext context, String message) {
    success(context, message);
  }

  @Deprecated('Use error() instead')
  static void showErrorSnackBar(BuildContext context, String message) {
    error(context, message);
  }
}

/// SnackBar 类型
enum SnackBarType {
  info,
  success,
  error,
}

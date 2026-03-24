import 'package:flutter/material.dart';

/// SnackBar 工具类，提供显示SnackBar的通用方法
/// Flat Design: 使用 inverseSurface + 扁平边框，无阴影
///
/// 提供以下功能：
/// 1. 通过BuildContext显示SnackBar
/// 2. 通过GlobalKey<ScaffoldMessengerState>显示SnackBar
/// 3. 显示成功和错误类型的SnackBar
///
/// 使用示例：
/// ```dart
/// // 通过BuildContext显示普通SnackBar
/// SnackBarHelper.showSnackBar(context, '操作成功');
///
/// // 通过GlobalKey显示SnackBar
/// final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
/// SnackBarHelper.showSnackBarWithKey(_scaffoldMessengerKey, '操作成功');
///
/// // 显示成功SnackBar
/// SnackBarHelper.showSuccessSnackBar(context, '操作成功');
///
/// // 显示错误SnackBar
/// SnackBarHelper.showErrorSnackBar(context, '操作失败');
///
/// // 自定义SnackBar，添加操作按钮
/// SnackBarHelper.showSnackBar(
///   context,
///   '是否确认操作？',
///   action: SnackBarAction(
///     label: '确认',
///     onPressed: () {
///       // 执行确认操作
///     },
///   ),
/// );
/// ```
class SnackBarHelper {
  /// 显示SnackBar
  ///
  /// [context] 上下文，用于获取ScaffoldMessenger
  /// [message] 显示的消息内容
  /// [duration] 显示持续时间，默认3秒
  /// [action] 可选的操作按钮
  static void showSnackBar(
    BuildContext context,
    String message,
    {
      Duration duration = const Duration(seconds: 3),
      SnackBarAction? action
    }
  ) {
    if (!context.mounted) return;

    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark
        ? const Color(0xFF3A3A3C) // darkBorderLight
        : const Color(0xFFE8E8E8).withValues(alpha: 0.5);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: colorScheme.onInverseSurface,
            fontSize: 14,
          ),
        ),
        duration: duration,
        elevation: 0,
        backgroundColor: colorScheme.inverseSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: borderColor, width: 0.5),
        ),
        behavior: SnackBarBehavior.floating,
        action: action != null
            ? SnackBarAction(
                label: action.label,
                textColor: colorScheme.primary,
                onPressed: action.onPressed,
              )
            : null,
      ),
    );
  }

  /// 通过GlobalKey显示SnackBar
  ///
  /// [scaffoldMessengerKey] ScaffoldMessenger的GlobalKey
  /// [message] 显示的消息内容
  /// [duration] 显示持续时间，默认3秒
  /// [action] 可选的操作按钮
  static void showSnackBarWithKey(
    GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
    String message,
    {
      Duration duration = const Duration(seconds: 3),
      SnackBarAction? action
    }
  ) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
      ),
    );
  }

  /// 显示成功SnackBar
  ///
  /// [context] 上下文，用于获取ScaffoldMessenger
  /// [message] 显示的消息内容
  static void showSuccessSnackBar(
    BuildContext context,
    String message,
  ) {
    showSnackBar(
      context,
      message,
      action: SnackBarAction(
        label: '确定',
        onPressed: () {},
      ),
    );
  }

  /// 显示错误SnackBar
  ///
  /// [context] 上下文，用于获取ScaffoldMessenger
  /// [message] 显示的消息内容
  static void showErrorSnackBar(
    BuildContext context,
    String message,
  ) {
    showSnackBar(
      context,
      message,
      action: SnackBarAction(
        label: '关闭',
        onPressed: () {},
      ),
    );
  }
}

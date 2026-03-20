import 'package:flutter/material.dart';

/// SnackBar 工具类，提供显示SnackBar的通用方法
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
    try {
      // 检查上下文是否仍然有效
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            duration: duration,
            action: action,
          ),
        );
      }
    } catch (e) {
      // 如果找不到ScaffoldMessenger或上下文已失效，创建一个临时的ScaffoldMessenger来显示SnackBar
      try {
        if (context.mounted) {
          final overlay = Overlay.of(context, rootOverlay: true);
          if (overlay != null) {
            final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
            final scaffoldMessenger = ScaffoldMessenger(key: scaffoldMessengerKey, child: Container());
            
            // 将ScaffoldMessenger添加到Overlay
            final entry = OverlayEntry(builder: (context) => scaffoldMessenger);
            overlay.insert(entry);
            
            // 显示SnackBar
            Future.microtask(() {
              if (scaffoldMessengerKey.currentState != null) {
                scaffoldMessengerKey.currentState!.showSnackBar(
                  SnackBar(
                    content: Text(message),
                    duration: duration,
                    action: action,
                  ),
                );
                
                // 显示完成后移除OverlayEntry
                Future.delayed(duration + const Duration(milliseconds: 500), () {
                  entry.remove();
                });
              } else {
                // 如果ScaffoldMessengerState为null，直接移除OverlayEntry
                entry.remove();
              }
            });
          }
        }
      } catch (overlayError) {
        // 如果所有方法都失败，记录错误但不崩溃
        print('Failed to show SnackBar: $overlayError');
      }
    }
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

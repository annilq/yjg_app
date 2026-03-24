import 'package:flutter/material.dart';

/// 阴影系统 Token
/// Flat Design 原则：最小化使用阴影，主要通过边框和背景色区分层次
class AppShadows {
  AppShadows._();

  // Flat Design: 无阴影
  static const List<BoxShadow> none = [];

  // Minimal shadows for elevation hints (Flat Design 中极少使用)

  /// 极小阴影 - 仅用于微妙的层次提示
  static const List<BoxShadow> xs = [
    BoxShadow(
      color: Color(0x0D000000), // 5% opacity
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];

  /// 小阴影
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x0D000000), // 5% opacity
      blurRadius: 4,
      offset: Offset(0, 1),
    ),
  ];

  /// 中阴影
  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x0D000000), // 5% opacity
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ];

  /// 大阴影
  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x0D000000), // 5% opacity
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  // Component Specific - 组件专用阴影

  /// 卡片阴影 - Flat Design: 无阴影
  static const List<BoxShadow> card = none;

  /// 按钮阴影 - Flat Design: 无阴影
  static const List<BoxShadow> button = none;

  /// 对话框阴影 - Flat Design: 无阴影
  static const List<BoxShadow> dialog = none;

  /// 底部弹窗阴影 - Flat Design: 极小阴影
  static const List<BoxShadow> bottomSheet = xs;

  /// 悬浮按钮阴影 - Flat Design: 极小阴影
  static const List<BoxShadow> fab = sm;

  /// 下拉菜单阴影 - Flat Design: 极小阴影
  static const List<BoxShadow> dropdown = sm;

  /// 工具提示阴影 - Flat Design: 无阴影
  static const List<BoxShadow> tooltip = none;

  /// Snackbar 阴影 - Flat Design: 无阴影
  static const List<BoxShadow> snackbar = none;

  /// 模态框阴影 - Flat Design: 无阴影
  static const List<BoxShadow> modal = none;

  // Focus Ring - 焦点环 (Flat Design 中用于表示焦点状态)

  /// 焦点环 - Primary
  static BoxShadow focusRing(Color color) => BoxShadow(
    color: color.withAlpha(51), // 20% opacity
    blurRadius: 0,
    spreadRadius: 2,
  );

  /// 焦点环 - 小
  static BoxShadow focusRingSm(Color color) => BoxShadow(
    color: color.withAlpha(51),
    blurRadius: 0,
    spreadRadius: 1,
  );

  /// 焦点环 - 大
  static BoxShadow focusRingLg(Color color) => BoxShadow(
    color: color.withAlpha(51),
    blurRadius: 0,
    spreadRadius: 3,
  );
}

/// 阴影扩展
extension ShadowExtension on Widget {
  /// 添加 Flat Design 风格的边框替代阴影
  Widget withFlatBorder({
    required BuildContext context,
    Color? color,
    double width = 1.0,
  }) {
    final effectiveColor =
        color ??
        (Theme.of(context).brightness == Brightness.light
            ? const Color(0xFFE5E7EB)
            : const Color(0xFF2E2E30));

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: effectiveColor, width: width),
      ),
      child: this,
    );
  }
}

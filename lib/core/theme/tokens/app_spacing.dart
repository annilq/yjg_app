import 'package:flutter/material.dart';

/// 间距系统 Token
/// 基于 4px 的 8-point grid 系统
class AppSpacing {
  AppSpacing._();

  // Base Unit - 基础单位
  static const double unit = 4.0;

  // Spacing Scale - 间距比例
  static const double none = 0.0;
  static const double px = 1.0;
  static const double xs = 4.0; // 1 unit
  static const double sm = 8.0; // 2 units
  static const double md = 12.0; // 3 units
  static const double lg = 16.0; // 4 units
  static const double xl = 20.0; // 5 units
  static const double xxl = 24.0; // 6 units
  static const double xxxl = 32.0; // 8 units
  static const double xxxxl = 40.0; // 10 units
  static const double xxxxxl = 48.0; // 12 units

  // Component Specific - 组件专用间距

  /// 卡片内边距
  static const double cardPadding = md;

  /// 卡片外边距
  static const double cardMargin = md;

  /// 区块间距 - 增强视觉分组
  static const double sectionGap = xxl;

  /// 元素间距
  static const double elementGap = md;

  /// 紧凑间距
  static const double tightGap = sm;

  /// 列表项间距
  static const double listItemGap = sm;

  /// 按钮内边距 - 水平
  static const double buttonPaddingH = xl;

  /// 按钮内边距 - 垂直
  static const double buttonPaddingV = md;

  /// 输入框内边距 - 水平
  static const double inputPaddingH = lg;

  /// 输入框内边距 - 垂直
  static const double inputPaddingV = md;

  /// 图标按钮内边距
  static const double iconButtonPadding = sm;

  /// 屏幕水平边距
  static const double screenPaddingH = lg;

  /// 屏幕垂直边距
  static const double screenPaddingV = lg;

  // EdgeInsets Helpers - 便捷方法

  /// 零间距
  static const EdgeInsets zero = EdgeInsets.zero;

  /// 全方向小间距
  static const EdgeInsets allXs = EdgeInsets.all(xs);

  /// 全方向中间距
  static const EdgeInsets allSm = EdgeInsets.all(sm);

  /// 全方向大间距
  static const EdgeInsets allMd = EdgeInsets.all(md);

  /// 全方向超大间距
  static const EdgeInsets allLg = EdgeInsets.all(lg);

  /// 水平方向小间距
  static const EdgeInsets horizontalXs = EdgeInsets.symmetric(horizontal: xs);

  /// 水平方向中间距
  static const EdgeInsets horizontalSm = EdgeInsets.symmetric(horizontal: sm);

  /// 水平方向大间距
  static const EdgeInsets horizontalMd = EdgeInsets.symmetric(horizontal: md);

  /// 水平方向超大间距
  static const EdgeInsets horizontalLg = EdgeInsets.symmetric(horizontal: lg);

  /// 垂直方向小间距
  static const EdgeInsets verticalXs = EdgeInsets.symmetric(vertical: xs);

  /// 垂直方向中间距
  static const EdgeInsets verticalSm = EdgeInsets.symmetric(vertical: sm);

  /// 垂直方向大间距
  static const EdgeInsets verticalMd = EdgeInsets.symmetric(vertical: md);

  /// 垂直方向超大间距
  static const EdgeInsets verticalLg = EdgeInsets.symmetric(vertical: lg);

  /// 屏幕默认内边距
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: screenPaddingH,
    vertical: screenPaddingV,
  );

  /// 卡片默认内边距
  static const EdgeInsets cardPaddingAll = EdgeInsets.all(cardPadding);

  /// 按钮默认内边距
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: buttonPaddingH,
    vertical: buttonPaddingV,
  );

  /// 输入框默认内边距
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: inputPaddingH,
    vertical: inputPaddingV,
  );

  /// 列表项默认内边距
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: sm,
  );
}

/// 间距扩展
extension SpacingExtension on num {
  /// 转换为间距倍数
  /// 例如: 2.spacing = 8.0
  double get spacing => this * AppSpacing.unit;

  /// 转换为 EdgeInsets
  EdgeInsets get all => EdgeInsets.all(toDouble() * AppSpacing.unit);

  EdgeInsets get horizontal =>
      EdgeInsets.symmetric(horizontal: toDouble() * AppSpacing.unit);

  EdgeInsets get vertical =>
      EdgeInsets.symmetric(vertical: toDouble() * AppSpacing.unit);
}

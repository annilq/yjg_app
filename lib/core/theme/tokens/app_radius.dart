import 'package:flutter/material.dart';

/// 圆角系统 Token
class AppRadius {
  AppRadius._();

  // Base Unit - 基础单位
  static const double unit = 4.0;

  // Radius Scale - 圆角比例
  static const double none = 0.0;
  static const double sm = 4.0; // 小圆角 (按钮、输入框)
  static const double md = 8.0; // 中圆角 (卡片)
  static const double lg = 12.0; // 大圆角 (大卡片、模态框)
  static const double xl = 16.0; // 超大圆角 (特殊容器)
  static const double xxl = 20.0; // 特大圆角
  static const double xxxl = 24.0; // 超特大圆角
  static const double full = 9999.0; // 全圆角 (标签、头像)

  // Component Specific - 组件专用圆角

  /// 按钮圆角
  static const double button = sm;

  /// 输入框圆角
  static const double input = sm;

  /// 小卡片圆角
  static const double cardSm = sm;

  /// 卡片圆角
  static const double card = md;

  /// 大卡片圆角
  static const double cardLg = lg;

  /// 对话框圆角
  static const double dialog = lg;

  /// 底部弹窗圆角
  static const double bottomSheet = xl;

  /// 标签/Chip 圆角
  static const double chip = full;

  /// 头像圆角
  static const double avatar = full;

  /// 徽章圆角
  static const double badge = full;

  /// 开关圆角
  static const double switchTrack = full;

  /// 进度条圆角
  static const double progressBar = full;

  /// 工具提示圆角
  static const double tooltip = sm;

  /// Snackbar 圆角
  static const double snackbar = md;

  // BorderRadius Helpers - 便捷方法

  /// 无圆角
  static const BorderRadius zero = BorderRadius.zero;

  /// 全方向小圆角
  static const BorderRadius allSm = BorderRadius.all(Radius.circular(sm));

  /// 全方向中圆角
  static const BorderRadius allMd = BorderRadius.all(Radius.circular(md));

  /// 全方向大圆角
  static const BorderRadius allLg = BorderRadius.all(Radius.circular(lg));

  /// 全方向超大圆角
  static const BorderRadius allXl = BorderRadius.all(Radius.circular(xl));

  /// 全方向全圆角
  static const BorderRadius allFull = BorderRadius.all(Radius.circular(full));

  /// 顶部圆角 - 小
  static const BorderRadius topSm = BorderRadius.vertical(
    top: Radius.circular(sm),
  );

  /// 顶部圆角 - 中
  static const BorderRadius topMd = BorderRadius.vertical(
    top: Radius.circular(md),
  );

  /// 顶部圆角 - 大
  static const BorderRadius topLg = BorderRadius.vertical(
    top: Radius.circular(lg),
  );

  /// 顶部圆角 - 超大
  static const BorderRadius topXl = BorderRadius.vertical(
    top: Radius.circular(xl),
  );

  /// 底部圆角 - 小
  static const BorderRadius bottomSm = BorderRadius.vertical(
    bottom: Radius.circular(sm),
  );

  /// 底部圆角 - 中
  static const BorderRadius bottomMd = BorderRadius.vertical(
    bottom: Radius.circular(md),
  );

  /// 底部圆角 - 大
  static const BorderRadius bottomLg = BorderRadius.vertical(
    bottom: Radius.circular(lg),
  );

  /// 左侧圆角 - 小
  static const BorderRadius leftSm = BorderRadius.horizontal(
    left: Radius.circular(sm),
  );

  /// 左侧圆角 - 中
  static const BorderRadius leftMd = BorderRadius.horizontal(
    left: Radius.circular(md),
  );

  /// 右侧圆角 - 小
  static const BorderRadius rightSm = BorderRadius.horizontal(
    right: Radius.circular(sm),
  );

  /// 右侧圆角 - 中
  static const BorderRadius rightMd = BorderRadius.horizontal(
    right: Radius.circular(md),
  );

  /// 卡片默认圆角
  static const BorderRadius cardRadius = allSm;

  /// 按钮默认圆角
  static const BorderRadius buttonRadius = allSm;

  /// 输入框默认圆角
  static const BorderRadius inputRadius = allSm;

  /// 对话框默认圆角
  static const BorderRadius dialogRadius = allMd;
}

/// 圆角扩展
extension RadiusExtension on num {
  /// 转换为圆角倍数
  /// 例如: 2.radius = 8.0
  double get radius => this * AppRadius.unit;

  /// 转换为 BorderRadius
  BorderRadius get circular => BorderRadius.circular(toDouble() * AppRadius.unit);
}

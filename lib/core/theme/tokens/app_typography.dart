import 'package:flutter/material.dart';

/// 字体系统 Token
class AppTypography {
  AppTypography._();

  // Font Family - 使用系统默认字体
  static const String fontFamily = '.SF Pro Text';
  static const String fontFamilyDisplay = '.SF Pro Display';

  // Font Sizes - 字体大小
  static const double size2xs = 10.0; // Micro
  static const double sizeXs = 11.0; // Caption
  static const double sizeSm = 12.0; // Small
  static const double sizeBase = 14.0; // Body
  static const double sizeLg = 16.0; // Large
  static const double sizeXl = 18.0; // Title
  static const double size2xl = 20.0; // Heading
  static const double size3xl = 24.0; // Display Small
  static const double size4xl = 30.0; // Display Medium
  static const double size5xl = 36.0; // Display Large

  // Font Weights - 字重
  static const FontWeight weightNormal = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightSemibold = FontWeight.w600;
  static const FontWeight weightBold = FontWeight.w700;

  // Line Heights - 行高（倍数）
  static const double leadingNone = 1.0;
  static const double leadingTight = 1.25;
  static const double leadingSnug = 1.375;
  static const double leadingNormal = 1.5;
  static const double leadingRelaxed = 1.625;
  static const double leadingLoose = 2.0;

  // Letter Spacing - 字间距
  static const double trackingTighter = -0.8;
  static const double trackingTight = -0.4;
  static const double trackingNormal = 0.0;
  static const double trackingWide = 0.4;
  static const double trackingWider = 0.8;

  // Text Styles - 预设文本样式

  /// Display Large - 最大标题
  static const TextStyle displayLarge = TextStyle(
    fontSize: size4xl,
    fontWeight: weightBold,
    height: leadingTight,
    letterSpacing: trackingTight,
  );

  /// Display Medium - 中大标题
  static const TextStyle displayMedium = TextStyle(
    fontSize: size3xl,
    fontWeight: weightBold,
    height: leadingTight,
    letterSpacing: trackingTight,
  );

  /// Display Small - 小标题
  static const TextStyle displaySmall = TextStyle(
    fontSize: size2xl,
    fontWeight: weightSemibold,
    height: leadingTight,
    letterSpacing: trackingNormal,
  );

  /// Headline Large - 页面大标题
  static const TextStyle headlineLarge = TextStyle(
    fontSize: size2xl,
    fontWeight: weightSemibold,
    height: leadingSnug,
    letterSpacing: trackingNormal,
  );

  /// Headline Medium - 页面标题
  static const TextStyle headlineMedium = TextStyle(
    fontSize: sizeXl,
    fontWeight: weightSemibold,
    height: leadingSnug,
    letterSpacing: trackingNormal,
  );

  /// Headline Small - 小标题
  static const TextStyle headlineSmall = TextStyle(
    fontSize: sizeLg,
    fontWeight: weightSemibold,
    height: leadingSnug,
    letterSpacing: trackingNormal,
  );

  /// Title Large - 卡片/区块标题
  static const TextStyle titleLarge = TextStyle(
    fontSize: sizeLg,
    fontWeight: weightSemibold,
    height: leadingNormal,
    letterSpacing: trackingNormal,
  );

  /// Title Medium - 列表项标题
  static const TextStyle titleMedium = TextStyle(
    fontSize: sizeBase,
    fontWeight: weightSemibold,
    height: leadingNormal,
    letterSpacing: trackingNormal,
  );

  /// Title Small - 小标题/标签
  static const TextStyle titleSmall = TextStyle(
    fontSize: sizeSm,
    fontWeight: weightMedium,
    height: leadingNormal,
    letterSpacing: trackingWide,
  );

  /// Body Large - 大段正文
  static const TextStyle bodyLarge = TextStyle(
    fontSize: sizeLg,
    fontWeight: weightNormal,
    height: leadingRelaxed,
    letterSpacing: trackingNormal,
  );

  /// Body Medium - 默认正文
  static const TextStyle bodyMedium = TextStyle(
    fontSize: sizeBase,
    fontWeight: weightNormal,
    height: leadingRelaxed,
    letterSpacing: trackingNormal,
  );

  /// Body Small - 小正文
  static const TextStyle bodySmall = TextStyle(
    fontSize: sizeSm,
    fontWeight: weightNormal,
    height: leadingNormal,
    letterSpacing: trackingNormal,
  );

  /// Label Large - 大标签/按钮文字
  static const TextStyle labelLarge = TextStyle(
    fontSize: sizeBase,
    fontWeight: weightMedium,
    height: leadingNormal,
    letterSpacing: trackingWide,
  );

  /// Label Medium - 中标签
  static const TextStyle labelMedium = TextStyle(
    fontSize: sizeSm,
    fontWeight: weightMedium,
    height: leadingNormal,
    letterSpacing: trackingWide,
  );

  /// Label Small - 小标签
  static const TextStyle labelSmall = TextStyle(
    fontSize: sizeXs,
    fontWeight: weightMedium,
    height: leadingNormal,
    letterSpacing: trackingWide,
  );

  /// Caption - 最小说明文字
  static const TextStyle caption = TextStyle(
    fontSize: sizeXs,
    fontWeight: weightNormal,
    height: leadingNormal,
    letterSpacing: trackingNormal,
  );

  /// Overline - 超小标签
  static const TextStyle overline = TextStyle(
    fontSize: size2xs,
    fontWeight: weightMedium,
    height: leadingNormal,
    letterSpacing: trackingWider,
  );
}

/// 字体扩展
extension TypographyExtension on TextTheme {
  /// 获取带颜色的文本样式
  TextStyle? get displayLargeStyle => displayLarge;
  TextStyle? get displayMediumStyle => displayMedium;
  TextStyle? get displaySmallStyle => displaySmall;
}

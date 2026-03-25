import 'package:flutter/material.dart';

/// 品牌颜色 - 与业务相关的核心颜色
class AppColors {
  AppColors._();

  // Primary - 品牌主色 (Blue)
  static const Color primary = Color(0xFF3B82F6);
  static const Color primaryLight = Color(0xFF60A5FA);
  static const Color primaryDark = Color(0xFF2563EB);
  static const Color primaryMuted = Color(0xFFDBEAFE);

  // Secondary - 辅助色 (Emerald)
  static const Color secondary = Color(0xFF10B981);
  static const Color secondaryLight = Color(0xFF34D399);
  static const Color secondaryDark = Color(0xFF059669);
  static const Color secondaryMuted = Color(0xFFD1FAE5);

  // Semantic Colors - 语义色
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Neutral - 中性色
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
}

/// 浅色模式颜色
class LightColors {
  LightColors._();

  // Background - 背景色
  // 页面整体背景：柔和云雾灰，与白色卡片形成层级区分
  static const Color background = Color(0xFFF5F6FA);
  // 内容卡片背景：纯白
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF8F9FA);
  static const Color surfaceElevated = Color(0xFFF1F3F4);

  // Text - 文字色
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textDisabled = Color(0xFFD1D5DB);
  static const Color textInverse = Color(0xFFFFFFFF);

  // Border - 边框色
  // 主边框：在浅灰背景上的卡片边界
  static const Color border = Color(0xFFEAECF0);
  static const Color borderLight = Color(0xFFF0F1F3);
  static const Color borderStrong = Color(0xFFCBD0D8);

  // Interactive - 交互色
  static const Color hover = Color(0xFFF3F4F6);
  static const Color pressed = Color(0xFFE5E7EB);
  static const Color focus = Color(0xFF3B82F6);
  static const Color selected = Color(0xFFDBEAFE);

  // Status Background - 状态背景
  static const Color successBg = Color(0xFFD1FAE5);
  static const Color warningBg = Color(0xFFFEF3C7);
  static const Color errorBg = Color(0xFFFEE2E2);
  static const Color infoBg = Color(0xFFDBEAFE);
}

/// 深色模式颜色 (OLED 友好)
class DarkColors {
  DarkColors._();

  // Background - 背景色
  static const Color background = Color(0xFF0F0F0F);
  static const Color surface = Color(0xFF1A1A1A);
  static const Color surfaceVariant = Color(0xFF242424);
  static const Color surfaceElevated = Color(0xFF2E2E2E);

  // Text - 文字色
  static const Color textPrimary = Color(0xFFF3F4F6);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textTertiary = Color(0xFF6B7280);
  static const Color textDisabled = Color(0xFF4B5563);
  static const Color textInverse = Color(0xFF1F2937);

  // Border - 边框色
  static const Color border = Color(0xFF2E2E30);
  static const Color borderLight = Color(0xFF3A3A3C);
  static const Color borderStrong = Color(0xFF4B5563);

  // Interactive - 交互色
  static const Color hover = Color(0xFF2E2E30);
  static const Color pressed = Color(0xFF3A3A3C);
  static const Color focus = Color(0xFF60A5FA);
  static const Color selected = Color(0xFF1E3A5F);

  // Status Background - 状态背景
  static const Color successBg = Color(0xFF064E3B);
  static const Color warningBg = Color(0xFF78350F);
  static const Color errorBg = Color(0xFF7F1D1D);
  static const Color infoBg = Color(0xFF1E3A5F);
}

/// 颜色扩展
extension ColorSchemeExtension on ColorScheme {
  // 获取当前主题的颜色
  Color get surfaceVariant =>
      brightness == Brightness.light
          ? LightColors.surfaceVariant
          : DarkColors.surfaceVariant;

  Color get surfaceElevated =>
      brightness == Brightness.light
          ? LightColors.surfaceElevated
          : DarkColors.surfaceElevated;

  Color get textTertiary =>
      brightness == Brightness.light
          ? LightColors.textTertiary
          : DarkColors.textTertiary;

  Color get textDisabled =>
      brightness == Brightness.light
          ? LightColors.textDisabled
          : DarkColors.textDisabled;

  Color get borderLight =>
      brightness == Brightness.light
          ? LightColors.borderLight
          : DarkColors.borderLight;

  Color get borderStrong =>
      brightness == Brightness.light
          ? LightColors.borderStrong
          : DarkColors.borderStrong;
}

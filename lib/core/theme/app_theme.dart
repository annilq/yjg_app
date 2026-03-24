import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppTheme {
  // ── Brand Colors ────────────────────────────────────────────────
  static const Color primaryColor = Color(0xFF3B82F6);
  static const Color primaryColorDark = Color(0xFF60A5FA); // dark mode 专用
  static const Color secondaryColor = Color(0xFF10B981);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color errorColor = Color(0xFFEF4444);

  // ── Light palette ───────────────────────────────────────────────
  static const Color lightGray = Color(0xFFF3F4F6);
  static const Color mediumGray = Color(0xFF9CA3AF);
  static const Color darkGray = Color(0xFF1F2937);
  static const Color white = Color(0xFFFFFFFF);

  // ── Dark palette ────────────────────────────────────────────────
  // Material 3 OLED-friendly dark palette
  static const Color darkBackground = Color(0xFF000000);      // 纯黑背景
  static const Color darkSurface      = Color(0xFF121212);     // surface 层
  static const Color darkSurface2     = Color(0xFF1C1C1E);     // elevated surface
  static const Color darkCard         = Color(0xFF1F1F1F);     // card/container
  static const Color darkBorder       = Color(0xFF2E2E30);     // 边框
  static const Color darkBorderLight  = Color(0xFF3A3A3C);     // 浅边框
  static const Color darkTextPrimary  = Color(0xFFE5E7EB);      // 主要文字
  static const Color darkTextSecondary = Color(0xFF9CA3AF);    // 次要文字

  // ── Shared constants ────────────────────────────────────────────
  static const double cardBorderRadius = 12.0;
  static const double cardPadding = 16.0;
  static const double cardMargin = 16.0;

  static const BoxShadow cardShadow = BoxShadow(
    color: Color(0x10000000),
    blurRadius: 8.0,
    spreadRadius: 0.0,
    offset: Offset(0, 2),
  );

  static const BoxShadow darkCardShadow = BoxShadow(
    color: Color(0x00000000), // dark mode 不使用阴影，用边框代替
    blurRadius: 0,
    spreadRadius: 0,
    offset: Offset.zero,
  );

  // ── Text Styles (light) ──────────────────────────────────────────
  static const TextStyle titleStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: darkGray,
  );
  static const TextStyle bodyStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: darkGray,
  );
  static const TextStyle smallStyle = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: mediumGray,
  );

  // ── Text Styles (dark) ───────────────────────────────────────────
  static const TextStyle darkTitleStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: darkTextPrimary,
  );
  static const TextStyle darkBodyStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: darkTextPrimary,
  );
  static const TextStyle darkSmallStyle = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: darkTextSecondary,
  );

  // ── lightThemeData ───────────────────────────────────────────────
  static ThemeData get lightThemeData {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        onPrimary: white,
        secondary: secondaryColor,
        onSecondary: white,
        error: errorColor,
        surface: white,
        onSurface: darkGray,
        onSurfaceVariant: mediumGray,
        outline: const Color(0xFFE5E7EB),
        outlineVariant: const Color(0xFFF3F4F6),
        surfaceContainerHighest: lightGray,
      ),
      scaffoldBackgroundColor: const Color(0xFFF5F7FA), // 页面背景略灰蓝
      cardColor: white,
      dividerColor: const Color(0xFFE5E7EB),
      textTheme: const TextTheme(
        titleLarge: titleStyle,
        bodyMedium: bodyStyle,
        bodySmall: smallStyle,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: white,
        foregroundColor: darkGray,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 17.0, fontWeight: FontWeight.w600, color: darkGray,
        ),
        iconTheme: IconThemeData(color: darkGray),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: white,
        selectedItemColor: primaryColor,
        unselectedItemColor: mediumGray,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
      cardTheme: CardThemeData(
        color: white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardBorderRadius),
          side: BorderSide(color: const Color(0xFFE5E7EB), width: 1),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        tileColor: white,
        iconColor: darkGray,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorColor),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) =>
          states.contains(WidgetState.selected) ? primaryColor : mediumGray),
        trackColor: WidgetStateProperty.resolveWith((states) =>
          states.contains(WidgetState.selected)
            ? primaryColor.withAlpha(102) : const Color(0xFFE5E7EB)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: darkGray,
        contentTextStyle: const TextStyle(color: white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFE5E7EB),
        thickness: 1,
        space: 0,
      ),
    );
  }

  // ── darkThemeData ────────────────────────────────────────────────
  static ThemeData get darkThemeData {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColorDark,
      colorScheme: ColorScheme.dark(
        primary: primaryColorDark,
        onPrimary: darkBackground,
        secondary: secondaryColor,
        onSecondary: white,
        error: errorColor,
        surface: darkSurface,
        onSurface: darkTextPrimary,
        onSurfaceVariant: darkTextSecondary,
        outline: darkBorder,
        outlineVariant: darkBorderLight,
        surfaceContainerHighest: darkCard,
      ),
      scaffoldBackgroundColor: darkBackground,
      cardColor: darkCard,
      dividerColor: darkBorder,
      textTheme: const TextTheme(
        titleLarge: darkTitleStyle,
        bodyMedium: darkBodyStyle,
        bodySmall: darkSmallStyle,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkSurface,
        foregroundColor: darkTextPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 17.0, fontWeight: FontWeight.w600, color: darkTextPrimary,
        ),
        iconTheme: IconThemeData(color: darkTextPrimary),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkSurface,
        selectedItemColor: primaryColorDark,
        unselectedItemColor: darkTextSecondary,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
      cardTheme: CardThemeData(
        color: darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardBorderRadius),
          side: const BorderSide(color: darkBorder, width: 1),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        tileColor: darkCard,
        iconColor: darkTextPrimary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColorDark, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorColor),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) =>
          states.contains(WidgetState.selected) ? primaryColorDark : darkTextSecondary),
        trackColor: WidgetStateProperty.resolveWith((states) =>
          states.contains(WidgetState.selected)
            ? primaryColorDark.withAlpha(102) : darkBorder),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColorDark,
          foregroundColor: darkBackground,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColorDark,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: darkCard,
        contentTextStyle: const TextStyle(color: darkTextPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: darkBorder),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: darkSurface2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      dividerTheme: const DividerThemeData(
        color: darkBorder,
        thickness: 1,
        space: 0,
      ),
    );
  }

  // ── 兼容旧代码 ───────────────────────────────────────────────────
  static ThemeData get themeData => lightThemeData;

  // ── Cupertino ────────────────────────────────────────────────────
  static CupertinoThemeData get cupertinoThemeData => CupertinoThemeData(
    primaryColor: primaryColor,
    primaryContrastingColor: secondaryColor,
    scaffoldBackgroundColor: white,
    textTheme: const CupertinoTextThemeData(
      navTitleTextStyle: titleStyle,
      textStyle: bodyStyle,
      actionTextStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: primaryColor),
    ),
  );

  static CupertinoThemeData get darkCupertinoThemeData => const CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColorDark,
    scaffoldBackgroundColor: darkBackground,
    textTheme: CupertinoTextThemeData(
      navTitleTextStyle: darkTitleStyle,
      textStyle: darkBodyStyle,
      actionTextStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: primaryColorDark),
    ),
  );

  // ── Card helpers（dark mode 用边框，light mode 用阴影）──────────
  static Widget cardContainer({
    required Widget child,
    EdgeInsets padding = const EdgeInsets.all(cardPadding),
    EdgeInsets margin = const EdgeInsets.all(cardMargin),
    Color? color,
    bool isDark = false,
  }) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? (isDark ? darkCard : white),
        borderRadius: BorderRadius.circular(cardBorderRadius),
        boxShadow: [isDark ? darkCardShadow : cardShadow],
        border: isDark ? Border.all(color: darkBorder, width: 1) : null,
      ),
      child: child,
    );
  }

  static Widget cardWithTap({
    required Widget child,
    required VoidCallback onTap,
    EdgeInsets padding = const EdgeInsets.all(cardPadding),
    EdgeInsets margin = const EdgeInsets.all(cardMargin),
    Color? color,
    bool isDark = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(cursor: SystemMouseCursors.click, child: cardContainer(
        child: child, padding: padding, margin: margin, color: color, isDark: isDark,
      )),
    );
  }
}

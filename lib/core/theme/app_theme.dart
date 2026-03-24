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
  static const Color darkBackground = Color(0xFF0D0D0D);      // 不再纯黑，避免刺眼
  static const Color darkSurface      = Color(0xFF181818);     // surface 层
  static const Color darkSurface2     = Color(0xFF222222);     // elevated surface
  static const Color darkCard         = Color(0xFF1C1C1E);     // card/container
  static const Color darkBorder       = Color(0xFF2E2E30);     // 边框
  static const Color darkBorderLight  = Color(0xFF3A3A3C);     // 浅边框
  static const Color darkTextPrimary  = Color(0xFFE5E7EB);      // 主要文字
  static const Color darkTextSecondary = Color(0xFF9CA3AF);    // 次要文字

  // ── Flat Design ──────────────────────────────────────────────
  // 无阴影，通过边框和背景色差区分层次
  static const double flatRadius = 8.0;
  static const double flatRadiusLg = 12.0;
  static const double flatPadding = 16.0;
  static const double flatPaddingSm = 12.0;

  // light 边框色
  static const Color flatBorder = Color(0xFFE8E8E8);
  static const Color flatBorderLight = Color(0xFFF0F0F0);

  // dark 边框色
  static const Color flatBorderDark = Color(0xFF2E2E30);

  // ── Shared constants ────────────────────────────────────────────
  // Flat Design: 所有圆角统一使用 flatRadius = 8.0
  static const double cardBorderRadius = flatRadius;
  static const double cardPadding = flatPadding;
  static const double cardMargin = 16.0;

  // Flat Design: 移除阴影，使用边框
  static const BoxShadow cardShadow = BoxShadow(
    color: Color(0x00000000), // flat design: 无阴影
    blurRadius: 0,
    spreadRadius: 0,
    offset: Offset.zero,
  );

  static const BoxShadow darkCardShadow = BoxShadow(
    color: Color(0x00000000), // flat design: 无阴影
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
      scaffoldBackgroundColor: white, // Flat Design: 纯白背景
      cardColor: white,
      dividerColor: flatBorder, // Flat Design: #E8E8E8
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
          side: const BorderSide(color: flatBorder, width: 1),
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
          borderRadius: BorderRadius.circular(flatRadius),
          borderSide: const BorderSide(color: flatBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(flatRadius),
          borderSide: const BorderSide(color: flatBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(flatRadius),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(flatRadius),
          borderSide: const BorderSide(color: errorColor),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(flatRadius),
            side: const BorderSide(color: Colors.transparent),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
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
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(flatRadius),
          side: BorderSide(color: flatBorder.withValues(alpha: 0.5), width: 0.5),
        ),
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
      scaffoldBackgroundColor: darkBackground, // Flat Design: #0D0D0D
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
          borderRadius: BorderRadius.circular(flatRadius),
          borderSide: const BorderSide(color: darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(flatRadius),
          borderSide: const BorderSide(color: darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(flatRadius),
          borderSide: const BorderSide(color: primaryColorDark, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(flatRadius),
          borderSide: const BorderSide(color: errorColor),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(flatRadius),
            side: const BorderSide(color: Colors.transparent),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
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

  // Flat button style（边框型按钮，用于 secondary actions）
  static ButtonStyle flatButtonStyle(Color color, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: isDark ? darkBorder : lightGray,
      foregroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(flatRadius),
        side: BorderSide(color: isDark ? darkBorder : lightGray),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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

  // ── Card helpers（Flat Design: 用边框，无阴影）──────────
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

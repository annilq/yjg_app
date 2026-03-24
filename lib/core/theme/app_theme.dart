import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppTheme {
  // ── Brand Colors ──────────────────────────────────────────────
  static const Color primaryColor = Color(0xFF3B82F6);
  static const Color secondaryColor = Color(0xFF10B981);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color errorColor = Color(0xFFEF4444);

  // ── Light palette ─────────────────────────────────────────────
  static const Color lightGray = Color(0xFFF3F4F6);
  static const Color mediumGray = Color(0xFF9CA3AF);
  static const Color darkGray = Color(0xFF1F2937);
  static const Color white = Color(0xFFFFFFFF);

  // ── Dark palette ──────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkCard = Color(0xFF2C2C2C);
  static const Color darkTextPrimary = Color(0xFFE5E7EB);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);

  // ── Shared ────────────────────────────────────────────────────
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
    color: Color(0x40000000),
    blurRadius: 8.0,
    spreadRadius: 0.0,
    offset: Offset(0, 2),
  );

  // ── Text Styles (light) ───────────────────────────────────────
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

  // ── Text Styles (dark) ────────────────────────────────────────
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

  // ── ThemeData: Light ──────────────────────────────────────────
  static ThemeData get lightThemeData {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        error: errorColor,
        surface: white,
        onPrimary: white,
        onSecondary: white,
        onSurface: darkGray,
      ),
      scaffoldBackgroundColor: lightGray,
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
          fontSize: 17.0,
          fontWeight: FontWeight.w600,
          color: darkGray,
        ),
        iconTheme: IconThemeData(color: darkGray),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: white,
        selectedItemColor: primaryColor,
        unselectedItemColor: mediumGray,
        elevation: 8,
      ),
      listTileTheme: const ListTileThemeData(
        tileColor: white,
        iconColor: darkGray,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? primaryColor : mediumGray,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? primaryColor.withOpacity(0.4)
              : const Color(0xFFE5E7EB),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  // ── ThemeData: Dark ───────────────────────────────────────────
  static ThemeData get darkThemeData {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        error: errorColor,
        surface: darkSurface,
        onPrimary: white,
        onSecondary: white,
        onSurface: darkTextPrimary,
      ),
      scaffoldBackgroundColor: darkBackground,
      cardColor: darkCard,
      dividerColor: const Color(0xFF374151),
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
          fontSize: 17.0,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
        ),
        iconTheme: IconThemeData(color: darkTextPrimary),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkSurface,
        selectedItemColor: primaryColor,
        unselectedItemColor: darkTextSecondary,
        elevation: 8,
      ),
      listTileTheme: const ListTileThemeData(
        tileColor: darkCard,
        iconColor: darkTextPrimary,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? primaryColor : darkTextSecondary,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? primaryColor.withOpacity(0.4)
              : const Color(0xFF374151),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  // ── 兼容旧代码的 getter（默认返回 light）─────────────────────
  static ThemeData get themeData => lightThemeData;

  // ── CupertinoThemeData ────────────────────────────────────────
  static CupertinoThemeData get cupertinoThemeData {
    return CupertinoThemeData(
      primaryColor: primaryColor,
      primaryContrastingColor: secondaryColor,
      scaffoldBackgroundColor: white,
      textTheme: CupertinoTextThemeData(
        navTitleTextStyle: titleStyle,
        textStyle: bodyStyle,
        actionTextStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: primaryColor,
        ),
      ),
    );
  }

  static CupertinoThemeData get darkCupertinoThemeData {
    return const CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      primaryContrastingColor: secondaryColor,
      scaffoldBackgroundColor: darkBackground,
      textTheme: CupertinoTextThemeData(
        navTitleTextStyle: darkTitleStyle,
        textStyle: darkBodyStyle,
        actionTextStyle: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: primaryColor,
        ),
      ),
    );
  }

  // ── Card helpers ──────────────────────────────────────────────
  static Widget cardContainer({
    required Widget child,
    EdgeInsets padding = const EdgeInsets.all(cardPadding),
    EdgeInsets margin = const EdgeInsets.all(cardMargin),
    Color? color,
    bool isDark = false,
  }) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? (isDark ? darkCard : white),
        borderRadius: BorderRadius.circular(cardBorderRadius),
        boxShadow: [isDark ? darkCardShadow : cardShadow],
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
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: cardContainer(
          child: child,
          padding: padding,
          margin: margin,
          color: color,
          isDark: isDark,
        ),
      ),
    );
  }
}

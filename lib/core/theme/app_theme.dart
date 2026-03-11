import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF3B82F6);
  static const Color secondaryColor = Color(0xFF10B981);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color errorColor = Color(0xFFEF4444);

  static const Color lightGray = Color(0xFFF3F4F6);
  static const Color mediumGray = Color(0xFF9CA3AF);
  static const Color darkGray = Color(0xFF1F2937);
  static const Color white = Color(0xFFFFFFFF);

  static const double cardBorderRadius = 12.0;
  static const double cardPadding = 16.0;
  static const double cardMargin = 16.0;

  static const BoxShadow cardShadow = BoxShadow(
    color: Color(0x10000000),
    blurRadius: 8.0,
    spreadRadius: 0.0,
    offset: Offset(0, 2),
  );

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

  static ThemeData get themeData {
    return ThemeData(
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: secondaryColor),
      scaffoldBackgroundColor: white,
      textTheme: TextTheme(
        titleLarge: titleStyle,
        bodyMedium: bodyStyle,
        bodySmall: smallStyle,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  static CupertinoThemeData get cupertinoThemeData {
    return CupertinoThemeData(
      primaryColor: primaryColor,
      primaryContrastingColor: secondaryColor,
      scaffoldBackgroundColor: white,
      textTheme: CupertinoTextThemeData(
        navTitleTextStyle: titleStyle,
        textStyle: bodyStyle,
        actionTextStyle: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: primaryColor,
        ),
      ),
    );
  }

  static Widget cardContainer({
    required Widget child,
    EdgeInsets padding = const EdgeInsets.all(cardPadding),
    EdgeInsets margin = const EdgeInsets.all(cardMargin),
  }) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        boxShadow: [cardShadow],
      ),
      child: child,
    );
  }

  static Widget cardWithTap({
    required Widget child,
    required VoidCallback onTap,
    EdgeInsets padding = const EdgeInsets.all(cardPadding),
    EdgeInsets margin = const EdgeInsets.all(cardMargin),
  }) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: cardContainer(
          child: child,
          padding: padding,
          margin: margin,
        ),
      ),
    );
  }
}

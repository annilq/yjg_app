import 'package:flutter/material.dart';
import '../theme/theme.dart';

class TextButtonCustom extends TextButton {
  TextButtonCustom({
    super.key,
    required super.onPressed,
    Widget? child,
    String? text,
    ButtonStyle? style,
    super.focusNode,
    super.autofocus,
    super.clipBehavior = Clip.none,
  }) : super(
          style: _defaultStyle.merge(style),
          child: child ?? (text != null ? Text(text) : SizedBox()),
        );

  static ButtonStyle get _defaultStyle {
    return TextButton.styleFrom(
      foregroundColor: AppTheme.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      textStyle: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
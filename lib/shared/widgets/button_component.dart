import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class ButtonComponent extends ElevatedButton {
  ButtonComponent({
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
          child: child ?? (text != null ? Text(text) : null),
        );

  static ButtonStyle get _defaultStyle {
    return ElevatedButton.styleFrom(
      backgroundColor: AppTheme.primaryColor,
      foregroundColor: AppTheme.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      textStyle: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

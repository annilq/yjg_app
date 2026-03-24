import 'package:flutter/material.dart';

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
          style: style?.merge(_defaultStyle) ?? _defaultStyle,
          child: child ?? (text != null ? Text(text) : null),
        );

  static ButtonStyle get _defaultStyle {
    return ElevatedButton.styleFrom(
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
      textStyle: const TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TextButtonComponent extends TextButton {
  TextButtonComponent({
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
          child: child ?? (text != null ? Text(text) : const SizedBox()),
        );

  static ButtonStyle get _defaultStyle {
    return TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      textStyle: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}

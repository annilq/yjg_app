import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class TextFormFieldComponent extends TextFormField {
  TextFormFieldComponent({
    super.key,
    super.controller,
    super.initialValue,
    super.focusNode,
    InputDecoration? decoration,
    super.keyboardType,
    super.textInputAction,
    TextStyle? style,
    super.textDirection,
    super.textAlign = TextAlign.start,
    super.textAlignVertical,
    super.autofocus = false,
    super.readOnly = false,
    super.showCursor,
    super.obscureText = false,
    super.obscuringCharacter = '•',
    super.autocorrect = true,
    super.smartDashesType,
    super.smartQuotesType,
    super.enableSuggestions = true,
    super.maxLengthEnforcement,
    super.maxLines = 1,
    super.minLines,
    super.expands = false,
    super.maxLength,
    super.onChanged,
    super.onTap,
    super.onTapOutside,
    super.onEditingComplete,
    super.onFieldSubmitted,
    super.onSaved,
    super.validator,
    super.inputFormatters,
    super.enabled,
    super.cursorWidth = 2.0,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorColor,
    super.keyboardAppearance,
    super.scrollPadding = const EdgeInsets.all(20.0),
    super.enableInteractiveSelection = true,
    super.selectionControls,
    super.buildCounter,
    super.scrollPhysics,
    super.autofillHints,
    super.autovalidateMode,
    super.restorationId,
    super.enableIMEPersonalizedLearning = true,
  }) : super(
          decoration: decoration ?? _defaultDecoration,
          style: style ?? AppTheme.bodyStyle,
        );

  static InputDecoration get _defaultDecoration {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppTheme.mediumGray, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppTheme.primaryColor, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppTheme.mediumGray, width: 1.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppTheme.errorColor, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppTheme.errorColor, width: 2.0),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      hintStyle: TextStyle(color: AppTheme.mediumGray),
      errorStyle: TextStyle(color: AppTheme.errorColor, fontSize: 12.0),
    );
  }
}

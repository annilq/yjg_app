import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';

/// Flat Design 风格的文字按钮组件
///
/// 特点：
/// - 无背景，纯文字样式
/// - 支持加载状态
/// - 统一字体样式
class TextButtonComponent extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  const TextButtonComponent({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.color,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveColor = color ?? colorScheme.primary;

    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: effectiveColor,
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        minimumSize: Size(64, 36),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: isLoading
          ? SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
              ),
            )
          : Text(
              text,
              style: AppTypography.labelLarge.copyWith(
                color: effectiveColor,
                fontSize: fontSize,
                fontWeight: fontWeight ?? AppTypography.weightMedium,
              ),
            ),
    );
  }
}

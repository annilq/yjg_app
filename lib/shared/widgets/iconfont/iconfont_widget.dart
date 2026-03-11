import 'package:flutter/material.dart';

class IconFontWidget extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color? color;

  const IconFontWidget({
    super.key,
    required this.icon,
    this.size = 16.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}

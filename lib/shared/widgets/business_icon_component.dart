import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_theme.dart';
import 'package:flutter_app/core/utils/util.dart';
import 'package:flutter_app/shared/widgets/index.dart';

class BusinessIcon extends StatelessWidget {
  final String formKey;
  final double size;

  const BusinessIcon({
    super.key,
    required this.formKey,
    this.size = 56,
  });

  Widget _buildIcon() {
    String iconName = Util.getFlowIcon(formKey);
    
    // 处理图标名称格式
    if (iconName.startsWith('icon-')) {
      iconName = iconName.substring(5);
    } else if (iconName.startsWith('icon_')) {
      iconName = iconName.replaceFirst('icon_', '');
    }
    
    try {
      return IconFontWidget(
        icon: IconFont.getIcon(iconName),
        color: AppTheme.white,
        size: size * 0.43, // 保持图标大小与容器比例一致
      );
    } catch (e) {
      // 如果图标不存在，使用默认图标
      return IconFontWidget(
        icon: IconFont.getIcon('a-108-tongyongtubiao'),
        color: AppTheme.white,
        size: size * 0.43,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Color moduleColor = Util.getModuleColor(formKey);
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: moduleColor,
        borderRadius: BorderRadius.circular(8), // Flat Design: 8px 圆角
      ),
      child: _buildIcon(),
    );
  }
}

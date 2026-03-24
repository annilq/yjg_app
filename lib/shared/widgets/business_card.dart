import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';
import 'package:flutter_app/shared/widgets/index.dart';
import 'package:flutter_app/core/utils/util.dart';

/// 业务卡片组件 - Flat Design 风格
class BusinessCard extends StatelessWidget {
  final dynamic item;
  final bool editMode;
  final bool isInUserList;
  final VoidCallback onTap;

  const BusinessCard({
    super.key,
    required this.item,
    required this.editMode,
    required this.isInUserList,
    required this.onTap,
  });

  Widget _buildIcon() {
    String formKey = item['img'] ?? '';
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
        color: AppColors.white,
        size: 24,
      );
    } catch (e) {
      // 如果图标不存在，使用默认图标
      return IconFontWidget(
        icon: IconFont.getIcon('a-108-tongyongtubiao'),
        color: AppColors.white,
        size: 24,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    String formKey = item['img'] ?? '';
    Color moduleColor = Util.getModuleColor(formKey);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: moduleColor,
                  borderRadius: AppRadius.allMd,
                ),
                child: _buildIcon(),
              ),
              if (editMode)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Icon(
                    isInUserList ? CupertinoIcons.delete : CupertinoIcons.add,
                    color: isInUserList ? colorScheme.error : colorScheme.primary,
                    size: 16,
                  ),
                ),
            ],
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            item['text'] ?? '',
            style: AppTypography.bodySmall.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

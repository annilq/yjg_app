import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/shared/widgets/card_item_component.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class NoticeItemWidget extends StatelessWidget {
  final dynamic item;
  final VoidCallback? onTap;

  const NoticeItemWidget({
    super.key,
    required this.item,
    this.onTap,
  });

  IconData _getIconByType(String type) {
    switch (type) {
      case 'approval':
        return CupertinoIcons.checkmark_circle;
      case 'task':
        return CupertinoIcons.bell;
      case 'system':
        return CupertinoIcons.info_circle;
      default:
        return CupertinoIcons.bell;
    }
  }

  Color _getColorByType(String type) {
    switch (type) {
      case 'approval':
        return AppTheme.primaryColor;
      case 'task':
        return Colors.orange;
      case 'system':
        return AppTheme.secondaryColor;
      default:
        return AppTheme.mediumGray;
    }
  }

  @override
  Widget build(BuildContext context) {
    final type = item['type'] ?? 'default';
    final color = _getColorByType(type);
    
    final customIcon = Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        _getIconByType(type),
        color: color,
        size: 20,
      ),
    );

    Widget? footer;
    if (item['time'] != null || item['content'] != null) {
      footer = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item['time'] != null)
            Text(
              item['time'] ?? '',
              style: AppTheme.smallStyle,
            ),
          if (item['content'] != null) ...[
            const SizedBox(height: 4),
            Text(
              item['content'] ?? '',
              style: AppTheme.bodyStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      );
    }

    return CardItemComponent(
      icon: customIcon,
      title: item['title'] ?? '无标题',
      footer: footer,
      onTap: onTap ?? () {},
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}

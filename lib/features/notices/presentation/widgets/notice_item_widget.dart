import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/shared/widgets/card_item_component.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class NoticeItemWidget extends StatelessWidget {
  final dynamic item;

  const NoticeItemWidget({
    super.key,
    required this.item,
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
        return Colors.blue;
      case 'task':
        return Colors.orange;
      case 'system':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final type = item['type'] ?? 'default';
    
    final customIcon = Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: _getColorByType(type).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        _getIconByType(type),
        color: _getColorByType(type),
        size: 20,
      ),
    );

    Widget header = Row(
      children: [
        customIcon,
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            item['title'] ?? '无标题',
            style: AppTheme.titleStyle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (item['count'] != null && item['count'] > 0)
          CardItemComponent.countBadge(item['count']),
      ],
    );

    return AppTheme.cardWithTap(
      onTap: () {
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header,
          if (item['time'] != null)
            const SizedBox(height: 8),
          if (item['time'] != null)
            Text(
              item['time'] ?? '',
              style: AppTheme.smallStyle,
            ),
          if (item['content'] != null)
            const SizedBox(height: 8),
          if (item['content'] != null)
            Text(
              item['content'] ?? '',
              style: AppTheme.bodyStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}

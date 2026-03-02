import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/theme/theme.dart';

class NoticeItemComponent extends StatelessWidget {
  final dynamic item;

  const NoticeItemComponent({
    Key? key,
    required this.item,
  }) : super(key: key);

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
    return AppTheme.cardWithTap(
      onTap: () {
        // 处理通知点击
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getColorByType(item['type'] ?? 'default').withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getIconByType(item['type'] ?? 'default'),
                  color: _getColorByType(item['type'] ?? 'default'),
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  item['title'] ?? '无标题',
                  style: AppTheme.titleStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (item['count'] != null && item['count'] > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.errorColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${item['count'] ?? 1}',
                    style: TextStyle(
                      color: AppTheme.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8),
          if (item['time'] != null)
            Text(
              item['time'] ?? '',
              style: AppTheme.smallStyle,
            ),
          SizedBox(height: 8),
          if (item['content'] != null)
            Text(
              item['content'] ?? '',
              style: AppTheme.bodyStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
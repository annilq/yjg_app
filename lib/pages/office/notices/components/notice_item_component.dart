import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getIconByType(item['type'] ?? 'default'),
                  color: _getColorByType(item['type'] ?? 'default'),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item['title'] ?? '无标题',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '1', // 假设每个提醒数量为1，实际项目中应该从数据中获取
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            if (item['time'] != null)
              Text(
                item['time'] ?? '',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            SizedBox(height: 8),
            if (item['content'] != null)
              Text(
                item['content'] ?? '',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}
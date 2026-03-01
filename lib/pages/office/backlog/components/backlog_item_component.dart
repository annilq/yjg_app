import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BacklogItemComponent extends StatelessWidget {
  final dynamic item;

  const BacklogItemComponent({
    Key? key,
    required this.item,
  }) : super(key: key);

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
                  CupertinoIcons.doc_text,
                  color: Theme.of(context).primaryColor,
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
              ],
            ),
            SizedBox(height: 8),
            if (item['createTime'] != null)
              Text(
                '创建时间: ${item['createTime']}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            SizedBox(height: 8),
            if (item['description'] != null)
              Text(
                item['description'] ?? '',
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

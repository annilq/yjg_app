import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/theme/theme.dart';

class RelatedToMeItemComponent extends StatelessWidget {
  final dynamic item;

  const RelatedToMeItemComponent({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTheme.cardWithTap(
      onTap: () {
        // 处理相关事项点击
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
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  CupertinoIcons.doc_text,
                  color: AppTheme.primaryColor,
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
            ],
          ),
          SizedBox(height: 8),
          if (item['createTime'] != null)
            Text(
              '创建时间: ${item['createTime']}',
              style: AppTheme.smallStyle,
            ),
          SizedBox(height: 8),
          if (item['description'] != null)
            Text(
              item['description'] ?? '',
              style: AppTheme.bodyStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          SizedBox(height: 8),
          // 添加状态标签
          if (item['status'] != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: item['status'] == 'pending' 
                    ? AppTheme.warningColor.withOpacity(0.1) 
                    : item['status'] == 'completed' 
                      ? AppTheme.secondaryColor.withOpacity(0.1)
                      : AppTheme.lightGray,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                item['status'] == 'pending' ? '待处理' : 
                item['status'] == 'completed' ? '已完成' : '进行中',
                style: TextStyle(
                  fontSize: 12,
                  color: item['status'] == 'pending' 
                    ? AppTheme.warningColor 
                    : item['status'] == 'completed' 
                      ? AppTheme.secondaryColor
                      : AppTheme.mediumGray,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}

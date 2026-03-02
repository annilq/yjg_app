import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/theme/theme.dart';

class CardItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final String? subtitle;
  final String? content;
  final Widget? footer;
  final VoidCallback onTap;
  final EdgeInsets margin;

  const CardItem({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.content,
    this.footer,
    required this.onTap,
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTheme.cardWithTap(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              icon,
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: AppTheme.titleStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (subtitle != null) ...[
            SizedBox(height: 8),
            Text(
              subtitle!,
              style: AppTheme.smallStyle,
            ),
          ],
          if (content != null) ...[
            SizedBox(height: 8),
            Text(
              content!,
              style: AppTheme.bodyStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          if (footer != null) ...[
            SizedBox(height: 8),
            footer!,
          ],
        ],
      ),
      margin: margin,
    );
  }

  // 快捷方法：创建带图标的容器
  static Widget iconContainer({
    required IconData icon,
    required Color color,
    double size = 20,
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }

  // 快捷方法：创建计数标签
  static Widget countBadge(int count) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppTheme.errorColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '$count',
        style: TextStyle(
          color: AppTheme.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // 快捷方法：创建状态标签
  static Widget statusBadge(String status) {
    Color color;
    String text;

    switch (status) {
      case 'pending':
        color = AppTheme.warningColor;
        text = '待处理';
        break;
      case 'completed':
        color = AppTheme.secondaryColor;
        text = '已完成';
        break;
      default:
        color = AppTheme.mediumGray;
        text = '进行中';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

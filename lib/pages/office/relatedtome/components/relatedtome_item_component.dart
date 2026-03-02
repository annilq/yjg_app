import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/components/card_item.dart';
import 'package:flutter_app/theme/theme.dart';

class RelatedToMeItemComponent extends StatelessWidget {
  final dynamic item;

  const RelatedToMeItemComponent({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 创建图标
    final icon = CardItem.iconContainer(
      icon: CupertinoIcons.doc_text,
      color: AppTheme.primaryColor,
    );

    // 创建状态标签
    Widget? footer;
    if (item['status'] != null) {
      footer = CardItem.statusBadge(item['status']);
    }

    return CardItem(
      icon: icon,
      title: item['title'] ?? '无标题',
      subtitle: item['createTime'] != null ? '创建时间: ${item['createTime']}' : null,
      content: item['description'],
      footer: footer,
      onTap: () {
        // 处理相关事项点击
      },
    );
  }
}

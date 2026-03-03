import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/shared/widgets/card_item_component.dart';
import 'package:flutter_app/theme/theme.dart';

class RelatedToMeItemWidget extends StatelessWidget {
  final dynamic item;

  const RelatedToMeItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final icon = CardItemComponent.iconContainer(
      icon: CupertinoIcons.doc_text,
      color: AppTheme.primaryColor,
    );

    Widget? footer;
    if (item['status'] != null) {
      footer = CardItemComponent.statusBadge(item['status']);
    }

    return CardItemComponent(
      icon: icon,
      title: item['title'] ?? '无标题',
      subtitle: item['createTime'] != null ? '创建时间: ${item['createTime']}' : null,
      content: item['description'],
      footer: footer,
      onTap: () {
      },
    );
  }
}

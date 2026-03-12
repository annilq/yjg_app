import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/shared/widgets/card_item_component.dart';
import 'package:flutter_app/features/notices/models/notice_model.dart';

class NoticeItemWidget extends StatelessWidget {
  final NoticeModel item;
  final VoidCallback? onTap;

  const NoticeItemWidget({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {

    return CardItemComponent(
      formKey:  item.id,
      status: item.isRead ? '已读' : '未读',
      title: item.title,
      onTap: onTap ?? () {},
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}

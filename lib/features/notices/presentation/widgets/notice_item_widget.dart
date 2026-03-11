import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/shared/widgets/card_item_component.dart';

class NoticeItemWidget extends StatelessWidget {
  final dynamic item;
  final VoidCallback? onTap;

  const NoticeItemWidget({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {

    return CardItemComponent(
      formKey: item['formKey'] ?? '',
      status: item['status']?.toString(),
      title: item['title'] ?? '无标题',
      onTap: onTap ?? () {},
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}

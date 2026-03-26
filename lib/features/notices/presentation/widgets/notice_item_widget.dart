import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/theme/tokens/app_spacing.dart';
import 'package:flutter_app/shared/widgets/card_item_component.dart';
import 'package:flutter_app/features/notices/models/notice_model.dart';

class NoticeItemWidget extends StatelessWidget {
  final NoticeModel? item;
  final VoidCallback? onTap;

  const NoticeItemWidget({super.key, this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return CardItemComponent(
      formKey: item?.formKey ?? '',
      extra: item?.count?.toString() ?? '',
      title: item?.title ?? '',
      onTap: onTap ?? () {},
      margin: AppSpacing.listItemPadding,
    );
  }
}

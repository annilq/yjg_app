import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/core/theme/tokens/app_spacing.dart';
import 'package:flutter_app/shared/widgets/paginated_list_screen.dart';
import 'package:flutter_app/shared/widgets/card_item_component.dart';
import 'package:flutter_app/features/notices/models/notice_model.dart';
import 'package:flutter_app/features/notices/providers/notice_provider.dart';

/// 提醒列表页面
class NoticesListScreen extends ConsumerWidget {
  const NoticesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaginatedListScreen<NoticeModel, NoticeListData>(
      title: '提醒',
      provider: noticeProvider,
      extractItems: (state) => state.notices ?? [],
      onRefresh: (ref) => ref.read(noticeProvider.notifier).refresh(),
      emptyMessage: '暂无提醒',
      enableSearch: true,
      onSearch: (ref, keyword) =>
          ref.read(noticeProvider.notifier).refresh(keyword: keyword),
      itemBuilder: (context, item, index) {
        return CardItemComponent(
          formKey: item.formKey ?? '',
          extra: item.count?.toString() ?? '',
          title: item.title ?? '',
          margin: AppSpacing.listItemPadding,
          onTap: () {
            // TODO: 跳转到提醒详情
          },
        );
      },
    );
  }
}

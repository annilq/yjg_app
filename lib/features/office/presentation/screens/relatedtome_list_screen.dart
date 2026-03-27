import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/tokens/app_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/shared/widgets/paginated_list_screen.dart';
import 'package:flutter_app/shared/widgets/card_item_component.dart';
import 'package:flutter_app/features/office/models/backlog_model.dart';
import 'package:flutter_app/features/office/presentation/widgets/relatedtome_tab_widget.dart';
import 'package:flutter_app/features/office/providers/relatedtome_provider.dart';

/// 我发起的列表页面
class RelatedToMeListScreen extends ConsumerStatefulWidget {
  const RelatedToMeListScreen({super.key});

  @override
  ConsumerState<RelatedToMeListScreen> createState() => _RelatedToMeListScreenState();
}

class _RelatedToMeListScreenState extends ConsumerState<RelatedToMeListScreen> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PaginatedListScreen<BacklogItem, BacklogListData>(
      title: '我发起的',
      provider: relatedToMeProvider,
      extractItems: (state) => state.items ?? [],
      hasMore: (state) => state.hasMore ?? false,
      onRefresh: (ref) => ref.read(relatedToMeProvider.notifier).refresh(),
      onLoadMore: (ref) => ref.read(relatedToMeProvider.notifier).loadMore(),
      emptyMessage: '暂无记录',
      enableSearch: true,
      onSearch: (ref, keyword) =>
          ref.read(relatedToMeProvider.notifier).onSearch(keyword),
      tabWidget: RelatedToMeTabWidget(
        currentIndex: _currentTabIndex,
        onTabChanged: (index) {
          setState(() => _currentTabIndex = index);
          ref.read(relatedToMeProvider.notifier).onTabChanged(index);
        },
      ),
      itemBuilder: (context, item, index) {
        return CardItemComponent(
          formKey: item.id ?? '',
          status: item.status ?? '',
          title: item.title ?? '',
          extra: ' ${item.createTime ?? ''}',
          content: item.title ?? '',
          margin: AppSpacing.listItemPadding,
          onTap: () {
            // TODO: 跳转到详情
          },
        );
      },
    );
  }
}

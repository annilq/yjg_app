import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/tokens/app_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/shared/widgets/paginated_list_screen.dart';
import 'package:flutter_app/shared/widgets/card_item_component.dart';
import 'package:flutter_app/features/office/models/backlog_model.dart';
import 'package:flutter_app/features/office/presentation/widgets/backlog_tab_widget.dart';
import 'package:flutter_app/features/office/providers/backlog_provider.dart';

/// 我的待办列表页面
class BacklogListScreen extends ConsumerStatefulWidget {
  const BacklogListScreen({super.key});

  @override
  ConsumerState<BacklogListScreen> createState() => _BacklogListScreenState();
}

class _BacklogListScreenState extends ConsumerState<BacklogListScreen> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PaginatedListScreen<BacklogItem, BacklogListData>(
      title: '我的待办',
      provider: backlogProvider,
      extractItems: (state) => state.items ?? [],
      hasMore: (state) => state.hasMore ?? false,
      onRefresh: (ref) => ref.read(backlogProvider.notifier).refresh(),
      onLoadMore: (ref) => ref.read(backlogProvider.notifier).loadMore(),
      emptyMessage: '暂无待办事项',
      enableSearch: true,
      onSearch: (ref, keyword) =>
          ref.read(backlogProvider.notifier).onSearch(keyword),
      tabWidget: BacklogTabWidget(
        currentIndex: _currentTabIndex,
        onTabChanged: (index) {
          setState(() => _currentTabIndex = index);
          ref.read(backlogProvider.notifier).onTabChanged(index);
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
            // TODO: 跳转到待办详情
          },
        );
      },
    );
  }
}

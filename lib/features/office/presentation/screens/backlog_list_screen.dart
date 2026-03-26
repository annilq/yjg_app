import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/tokens/app_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/shared/widgets/card_item_component.dart';
import 'package:flutter_app/shared/widgets/app_search_delegate.dart';
import 'package:flutter_app/features/office/presentation/widgets/backlog_tab_widget.dart';
import 'package:flutter_app/features/office/providers/backlog_provider.dart';

class BacklogListScreen extends ConsumerStatefulWidget {
  const BacklogListScreen({super.key});

  @override
  ConsumerState<BacklogListScreen> createState() => _BacklogListScreenState();
}

class _BacklogListScreenState extends ConsumerState<BacklogListScreen> {
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onSearch(String keyword) {
    ref.read(backlogProvider.notifier).onSearch(keyword);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(backlogProvider);

    return Scaffold(
      appBar: AppBarComponent(
        title: '我的待办',
        showSearch: true,
        onSearchPressed: () {
          showSearch(
            context: context,
            delegate: AppSearchDelegate(_onSearch),
          );
        },
      ),
      body: Column(
        children: [
          BacklogTabWidget(
            currentIndex: _currentTabIndex,
            onTabChanged: (index) {
              _currentTabIndex = index;
              ref.read(backlogProvider.notifier).onTabChanged(index);
            },
          ),
          Expanded(
            child: state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('加载失败: $error')),
              data: (data) {
                return RefreshIndicator(
                  onRefresh: () => ref.read(backlogProvider.notifier).refresh(),
                  child: NotificationListener<ScrollEndNotification>(
                    onNotification: (notification) {
                      if (notification.metrics.pixels ==
                          notification.metrics.maxScrollExtent) {
                        ref.read(backlogProvider.notifier).loadMore();
                      }
                      return false;
                    },
                    child: ListView.builder(
                      itemCount: data.items?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = data.items?[index];
                        return CardItemComponent(
                          formKey: item?.id ?? '',
                          status: item?.status ?? '',
                          title: item?.title ?? '',
                          extra: ' ${item?.createTime ?? ''}',
                          content: item?.title ?? '',
                          margin: AppSpacing.listItemPadding,
                          onTap: () {},
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

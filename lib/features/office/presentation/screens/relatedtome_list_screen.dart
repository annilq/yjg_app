import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/tokens/app_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/shared/widgets/card_item_component.dart';
import 'package:flutter_app/shared/widgets/empty_card.dart';
import 'package:flutter_app/shared/widgets/app_search_delegate.dart';
import 'package:flutter_app/features/office/presentation/widgets/relatedtome_tab_widget.dart';
import 'package:flutter_app/features/office/providers/relatedtome_provider.dart';

class RelatedToMeListScreen extends ConsumerStatefulWidget {
  const RelatedToMeListScreen({super.key});

  @override
  ConsumerState<RelatedToMeListScreen> createState() => _RelatedToMeListScreenState();
}

class _RelatedToMeListScreenState extends ConsumerState<RelatedToMeListScreen> {
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onSearch(String keyword) {
    ref.read(relatedToMeProvider.notifier).onSearch(keyword);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(relatedToMeProvider);

    return Scaffold(
      appBar: AppBarComponent(
        title: '我发起的',
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
          RelatedToMeTabWidget(
            currentIndex: _currentTabIndex,
            onTabChanged: (index) {
              _currentTabIndex = index;
              ref.read(relatedToMeProvider.notifier).onTabChanged(index);
            },
          ),
          Expanded(
            child: state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('加载失败: $error')),
              data: (data) {
                final items = data.items ?? [];
                if (items.isEmpty) {
                  return const EmptyCard(message: '暂无记录');
                }
                return RefreshIndicator(
                  onRefresh: () => ref.read(relatedToMeProvider.notifier).refresh(),
                  child: NotificationListener<ScrollEndNotification>(
                    onNotification: (notification) {
                      if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
                        ref.read(relatedToMeProvider.notifier).loadMore();
                      }
                      return false;
                    },
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
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

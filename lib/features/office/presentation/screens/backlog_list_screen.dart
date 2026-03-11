import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(backlogProvider.notifier).loadBacklogList();
    });
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
            currentIndex: state.currentTabIndex,
            onTabChanged: (index) {
              ref.read(backlogProvider.notifier).onTabChanged(index);
            },
          ),
          Expanded(
            child: state.isLoading && state.items.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
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
                        itemCount: state.items.length,
                        itemBuilder: (context, index) {
                          final item = state.items[index];
                          return CardItemComponent(
                            formKey: item['formKey'] ?? '',
                            status: item['status']?.toString(),
                            title: item['name'] ?? '无标题',
                            extra: item['createDate'] != null ? ' ${item['createDate']}' : null,
                            content: item['title'],
                            onTap: () {},
                          );
                        },
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

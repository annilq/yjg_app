import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/shared/widgets/card_item_component.dart';
import 'package:flutter_app/shared/widgets/app_search_delegate.dart';
import 'package:flutter_app/core/theme/app_theme.dart';
import 'package:flutter_app/features/office/presentation/widgets/relatedtome_tab_widget.dart';
import 'package:flutter_app/features/office/providers/relatedtome_provider.dart';

class RelatedToMeListScreen extends ConsumerStatefulWidget {
  const RelatedToMeListScreen({super.key});

  @override
  ConsumerState<RelatedToMeListScreen> createState() => _RelatedToMeListScreenState();
}

class _RelatedToMeListScreenState extends ConsumerState<RelatedToMeListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(relatedToMeProvider.notifier).loadRelatedToMeList();
    });
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
            currentIndex: state.currentTabIndex,
            onTabChanged: (index) {
              ref.read(relatedToMeProvider.notifier).onTabChanged(index);
            },
          ),
          Expanded(
            child: state.isLoading && state.items.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: () => ref.read(relatedToMeProvider.notifier).refresh(),
                    child: NotificationListener<ScrollEndNotification>(
                      onNotification: (notification) {
                        if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
                          ref.read(relatedToMeProvider.notifier).loadMore();
                        }
                        return false;
                      },
                      child: ListView.builder(
                        itemCount: state.items.length,
                        itemBuilder: (context, index) {
                          final item = state.items[index];
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

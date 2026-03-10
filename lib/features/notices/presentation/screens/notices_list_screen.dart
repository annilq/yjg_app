import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/features/notices/presentation/widgets/notice_item_widget.dart';
import 'package:flutter_app/features/notices/providers/notice_provider.dart';

class NoticesListScreen extends ConsumerStatefulWidget {
  const NoticesListScreen({super.key});

  @override
  ConsumerState<NoticesListScreen> createState() => _NoticesListScreenState();
}

class _NoticesListScreenState extends ConsumerState<NoticesListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(noticeProvider.notifier).loadNotices();
    });
  }

  void _onSearch(String keyword) {
    ref.read(noticeProvider.notifier).loadNotices(keyword: keyword, refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final noticeState = ref.watch(noticeProvider);

    return Scaffold(
      appBar: AppBarComponent(
        title: '提醒',
        showSearch: true,
        onSearchPressed: () {
          showSearch(
            context: context,
            delegate: NoticeSearchDelegate(_onSearch),
          );
        },
      ),
      body: noticeState.isLoading && noticeState.items.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => ref.read(noticeProvider.notifier).refresh(),
              child: NotificationListener<ScrollEndNotification>(
                onNotification: (notification) {
                  if (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {
                    ref.read(noticeProvider.notifier).loadMore();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: noticeState.items.length,
                  itemBuilder: (context, index) {
                    return NoticeItemWidget(
                      item: noticeState.items[index],
                    );
                  },
                ),
              ),
            ),
    );
  }
}

class NoticeSearchDelegate extends SearchDelegate {
  final Function(String) onSearch;

  NoticeSearchDelegate(this.onSearch);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(CupertinoIcons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(CupertinoIcons.back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearch(query);
    close(context, null);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

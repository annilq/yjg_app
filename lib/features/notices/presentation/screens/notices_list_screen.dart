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
  }

  void _onSearch(String keyword) {
    ref.read(noticeProvider.notifier).refresh(keyword: keyword);
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
      body: noticeState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('加载失败: $error')),
        data: (data) {
          return RefreshIndicator(
            onRefresh: () => ref.read(noticeProvider.notifier).refresh(),
            child: ListView.builder(
              itemCount: data.notices?.length ?? 0,
              itemBuilder: (context, index) {
                return NoticeItemWidget(
                  item: data.notices?[index],
                );
              },
            ),
          );
        },
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

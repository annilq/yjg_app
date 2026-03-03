import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/features/office/presentation/widgets/backlog_tab_widget.dart';
import 'package:flutter_app/features/office/presentation/widgets/backlog_item_widget.dart';

class BacklogListScreen extends ConsumerStatefulWidget {
  const BacklogListScreen({super.key});

  @override
  ConsumerState<BacklogListScreen> createState() => _BacklogListScreenState();
}

class _BacklogListScreenState extends ConsumerState<BacklogListScreen> {
  int _currentTabIndex = 0;
  List<dynamic> _backlogItems = [];
  bool _isLoading = false;
  int _page = 1;
  int _rows = 10;
  String? _keyword;

  @override
  void initState() {
    super.initState();
    _loadBacklogList();
  }

  Future<void> _loadBacklogList() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var response = await ApiService().getBacklogList(
        _currentTabIndex,
        _keyword,
        _page,
        _rows,
      );
      setState(() {
        _backlogItems = response['rows'] ?? [];
      });
    } catch (e) {
      print('加载待办列表失败: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onTabChanged(int index) {
    setState(() {
      _currentTabIndex = index;
      _page = 1;
      _backlogItems = [];
    });
    _loadBacklogList();
  }

  void _onSearch(String keyword) {
    setState(() {
      _keyword = keyword;
      _page = 1;
      _backlogItems = [];
    });
    _loadBacklogList();
  }

  Future<void> _refresh() async {
    _page = 1;
    _backlogItems = [];
    await _loadBacklogList();
  }

  Future<void> _loadMore() async {
    if (!_isLoading) {
      setState(() {
        _page++;
      });
      await _loadBacklogList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: '我的待办',
        showSearch: true,
        onSearchPressed: () {
          showSearch(
            context: context,
            delegate: BacklogSearchDelegate(_onSearch),
          );
        },
      ),
      body: Column(
        children: [
          BacklogTabWidget(
            currentIndex: _currentTabIndex,
            onTabChanged: _onTabChanged,
          ),
          Expanded(
            child: _isLoading && _backlogItems.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: _refresh,
                    child: NotificationListener<ScrollEndNotification>(
                      onNotification: (notification) {
                        if (notification.metrics.pixels ==
                            notification.metrics.maxScrollExtent) {
                          _loadMore();
                        }
                        return false;
                      },
                      child: ListView.builder(
                        itemCount: _backlogItems.length,
                        itemBuilder: (context, index) {
                          return BacklogItemWidget(
                            item: _backlogItems[index],
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

class BacklogSearchDelegate extends SearchDelegate {
  final Function(String) onSearch;

  BacklogSearchDelegate(this.onSearch);

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

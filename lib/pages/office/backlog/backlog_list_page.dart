import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/pages/office/backlog/components/backlog_tab_component.dart';
import 'package:flutter_app/pages/office/backlog/components/backlog_item_component.dart';
import 'package:flutter_app/components/app_bar.dart';

class BacklogListPage extends StatefulWidget {
  @override
  _BacklogListPageState createState() => _BacklogListPageState();
}

class _BacklogListPageState extends State<BacklogListPage> {
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
      appBar: CustomAppBar(
        title: '我的待办',
        showSearch: true,
        onSearchPressed: () {
          // 显示搜索框
          showSearch(
            context: context,
            delegate: BacklogSearchDelegate(_onSearch),
          );
        },
      ),
      body: Column(
        children: [
          // 选项卡
          BacklogTabComponent(
            currentIndex: _currentTabIndex,
            onTabChanged: _onTabChanged,
          ),
          // 待办列表
          Expanded(
            child: _isLoading && _backlogItems.isEmpty
                ? Center(child: CircularProgressIndicator())
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
                          return BacklogItemComponent(
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
        icon: Icon(CupertinoIcons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(CupertinoIcons.back),
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

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/pages/notices/components/notice_item_component.dart';
import 'package:flutter_app/components/app_bar.dart';

class NoticesListPage extends StatefulWidget {
  @override
  _NoticesListPageState createState() => _NoticesListPageState();
}

class _NoticesListPageState extends State<NoticesListPage> {
  List<dynamic> _noticeItems = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadNoticeList();
  }

  Future<void> _loadNoticeList() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var response = await ApiService().getMainReminds();
      setState(() {
        _noticeItems = response['remindModels'] ?? [];
      });
    } catch (e) {
      print('加载提醒列表失败: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onSearch(String keyword) {
    setState(() {
      _noticeItems = [];
    });
    _loadNoticeList();
  }

  Future<void> _refresh() async {
    _noticeItems = [];
    await _loadNoticeList();
  }

  Future<void> _loadMore() async {
    if (!_isLoading) {
      await _loadNoticeList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '提醒',
        showSearch: true,
        onSearchPressed: () {
          // 显示搜索框
          showSearch(
            context: context,
            delegate: NoticeSearchDelegate(_onSearch),
          );
        },
      ),
      body: _isLoading && _noticeItems.isEmpty
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
                  itemCount: _noticeItems.length,
                  itemBuilder: (context, index) {
                    return NoticeItemComponent(
                      item: _noticeItems[index],
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
import 'package:flutter/material.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/models/notification_list_page_model.dart';
import 'package:flutter_app/components/index.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int _currentIndex = 0;
  List<NotificationModel> _notificationList = [];
  int _unreadCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // 获取通知列表
      var response = await ApiService().getNotificationList(_currentIndex, null, 1, 20);
      NotificationListPageModel model = NotificationListPageModel.fromJson(response);
      _notificationList = model.notificationModels ?? [];

      // 获取未读通知数量
      _unreadCount = await ApiService().getNotificationUnReadCount();
    } catch (e) {
      print('加载数据失败: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('通知'),
        actions: [
          if (_unreadCount > 0)
            TextButtonCustom(
              onPressed: () async {
                try {
                  await ApiService().setNotificationAllRead();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('全部已读')),
                  );
                  _loadData();
                } catch (e) {
                  print('标记全部已读失败: $e');
                }
              },
              child: Text('全部已读', style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: '全部'),
              Tab(text: '未读'),
              Tab(text: '已读'),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                _loadData();
              });
            },
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _notificationList.length,
                    itemBuilder: (context, index) {
                      NotificationModel item = _notificationList[index];
                      return Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(item.title ?? '', style: TextStyle(fontSize: 16)),
                                  if (item.status == 0)
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(item.content ?? '', style: TextStyle(fontSize: 14, color: Colors.grey)),
                              SizedBox(height: 8),
                              Text(item.createTime ?? '', style: TextStyle(fontSize: 12, color: Colors.grey)),
                              SizedBox(height: 8),
                              if (item.status == 0)
                                Button(
                                  onPressed: () async {
                                    try {
                                      await ApiService().setNotificationRead(item.id ?? '');
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('已标记为已读')),
                                      );
                                      _loadData();
                                    } catch (e) {
                                      print('标记已读失败: $e');
                                    }
                                  },
                                  text: '标记已读',
                                ),
                            ],
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

import 'package:flutter/material.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/models/backlog_list_page_model.dart';
import 'package:flutter_app/components/index.dart';

class WorkflowPage extends StatefulWidget {
  @override
  _WorkflowPageState createState() => _WorkflowPageState();
}

class _WorkflowPageState extends State<WorkflowPage> {
  int _currentIndex = 0;
  List<BacklogModel> _backlogList = [];
  List<BacklogModel> _completedList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // 获取待办事项
      var backlogResponse = await ApiService().getBacklogList(0, null, 1, 20);
      BacklogListPageModel backlogModel = BacklogListPageModel.fromJson(backlogResponse);
      _backlogList = backlogModel.backlogModels ?? [];

      // 获取已办事项
      var completedResponse = await ApiService().getBacklogList(1, null, 1, 20);
      BacklogListPageModel completedModel = BacklogListPageModel.fromJson(completedResponse);
      _completedList = completedModel.backlogModels ?? [];
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
      appBar: CustomAppBar(
        title: '工作流',
      ),
      body: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: '待办'),
              Tab(text: '已办'),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _currentIndex == 0
                    ? ListView.builder(
                        itemCount: _backlogList.length,
                        itemBuilder: (context, index) {
                          BacklogModel item = _backlogList[index];
                          return Card(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.title ?? '', style: TextStyle(fontSize: 16)),
                                  SizedBox(height: 8),
                                  Text(item.createTime ?? '', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                  SizedBox(height: 8),
                                  Button(
                                    onPressed: () {
                                      // 处理工作流
                                    },
                                    text: '处理',
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        itemCount: _completedList.length,
                        itemBuilder: (context, index) {
                          BacklogModel item = _completedList[index];
                          return Card(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.title ?? '', style: TextStyle(fontSize: 16)),
                                  SizedBox(height: 8),
                                  Text(item.createTime ?? '', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                  SizedBox(height: 8),
                                  Text('已处理', style: TextStyle(fontSize: 12, color: Colors.green)),
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

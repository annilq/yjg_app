import 'package:flutter/material.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:flutter_app/models/data_list_page_model.dart';

class DataListPage extends StatefulWidget {
  final String dataId;
  final String title;

  DataListPage({required this.dataId, required this.title});

  @override
  _DataListPageState createState() => _DataListPageState();
}

class _DataListPageState extends State<DataListPage> {
  List<DataModel>? _dataList;
  int _page = 1;
  int _rows = 20;
  int _total = 0;
  bool _isLoading = true;
  Map<String, dynamic>? _filterDict;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      var response = await ApiService().getDataList(
        widget.dataId,
        _filterDict,
        _page,
        _rows,
        -1,
      );
      DataListPageModel model = DataListPageModel.fromJson(response);
      setState(() {
        _dataList = model.dataModels;
        _total = model.total ?? 0;
        _isLoading = false;
      });
    } catch (e) {
      print('加载数据失败: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshData() async {
    _page = 1;
    await _loadData();
  }

  Future<void> _loadMoreData() async {
    if (_dataList != null && _dataList!.length < _total) {
      _page++;
      try {
        var response = await ApiService().getDataList(
          widget.dataId,
          _filterDict,
          _page,
          _rows,
          -1,
        );
        DataListPageModel model = DataListPageModel.fromJson(response);
        setState(() {
          _dataList?.addAll(model.dataModels ?? []);
        });
      } catch (e) {
        print('加载更多数据失败: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // 打开筛选对话框
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _dataList == null || _dataList!.isEmpty
              ? Center(child: Text('暂无数据'))
              : RefreshIndicator(
                  onRefresh: _refreshData,
                  child: ListView.builder(
                    itemCount: _dataList!.length + 1,
                    itemBuilder: (context, index) {
                      if (index == _dataList!.length) {
                        if (_dataList!.length < _total) {
                          _loadMoreData();
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return Center(child: Text('没有更多数据了'));
                        }
                      }
                      DataModel item = _dataList![index];
                      return Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.title ?? '', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              SizedBox(height: 8),
                              Text(item.content ?? '', style: TextStyle(fontSize: 14, color: Colors.grey)),
                              SizedBox(height: 8),
                              Text(item.createTime ?? '', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}

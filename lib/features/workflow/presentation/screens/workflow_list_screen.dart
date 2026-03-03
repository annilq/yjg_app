import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';

class WorkflowListScreen extends ConsumerStatefulWidget {
  final String workflowCode;
  final String dataId;
  final String name;

  const WorkflowListScreen({
    super.key,
    required this.workflowCode,
    required this.dataId,
    required this.name,
  });

  @override
  ConsumerState<WorkflowListScreen> createState() => _WorkflowListScreenState();
}

class _WorkflowListScreenState extends ConsumerState<WorkflowListScreen> {
  late String _title;
  late String _workflowCode;
  late String _dataId;
  Map<String, dynamic> _config = {};
  List<dynamic> _dataList = [];
  int _page = 1;
  int _rows = 10;
  bool _hasMore = true;
  bool _isLoading = true;
  Map<String, dynamic> _searchForm = {};
  Map<String, dynamic> _pickerParams = {};

  @override
  void initState() {
    super.initState();
    _title = widget.name;
    _workflowCode = widget.workflowCode;
    _dataId = widget.dataId;
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    try {
      var configResponse = await ApiService().getMainDataListConfig();
      if (configResponse.containsKey('datalistconfig')) {
        _config = configResponse['datalistconfig'][_dataId] ?? {};
      }
      await _initLoadData();
    } catch (e) {
      print('加载配置失败: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _initLoadData() async {
    setState(() {
      _hasMore = true;
      _dataList = [];
      _page = 1;
      _isLoading = true;
    });
    await _loadData();
  }

  Future<void> _loadData() async {
    try {
      final params = {
        'rows': _rows,
        'page': _page,
        ..._searchForm,
        ..._pickerParams,
      };

      var response = await ApiService().getDataList(
        _dataId,
        params,
        _page,
        _rows,
        -1,
      );

      List<dynamic> list = response['rows'] ?? [];
      setState(() {
        _hasMore = !(response['last'] ?? true);
        _page += 1;
        _dataList.addAll(list);
        _isLoading = false;
      });
    } catch (e) {
      print('加载数据失败: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _goDetail(dynamic item) {
    if (_config.containsKey('formKey') && _config.containsKey('formMode')) {
      final params = {
        'formKey': _config['formKey'],
        'processType': 'SEARCH',
        'url': _config['formMode']['url'],
        'data': {
          'id': item['id'],
        },
      };

      context.push(
        '/webview',
        extra: params,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: _title,
      ),
      body: _isLoading && _dataList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _initLoadData,
              child: ListView.builder(
                itemCount: _dataList.length + (_hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _dataList.length) {
                    if (_hasMore) {
                      _loadData();
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return const SizedBox.shrink();
                    }
                  }

                  var item = _dataList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  item['title'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                item['date'] ?? '',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['name'] ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              item['status'] ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () => _goDetail(item),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

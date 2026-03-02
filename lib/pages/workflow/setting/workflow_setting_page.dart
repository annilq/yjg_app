import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:flutter_app/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkflowSettingPage extends StatefulWidget {
  @override
  _WorkflowSettingPageState createState() => _WorkflowSettingPageState();
}

class _WorkflowSettingPageState extends State<WorkflowSettingPage> {
  bool _editMode = false;
  List<dynamic> _menus = [];
  List<String> _userList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserList();
    _loadData();
  }

  Future<void> _loadUserList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userListStr = prefs.getString('userList');
      if (userListStr != null && userListStr.isNotEmpty) {
        setState(() {
          _userList = userListStr.split(',').where((id) => id.isNotEmpty).toList();
        });
      }
    } catch (e) {
      print('加载用户列表失败: $e');
    }
  }

  Future<void> _saveUserList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userList', _userList.join(','));
    } catch (e) {
      print('保存用户列表失败: $e');
    }
  }

  Future<void> _loadData() async {
    try {
      var response = await ApiService().getMainWorkflows();
      setState(() {
        _menus = response['menus'] ?? [];
        _isLoading = false;
      });
    } catch (e) {
      print('加载数据失败: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _goFlowDetail(dynamic item) {
    if (item != null && item.containsKey('id') && item.containsKey('text')) {
      Navigator.pushNamed(
        context,
        '/workflow/list',
        arguments: {
          'dataId': item['id'] ?? '',
          'workflowCode': item['img'] ?? '',
          'name': item['text'] ?? '',
        },
      );
    }
  }

  void _addToFavorite(dynamic item, String module) {
    if (item == null || !item.containsKey('id')) return;
    
    if (_editMode) {
      String itemId = item['id'].toString();
      if (_userList.contains(itemId)) {
        _removeFromFavorite(item);
      } else {
        setState(() {
          _userList.add(itemId);
        });
      }
    } else {
      _goFlowDetail(item);
    }
  }

  void _removeFromFavorite(dynamic item) {
    if (item == null || !item.containsKey('id')) return;
    
    if (_editMode) {
      String itemId = item['id'].toString();
      setState(() {
        _userList.remove(itemId);
      });
    } else {
      _goFlowDetail(item);
    }
  }

  void _setEditMode() {
    setState(() {
      _editMode = !_editMode;
      if (!_editMode) {
        _saveUserList();
      }
    });
  }

  bool _isInUserList(String id) {
    return _userList.contains(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '全部应用',
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 我的应用
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [AppTheme.cardShadow],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('我的应用', style: AppTheme.titleStyle),
                              ElevatedButton(
                                onPressed: _setEditMode,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(_editMode ? '保存' : '管理'),
                              ),
                            ],
                          ),
                        ),
                        _userList.isEmpty
                            ? Padding(
                                padding: EdgeInsets.all(16),
                                child: Text('暂无常用应用', style: AppTheme.smallStyle),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                ),
                                itemCount: _userList.length,
                                itemBuilder: (context, index) {
                                  // 查找对应的应用信息
                                  dynamic item;
                                  for (var menu in _menus) {
                                    if (menu != null && menu.containsKey('children')) {
                                      for (var child in menu['children']) {
                                        if (child != null && child.containsKey('id') && child['id'].toString() == _userList[index]) {
                                          item = child;
                                          break;
                                        }
                                      }
                                    }
                                    if (item != null) break;
                                  }

                                  if (item == null) return SizedBox.shrink();

                                  return GestureDetector(
                                    onTap: () => _removeFromFavorite(item),
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              width: 56,
                                              height: 56,
                                              decoration: BoxDecoration(
                                                color: AppTheme.primaryColor.withAlpha(25),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Icon(
                                                CupertinoIcons.square_grid_2x2,
                                                color: AppTheme.primaryColor,
                                                size: 24,
                                              ),
                                            ),
                                            if (_editMode)
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                child: Icon(
                                                  CupertinoIcons.delete,
                                                  color: Colors.red,
                                                  size: 16,
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          item['text'] ?? '',
                                          style: AppTheme.smallStyle,
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ],
                    ),
                  ),

                  // 所有应用
                  SizedBox(height: 16),
                  for (var menu in _menus)
                    if (menu != null && menu.containsKey('children'))
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [AppTheme.cardShadow],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(menu['text'] ?? '', style: AppTheme.titleStyle),
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: menu['children']?.length ?? 0,
                              itemBuilder: (context, index) {
                                var item = menu['children'][index];
                                if (item == null || !item.containsKey('id')) {
                                  return SizedBox.shrink();
                                }
                                bool isInUserList = _isInUserList(item['id'].toString());

                                return GestureDetector(
                                  onTap: () => _addToFavorite(item, menu['text'] ?? ''),
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            width: 56,
                                            height: 56,
                                            decoration: BoxDecoration(
                                              color: AppTheme.primaryColor.withAlpha(25),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Icon(
                                              CupertinoIcons.square_grid_2x2,
                                              color: AppTheme.primaryColor,
                                              size: 24,
                                            ),
                                          ),
                                          if (_editMode)
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: Icon(
                                                isInUserList
                                                    ? CupertinoIcons.delete
                                                    : CupertinoIcons.add,
                                                color: isInUserList ? Colors.red : Colors.green,
                                                size: 16,
                                              ),
                                            ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        item['text'] ?? '',
                                        style: AppTheme.smallStyle,
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                  // 底部版权信息
                  SizedBox(height: 32),
                  Center(
                    child: Text(
                      '广州建管网络科技有限公司',
                      style: AppTheme.smallStyle,
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
    );
  }
}

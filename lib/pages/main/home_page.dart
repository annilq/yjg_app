import 'package:flutter/material.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/models/main_menus_response_model.dart';
import 'package:flutter_app/models/main_reminds_response_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MenuModel> _menus = [];
  List<RemindModel> _reminds = [];
  int _backlogCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // 获取主菜单
      var menusResponse = await ApiService().getMainMenus();
      MainMenusResponseModel menusModel = MainMenusResponseModel.fromJson(menusResponse);
      _menus = menusModel.menuModels ?? [];

      // 获取提醒
      var remindsResponse = await ApiService().getMainReminds();
      MainRemindsResponseModel remindsModel = MainRemindsResponseModel.fromJson(remindsResponse);
      _reminds = remindsModel.remindModels ?? [];

      // 获取待办事项数量
      _backlogCount = await ApiService().getWorkflowBacklogCount();
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
        title: Text('首页'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.pushNamed(context, '/notification');
                },
              ),
              if (_backlogCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$_backlogCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 待办事项
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('待办事项', style: TextStyle(fontSize: 16)),
                          Text('$_backlogCount 件', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // 系统提醒
                  Text('系统提醒', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  ..._reminds.map((remind) => Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(remind.title ?? '', style: TextStyle(fontSize: 14)),
                              SizedBox(height: 4),
                              Text(remind.content ?? '', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ),
                      )),
                  SizedBox(height: 16),

                  // 主菜单
                  Text('功能菜单', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                    ),
                    itemCount: _menus.length,
                    itemBuilder: (context, index) {
                      MenuModel menu = _menus[index];
                      return GestureDetector(
                        onTap: () {
                          // 处理菜单点击
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.apps), // 这里应该使用实际的图标
                            SizedBox(height: 8),
                            Text(menu.menuName ?? '', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

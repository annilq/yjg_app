import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/models/main_menus_response_model.dart';
import 'package:flutter_app/models/main_reminds_response_model.dart';
import 'package:flutter_app/pages/main/components/backlog_menu_component.dart';
import 'package:flutter_app/pages/main/components/common_apps_component.dart';
import 'package:flutter_app/pages/main/components/announcement_carousel_component.dart';
import 'package:flutter_app/pages/main/components/common_modules_component.dart';
import 'package:flutter_app/pages/main/components/fixed_apps_component.dart';
import 'package:flutter_app/pages/main/components/copyright_component.dart';

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
        title: null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(CupertinoIcons.bell),
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
                  // 待办菜单区域
                  BacklogMenuComponent(
                    backlogCount: _backlogCount,
                    remindCount: _reminds.length,
                  ),
                  SizedBox(height: 16),

                  // 常用应用区域
                  CommonAppsComponent(menus: _menus),
                  SizedBox(height: 16),

                  // 公告轮播区域
                  AnnouncementCarouselComponent(reminds: _reminds),
                  SizedBox(height: 16),

                  // 常用模块区域
                  CommonModulesComponent(),
                  SizedBox(height: 16),

                  // 固定应用区域
                  FixedAppsComponent(),
                  SizedBox(height: 16),

                  // 底部版权信息
                  CopyrightComponent(),
                  SizedBox(height: 16),
                ],
              ),
            ),
    );
  }
}

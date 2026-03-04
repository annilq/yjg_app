import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/models/main_menus_response_model.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class CommonAppsComponent extends StatefulWidget {
  const CommonAppsComponent({
    super.key,
  });

  @override
  _CommonAppsComponentState createState() => _CommonAppsComponentState();
}

class _CommonAppsComponentState extends State<CommonAppsComponent> {
  List<MenuModel> _menus = [];
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
    } catch (e) {
      print('加载常用应用数据失败: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // 处理设置按钮点击
  void _handleSettingTap() {
    context.push('/workflow/setting');
  }

  // 处理菜单点击
  void _handleMenuTap(MenuModel menu) {
    context.push(
      '/workflow/list',
      extra: {
        'dataId': menu.menuId,
        'workflowCode': menu.menuIcon,
        'name': menu.menuName,
      },
    );
  }

  // 处理全部功能点击
  void _handleAllFunctionsTap() {
    context.push('/workflow/setting');
  }

  @override
  Widget build(BuildContext context) {
    return AppTheme.cardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('常用应用', style: AppTheme.titleStyle),
              GestureDetector(
                onTap: _handleSettingTap,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Icon(CupertinoIcons.settings, color: AppTheme.primaryColor, size: 20),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          _isLoading
              ? Container(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _menus.length,
                  itemBuilder: (context, index) {
                    MenuModel menu = _menus[index];
                    return GestureDetector(
                      onTap: () => _handleMenuTap(menu),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                          SizedBox(height: 8),
                          Text(
                            menu.menuName ?? '',
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
          SizedBox(height: 12),
          // 全部功能入口
          GestureDetector(
            onTap: _handleAllFunctionsTap,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.lightGray),
                borderRadius: BorderRadius.circular(8),
                color: AppTheme.lightGray.withAlpha(128),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.square_grid_2x2,
                    color: AppTheme.primaryColor,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text('全部功能', style: TextStyle(color: AppTheme.primaryColor)),
                ],
              ),
            ),
          ),
        ],
      ),
      margin: EdgeInsets.all(0),
    );
  }
}

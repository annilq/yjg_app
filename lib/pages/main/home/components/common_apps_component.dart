import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/models/main_menus_response_model.dart';
import 'package:flutter_app/theme/theme.dart';

class CommonAppsComponent extends StatelessWidget {
  final List<MenuModel> menus;

  const CommonAppsComponent({
    Key? key,
    required this.menus,
  }) : super(key: key);

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
              IconButton(
                icon: Icon(CupertinoIcons.settings, color: AppTheme.primaryColor),
                onPressed: () {
                  // 处理设置按钮点击
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
            ),
            itemCount: menus.length,
            itemBuilder: (context, index) {
              MenuModel menu = menus[index];
              return GestureDetector(
                onTap: () {
                  // 处理菜单点击
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(CupertinoIcons.square_grid_2x2, color: AppTheme.primaryColor),
                    ),
                    SizedBox(height: 8),
                    Text(menu.menuName ?? '', style: AppTheme.smallStyle),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 8),
          // 全部功能入口
          GestureDetector(
            onTap: () {
              // 处理全部功能点击
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.lightGray),
                borderRadius: BorderRadius.circular(8),
                color: AppTheme.lightGray.withOpacity(0.5),
              ),
              child: Text('全部功能', style: TextStyle(color: AppTheme.primaryColor)),
            ),
          ),
        ],
      ),
      margin: EdgeInsets.all(0),
    );
  }
}

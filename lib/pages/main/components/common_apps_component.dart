import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/models/main_menus_response_model.dart';

class CommonAppsComponent extends StatelessWidget {
  final List<MenuModel> menus;

  const CommonAppsComponent({
    Key? key,
    required this.menus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('常用应用', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            IconButton(
              icon: Icon(CupertinoIcons.settings),
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
                  Icon(CupertinoIcons.square_grid_2x2), // 这里应该使用实际的图标
                  SizedBox(height: 8),
                  Text(menu.menuName ?? '', style: TextStyle(fontSize: 12)),
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
              border: Border.all(color: Colors.grey[200]!),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text('全部功能', style: TextStyle(color: Colors.blue)),
          ),
        ),
      ],
    );
  }
}

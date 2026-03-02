import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/models/main_menus_response_model.dart';
import 'package:flutter_app/theme/theme.dart';

class CommonAppsComponent extends StatelessWidget {
  final List<MenuModel> menus;
  final VoidCallback onSettingTap;
  final ValueChanged<MenuModel> onMenuTap;
  final VoidCallback onAllFunctionsTap;

  const CommonAppsComponent({
    super.key,
    required this.menus,
    required this.onSettingTap,
    required this.onMenuTap,
    required this.onAllFunctionsTap,
  });

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
                onTap: onSettingTap,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Icon(CupertinoIcons.settings, color: AppTheme.primaryColor, size: 20),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: menus.length,
            itemBuilder: (context, index) {
              MenuModel menu = menus[index];
              return GestureDetector(
                onTap: () => onMenuTap(menu),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
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
            onTap: onAllFunctionsTap,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.lightGray),
                borderRadius: BorderRadius.circular(8),
                color: AppTheme.lightGray.withOpacity(0.5),
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

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class BacklogMenuComponent extends StatelessWidget {
  final int backlogCount;
  final int remindCount;

  const BacklogMenuComponent({
    Key? key,
    required this.backlogCount,
    required this.remindCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        boxShadow: [isDark ? AppTheme.darkCardShadow : AppTheme.cardShadow],
      ),
      padding: EdgeInsets.all(AppTheme.cardPadding),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          List<Map<String, dynamic>> menuItems = [
            {
              'title': '待处理',
              'icon': CupertinoIcons.mail,
              'count': backlogCount,
            },
            {'title': '已发起', 'icon': CupertinoIcons.paperplane, 'count': 0},
            {'title': '提醒', 'icon': CupertinoIcons.bell, 'count': remindCount},
            {'title': '发起', 'icon': CupertinoIcons.add_circled, 'count': 0},
          ];
          var item = menuItems[index];
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                context.push('/office/backlog');
              } else if (index == 1) {
                context.push('/office/relatedtome');
              } else if (index == 2) {
                context.push('/notices');
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item['icon'], color: Colors.white, size: 24),
                    SizedBox(height: 8),
                    Text(
                      item['title'],
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                if (item['count'] > 0)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${item['count']}',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

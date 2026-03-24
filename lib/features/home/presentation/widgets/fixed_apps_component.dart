import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class FixedAppsComponent extends StatelessWidget {
  const FixedAppsComponent({Key? key}) : super(key: key);

  String _getWeekday() {
    List<String> weekdays = ['周日', '周一', '周二', '周三', '周四', '周五', '周六'];
    return weekdays[DateTime.now().weekday % 7];
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppTheme.cardContainer(
      isDark: isDark,
      child: Row(
        children: [
          // 左侧日期显示
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${DateTime.now().month}月${DateTime.now().day}日',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  '$_getWeekday()',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          // 右侧2x2网格布局
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                List<Map<String, dynamic>> apps = [
                  {'title': '考勤打卡', 'icon': CupertinoIcons.time, 'color': AppTheme.primaryColor},
                  {'title': '签到', 'icon': CupertinoIcons.checkmark_circle, 'color': AppTheme.secondaryColor},
                  {'title': '工作报告', 'icon': CupertinoIcons.pencil, 'color': AppTheme.warningColor},
                  {'title': '工作任务', 'icon': CupertinoIcons.checkmark_seal, 'color': AppTheme.errorColor},
                ];
                var app = apps[index];
                return AppTheme.cardWithTap(
                  onTap: () {
                    // 处理应用点击
                  },
                  isDark: isDark,
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: app['color'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(app['icon'], color: app['color'], size: 16),
                      ),
                      SizedBox(width: 8),
                      Text(
                        app['title'],
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(0),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

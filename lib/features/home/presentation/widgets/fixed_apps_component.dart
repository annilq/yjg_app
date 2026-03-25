import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class FixedAppsComponent extends StatelessWidget {
  const FixedAppsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppTheme.cardContainer(
      isDark: isDark,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          List<Map<String, dynamic>> apps = [
            {
              'title': '考勤打卡',
              'icon': CupertinoIcons.time,
              'color': AppTheme.primaryColor,
            },
            {
              'title': '签到',
              'icon': CupertinoIcons.checkmark_circle,
              'color': AppTheme.secondaryColor,
            },
            {
              'title': '工作报告',
              'icon': CupertinoIcons.pencil,
              'color': AppTheme.warningColor,
            },
            {
              'title': '工作任务',
              'icon': CupertinoIcons.checkmark_seal,
              'color': AppTheme.errorColor,
            },
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
            margin: EdgeInsets.all(0),
          );
        },
      ),
    );
  }
}

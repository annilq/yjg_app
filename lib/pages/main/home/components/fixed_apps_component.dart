import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FixedAppsComponent extends StatelessWidget {
  const FixedAppsComponent({Key? key}) : super(key: key);

  String _getWeekday() {
    List<String> weekdays = ['周日', '周一', '周二', '周三', '周四', '周五', '周六'];
    return weekdays[DateTime.now().weekday % 7];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            // 左侧日期显示
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${DateTime.now().month}月${DateTime.now().day}日', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('$_getWeekday()', style: TextStyle(fontSize: 12, color: Colors.grey)),
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
                  childAspectRatio: 2,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  List<Map<String, dynamic>> apps = [
                    {'title': '考勤打卡', 'icon': CupertinoIcons.time, 'color': Colors.blue},
                    {'title': '签到', 'icon': CupertinoIcons.checkmark_circle, 'color': Colors.green},
                    {'title': '工作报告', 'icon': CupertinoIcons.pencil, 'color': Colors.orange},
                    {'title': '工作任务', 'icon': CupertinoIcons.checkmark_seal, 'color': Colors.purple},
                  ];
                  var app = apps[index];
                  return Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: app['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(app['icon'], color: app['color']),
                        ),
                        Text(app['title'], style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

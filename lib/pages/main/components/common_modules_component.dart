import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CommonModulesComponent extends StatelessWidget {
  const CommonModulesComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('常用模块', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
            crossAxisCount: 2,
            childAspectRatio: 1.5,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            List<Map<String, dynamic>> modules = [
              {'title': '项目管理', 'description': '查看和管理项目', 'icon': CupertinoIcons.briefcase},
              {'title': '流程审批', 'description': '处理审批流程', 'icon': CupertinoIcons.doc_text},
              {'title': '人事管理', 'description': '人员信息管理', 'icon': CupertinoIcons.person_3},
              {'title': '财务管理', 'description': '财务相关操作', 'icon': CupertinoIcons.money_dollar_circle},
            ];
            var module = modules[index];
            return Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(module['icon'], color: Colors.blue),
                    SizedBox(height: 8),
                    Text(module['title'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(module['description'], style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

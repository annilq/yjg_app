import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class CommonModulesComponent extends StatelessWidget {
  const CommonModulesComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTheme.cardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('常用模块', style: AppTheme.titleStyle),
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
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
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
              return AppTheme.cardWithTap(
                onTap: () {
                  // 处理模块点击
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(module['icon'], color: AppTheme.primaryColor, size: 20),
                    ),
                    SizedBox(height: 8),
                    Text(module['title'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.darkGray)),
                    SizedBox(height: 4),
                    Text(module['description'], style: AppTheme.smallStyle),
                  ],
                ),
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.all(0),
              );
            },
          ),
        ],
      ),
      margin: EdgeInsets.all(0),
    );
  }
}

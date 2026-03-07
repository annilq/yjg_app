import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/core/theme/app_theme.dart';
import 'package:flutter_app/shared/widgets/business_card.dart';
import 'package:flutter_app/features/workflow/providers/workflow_providers.dart';

class CommonAppsComponent extends ConsumerWidget {
  const CommonAppsComponent({super.key});

  // 处理菜单点击
  void _handleMenuTap(BuildContext context, dynamic item) {
    if (item != null && item.containsKey('id') && item.containsKey('text')) {
      context.push(
        '/workflow/list',
        extra: {
          'dataId': item['id'] ?? '',
          'workflowCode': item['img'] ?? '',
          'name': item['text'] ?? '',
        },
      );
    }
  }

  // 处理设置按钮点击
  void _handleSettingTap(BuildContext context) {
    context.push('/workflow/setting');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menusAsync = ref.watch(menusProvider);
    final userList = ref.watch(userListProvider);

    return AppTheme.cardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('常用应用', style: AppTheme.titleStyle),
              GestureDetector(
                onTap: () => _handleSettingTap(context),
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    CupertinoIcons.settings,
                    color: AppTheme.primaryColor,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          menusAsync.when(
            data: (menus) {
              return userList.isEmpty
                  ? Container(
                      height: 120,
                      child: Center(
                        child: Text('暂无常用应用', style: AppTheme.smallStyle),
                      ),
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
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        dynamic item;
                        for (var menu in menus) {
                          if (menu != null && menu.containsKey('children')) {
                            for (var child in menu['children']) {
                              if (child != null &&
                                  child.containsKey('id') &&
                                  child['id'].toString() == userList[index]) {
                                item = child;
                                break;
                              }
                            }
                          }
                          if (item != null) break;
                        }

                        if (item == null) return const SizedBox.shrink();

                        return BusinessCard(
                          item: item,
                          editMode: false,
                          isInUserList: true,
                          onTap: () => _handleMenuTap(context, item),
                        );
                      },
                    );
            },
            loading: () => Container(
              height: 120,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => Container(
              height: 120,
              child: Center(child: Text('加载失败', style: AppTheme.smallStyle)),
            ),
          ),
          SizedBox(height: 12),
        ],
      ),
      margin: EdgeInsets.all(0),
    );
  }
}

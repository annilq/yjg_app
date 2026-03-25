import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';
import 'package:flutter_app/shared/widgets/business_card.dart';
import 'package:flutter_app/features/workflow/providers/workflow_providers.dart';

/// 常用应用组件 - Flat Design 风格
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
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final menusAsync = ref.watch(menusProvider);
    final userListAsync = ref.watch(userListProvider);

    return Container(
      decoration: BoxDecoration(
        color: (isDark ? DarkColors.surface : LightColors.surface),
        borderRadius: AppRadius.cardRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题栏
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '常用应用',
                style: AppTypography.titleMedium.copyWith(
                  fontWeight: AppTypography.weightSemibold,
                ),
              ),
              GestureDetector(
                onTap: () => _handleSettingTap(context),
                child: Container(
                  padding: EdgeInsets.all(AppSpacing.sm),
                  child: Icon(
                    CupertinoIcons.settings,
                    color: colorScheme.primary,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.elementGap),
          // 应用网格
          menusAsync.when(
            data: (menus) {
              return userListAsync.when(
                data: (userList) {
                  return userList.isEmpty
                      ? Container(
                          height: 120,
                          child: Center(
                            child: Text(
                              '暂无常用应用',
                              style: AppTypography.bodySmall.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1,
                                crossAxisSpacing: AppSpacing.md,
                                mainAxisSpacing: AppSpacing.md,
                              ),
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            dynamic item;
                            for (var menu in menus) {
                              if (menu != null &&
                                  menu.containsKey('children')) {
                                for (var child in menu['children']) {
                                  if (child != null &&
                                      child.containsKey('id') &&
                                      child['id'].toString() ==
                                          userList[index]) {
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
                  child: Center(
                    child: Text(
                      '加载失败',
                      style: AppTypography.bodySmall.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              );
            },
            loading: () => Container(
              height: 120,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => Container(
              height: 120,
              child: Center(
                child: Text(
                  '加载失败',
                  style: AppTypography.bodySmall.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

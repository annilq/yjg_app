import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/shared/widgets/index.dart';
import 'package:flutter_app/core/theme/app_theme.dart';
import 'package:flutter_app/features/workflow/providers/workflow_providers.dart';

class WorkflowSettingScreen extends ConsumerWidget {
  const WorkflowSettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBarComponent(
        title: '全部应用',
      ),
      body: WorkflowSettingContent(),
    );
  }
}

class WorkflowSettingContent extends ConsumerStatefulWidget {
  const WorkflowSettingContent({super.key});

  @override
  ConsumerState<WorkflowSettingContent> createState() => _WorkflowSettingContentState();
}

class _WorkflowSettingContentState extends ConsumerState<WorkflowSettingContent> {
  bool _editMode = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // 数据已在provider中加载
    setState(() {
      _isLoading = false;
    });
  }

  void _goFlowDetail(dynamic item) {
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

  void _addToFavorite(dynamic item, String module) {
    if (item == null || !item.containsKey('id')) return;
    
    if (_editMode) {
      String itemId = item['id'].toString();
      final notifier = ref.read(userListProvider.notifier);
      notifier.toggleItem(itemId);
    } else {
      _goFlowDetail(item);
    }
  }

  void _removeFromFavorite(dynamic item) {
    if (item == null || !item.containsKey('id')) return;
    
    if (_editMode) {
      String itemId = item['id'].toString();
      final notifier = ref.read(userListProvider.notifier);
      notifier.toggleItem(itemId);
    } else {
      _goFlowDetail(item);
    }
  }

  void _setEditMode() {
    setState(() {
      _editMode = !_editMode;
      if (!_editMode) {
        final notifier = ref.read(userListProvider.notifier);
        notifier.saveUserList();
      }
    });
  }

  bool _isInUserList(String id) {
    final userList = ref.watch(userListProvider);
    return userList.contains(id);
  }

  @override
  Widget build(BuildContext context) {
    final menusAsync = ref.watch(menusProvider);
    final userList = ref.watch(userListProvider);

    return _isLoading
        ? const LoadingComponent(message: '加载中...')
        : menusAsync.when(
            data: (menus) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [AppTheme.cardShadow],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('我的应用', style: AppTheme.titleStyle),
                                ButtonComponent(
                                  onPressed: _setEditMode,
                                  child: Row(
                                    children: [
                                      IconFontWidget(
                                        icon: IconFont.getIcon('a-huaban6'),
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(_editMode ? '保存' : '管理'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          userList.isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text('暂无常用应用', style: AppTheme.smallStyle),
                                )
                              : GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
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
                                          if (child != null && child.containsKey('id') && child['id'].toString() == userList[index]) {
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
                                      editMode: _editMode,
                                      isInUserList: true,
                                      onTap: () => _removeFromFavorite(item),
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    for (var menu in menus)
                      if (menu != null && menu.containsKey('children'))
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [AppTheme.cardShadow],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(menu['text'] ?? '', style: AppTheme.titleStyle),
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                ),
                                itemCount: menu['children']?.length ?? 0,
                                itemBuilder: (context, index) {
                                  var item = menu['children'][index];
                                  if (item == null || !item.containsKey('id')) {
                                    return const SizedBox.shrink();
                                  }
                                  bool isInUserList = _isInUserList(item['id'].toString());

                                  return BusinessCard(
                                    item: item,
                                    editMode: _editMode,
                                    isInUserList: isInUserList,
                                    onTap: () => _addToFavorite(item, menu['text'] ?? ''),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                    const SizedBox(height: 32),
                    Center(
                      child: Text(
                        '广州建管网络科技有限公司',
                        style: AppTheme.smallStyle,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            },
            loading: () => const LoadingComponent(),
            error: (error, stack) => ErrorComponent(
              message: '加载失败，请稍后重试',
              onRetry: _loadData,
            ),
          );
  }
}

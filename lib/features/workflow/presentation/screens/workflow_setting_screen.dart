import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/shared/widgets/index.dart';
import 'package:flutter_app/features/workflow/providers/workflow_providers.dart';

class WorkflowSettingScreen extends ConsumerWidget {
  const WorkflowSettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const AppBarComponent(title: '全部应用'),
      body: const WorkflowSettingContent(),
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
    setState(() => _isLoading = false);
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
      ref.read(userListProvider.notifier).toggleItem(itemId);
    } else {
      _goFlowDetail(item);
    }
  }

  void _removeFromFavorite(dynamic item) {
    if (item == null || !item.containsKey('id')) return;

    if (_editMode) {
      String itemId = item['id'].toString();
      ref.read(userListProvider.notifier).toggleItem(itemId);
    } else {
      _goFlowDetail(item);
    }
  }

  void _setEditMode() {
    setState(() {
      _editMode = !_editMode;
      if (!_editMode) {
        ref.read(userListProvider.notifier).saveUserList();
      }
    });
  }

  bool _isInUserList(String id, List<String> userList) {
    return userList.contains(id);
  }

  @override
  Widget build(BuildContext context) {
    final menusAsync = ref.watch(menusProvider);
    final userListAsync = ref.watch(userListProvider);

    if (_isLoading) {
      return const LoadingComponent(message: '加载中...');
    }

    return menusAsync.when(
      data: (menus) {
        return userListAsync.when(
          data: (userList) {
            // 使用 ListView 替代 SingleChildScrollView + Column，
            // 避免 GridView 在 Column 中高度无法约束导致背景穿透异常
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // ── 我的应用 ─────────────────────────────────
                _SectionCard(
                  title: '我的应用',
                  trailing: ButtonComponent(
                    onPressed: _setEditMode,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconFontWidget(icon: IconFont.getIcon('a-huaban6'), size: 16),
                        const SizedBox(width: 4),
                        Text(_editMode ? '保存' : '管理'),
                      ],
                    ),
                  ),
                  child: userList.isEmpty
                      ? const _EmptyText('暂无常用应用')
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
                                  if (child != null &&
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
                              editMode: _editMode,
                              isInUserList: true,
                              onTap: () => _removeFromFavorite(item),
                            );
                          },
                        ),
                ),

                const SizedBox(height: 16),

                // ── 模块列表 ─────────────────────────────────
                for (var menu in menus)
                  if (menu != null && menu.containsKey('children'))
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _SectionCard(
                        title: menu['text'] ?? '',
                        child: GridView.builder(
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
                            bool isInUserList = _isInUserList(
                              item['id'].toString(),
                              userList,
                            );
                            return BusinessCard(
                              item: item,
                              editMode: _editMode,
                              isInUserList: isInUserList,
                              onTap: () => _addToFavorite(item, menu['text'] ?? ''),
                            );
                          },
                        ),
                      ),
                    ),

                // ── 版权信息 ─────────────────────────────────
                const _CopyrightText(),
                const SizedBox(height: 16),
              ],
            );
          },
          loading: () => const LoadingComponent(),
          error: (error, stack) => ErrorComponent(
            message: '加载失败，请稍后重试',
            onRetry: _loadData,
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

/// 空列表占位文字
class _EmptyText extends StatelessWidget {
  final String text;
  const _EmptyText(this.text);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        text,
        style: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

/// 版权文字
class _CopyrightText extends StatelessWidget {
  const _CopyrightText();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          '广州建管网络科技有限公司',
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

/// 通用 Section 卡片 — 自带 theme context，背景色始终正确
class _SectionCard extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final Widget child;

  const _SectionCard({
    required this.title,
    this.trailing,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题栏
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
          // 内容区 — GridView/ListView，背景色继承自外层 Container
          child,
        ],
      ),
    );
  }
}

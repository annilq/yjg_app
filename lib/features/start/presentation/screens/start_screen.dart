import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/shared/widgets/index.dart';
import 'package:flutter_app/features/start/providers/start_providers.dart';

class StartScreen extends ConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const AppBarComponent(title: '新建流程'),
      body: const StartContent(),
    );
  }
}

class StartContent extends ConsumerStatefulWidget {
  const StartContent({super.key});

  @override
  ConsumerState<StartContent> createState() => _StartContentState();
}

class _StartContentState extends ConsumerState<StartContent> {
  int _sideBarIndex = 0;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _sideBarController = ScrollController();
  final List<GlobalKey> _sectionKeys = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _sideBarController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    await ref.read(categoriesProvider.future);
    setState(() => _isLoading = false);
  }

  void _onScroll() {
    final scrollTop = _scrollController.offset;
    const threshold = 50;

    if (scrollTop < threshold) {
      setState(() => _sideBarIndex = 0);
      return;
    }

    for (int i = _sectionKeys.length - 1; i >= 0; i--) {
      final key = _sectionKeys[i];
      if (key.currentContext != null) {
        final renderBox = key.currentContext!.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        if (position.dy - threshold <= scrollTop) {
          setState(() => _sideBarIndex = i);
          break;
        }
      }
    }
  }

  void _onSideBarChange(int index) {
    setState(() => _sideBarIndex = index);
    if (index < _sectionKeys.length) {
      final key = _sectionKeys[index];
      if (key.currentContext != null) {
        final renderBox = key.currentContext!.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        _scrollController.animateTo(
          position.dy - 16, // 减去padding
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _goDetail(dynamic item) {
    if (item != null && item.containsKey('id') && item.containsKey('text')) {
      context.push(
        '/webview',
        extra: {
          'formKey': item['img'] ?? '',
          'name': item['text'] ?? '',
          'id': item['processConfigId'] ?? '',
          'functionId': item['functionId'] ?? '',
          'processType': 'NEW',
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);

    if (_isLoading) {
      return const LoadingComponent(message: '加载中...');
    }

    return categoriesAsync.when(
      data: (categories) {
        // 重置section keys
        _sectionKeys.clear();
        for (var i = 0; i < categories.length; i++) {
          _sectionKeys.add(GlobalKey());
        }

        return Row(
          children: [
            // 左侧菜单
            Container(
              width: 100, // 缩小宽度
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    width: 1,
                  ),
                ),
              ),
              child: ListView.builder(
                controller: _sideBarController, // 添加滚动控制器
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return ListTile(
                    title: Text(
                      category['text'] ?? '',
                      style: TextStyle(
                        fontSize: 14, // 调整字体大小
                      ),
                    ),
                    selected: _sideBarIndex == index,
                    selectedTileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                    onTap: () => _onSideBarChange(index),
                  );
                },
              ),
            ),
            // 右侧内容
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    for (var i = 0; i < categories.length; i++)
                      if (categories[i] != null && categories[i].containsKey('children'))
                        Padding(
                          key: _sectionKeys[i], // 添加全局key
                          padding: const EdgeInsets.only(bottom: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 12,
                                ),
                                child: Text(
                                  categories[i]['text'] ?? '',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                ),
                                itemCount: categories[i]['children']?.length ?? 0,
                                itemBuilder: (context, index) {
                                  var item = categories[i]['children'][index];
                                  if (item == null || !item.containsKey('id')) {
                                    return const SizedBox.shrink();
                                  }
                                  return BusinessCard(
                                    item: item,
                                    editMode: false,
                                    isInUserList: false,
                                    onTap: () => _goDetail(item),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                  ],
                ),
              ),
            ),
          ],
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

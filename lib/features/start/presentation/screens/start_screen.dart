import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';
import 'package:flutter_app/shared/widgets/index.dart';
import 'package:flutter_app/features/start/providers/start_providers.dart';

class StartScreen extends ConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const AppBarComponent(title: '新建流程'),
      body: const _StartContent(),
    );
  }
}

class _StartContent extends ConsumerStatefulWidget {
  const _StartContent();

  @override
  ConsumerState<_StartContent> createState() => _StartContentState();
}

class _StartContentState extends ConsumerState<_StartContent> {
  int _activeIndex = 0;

  void _switchTo(int index) {
    if (index == _activeIndex) return;
    setState(() => _activeIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return categoriesAsync.when(
      data: (categories) {
        if (categories.isEmpty) {
          return const Center(child: Text('暂无数据'));
        }

        final titles = categories
            .where((c) => c != null && c.containsKey('text'))
            .map((c) => c['text'] as String)
            .toList();

        return Row(
          children: [
            _SideBar(
              titles: titles,
              activeIndex: _activeIndex,
              onTap: _switchTo,
            ),
            Expanded(
              child: _RightPanel(
                categories: categories,
                activeIndex: _activeIndex,
                onActiveIndexChanged: (index) {
                  if (index != _activeIndex) {
                    setState(() => _activeIndex = index);
                  }
                },
              ),
            ),
          ],
        );
      },
      loading: () => const LoadingComponent(message: '加载中...'),
      error: (error, stack) => ErrorComponent(
        message: '加载失败',
        onRetry: () => ref.invalidate(categoriesProvider),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
// 左侧分类栏
// ══════════════════════════════════════════════════════════════
class _SideBar extends StatelessWidget {
  final List<String> titles;
  final int activeIndex;
  final ValueChanged<int> onTap;

  const _SideBar({
    required this.titles,
    required this.activeIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? DarkColors.border : LightColors.border;
    final bgColor = isDark ? DarkColors.surfaceVariant : LightColors.surfaceVariant;
    final selectedBgColor = isDark ? DarkColors.surface : LightColors.surface;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      width: 90,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(right: BorderSide(color: borderColor, width: 1)),
      ),
      child: ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          final isActive = index == activeIndex;
          return GestureDetector(
            onTap: () => onTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
              decoration: BoxDecoration(
                color: isActive ? selectedBgColor : Colors.transparent,
                border: Border(
                  left: BorderSide(
                    color: isActive ? primaryColor : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Text(
                titles[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: isActive
                      ? primaryColor
                      : Theme.of(context).colorScheme.onSurface,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
// 右侧内容面板 — 显示所有分类，点击左侧时滚动到对应区域
// 核心：用预计算偏移量 + animateTo 替代 findRenderObject
// 配合 _isProgrammaticScroll 标志避免滚动回调循环
// ══════════════════════════════════════════════════════════════
class _RightPanel extends StatefulWidget {
  final List<dynamic> categories;
  final int activeIndex;
  final ValueChanged<int> onActiveIndexChanged;

  const _RightPanel({
    required this.categories,
    required this.activeIndex,
    required this.onActiveIndexChanged,
  });

  @override
  State<_RightPanel> createState() => _RightPanelState();
}

class _RightPanelState extends State<_RightPanel> {
  final ScrollController _scrollController = ScrollController();

  /// 每个 section 标题的顶部偏移量（预计算）
  final Map<int, double> _sectionOffsets = {};

  /// 标记当前是否为程序触发滚动，滚动监听期间禁止回调
  bool _isProgrammaticScroll = false;

  /// 网格列数
  static const _crossAxisCount = 3;
  /// 网格间距
  static const _spacing = 12.0;
  /// section 内边距
  static const _sectionPadding = AppSpacing.md;
  /// section 间距
  static const _sectionGap = 24.0;
  /// 标题高度（估算）
  static const _titleHeight = 40.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(_RightPanel old) {
    super.didUpdateWidget(old);
    // 数据源变化，重新计算偏移量
    if (old.categories != widget.categories) {
      _recalculateOffsets();
    }
    // 切换分类：滚动到目标区域
    if (old.activeIndex != widget.activeIndex) {
      _scrollToSection(widget.activeIndex);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  /// 预计算每个 section 标题的偏移量
  void _recalculateOffsets() {
    _sectionOffsets.clear();
    double offset = 0;

    for (int i = 0; i < widget.categories.length; i++) {
      final category = widget.categories[i];
      _sectionOffsets[i] = offset;

      final children = (category?['children'] as List?) ?? [];
      // 估算此 section 的总高度：标题 + Grid
      final rowCount = (children.length / _crossAxisCount).ceil();
      final itemSize =
          (MediaQuery.of(context).size.width - 90 - _sectionPadding * 2) /
                  _crossAxisCount -
              _spacing;
      final gridHeight = rowCount * (itemSize + _spacing);
      offset += _titleHeight + gridHeight + _sectionGap;
    }
  }

  /// 滚动到指定 section
  void _scrollToSection(int index) {
    final offset = _sectionOffsets[index];
    if (offset == null) return;

    _isProgrammaticScroll = true;
    _scrollController
        .animateTo(
      offset,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
    )
        .then((_) {
      // 动画结束后延迟一小段时间再开放监听
      Future.delayed(const Duration(milliseconds: 50), () {
        if (mounted) _isProgrammaticScroll = false;
      });
    });
  }

  /// 滚动监听：找出当前视口对应的 section，同步左侧高亮
  void _onScroll() {
    // 程序触发期间禁止回调
    if (_isProgrammaticScroll) return;

    final scrollOffset = _scrollController.offset;
    const threshold = 80.0;

    int target = 0;
    for (int i = _sectionOffsets.length - 1; i >= 0; i--) {
      final sectionTop = _sectionOffsets[i] ?? 0;
      if (scrollOffset >= sectionTop - threshold) {
        target = i;
        break;
      }
    }

    widget.onActiveIndexChanged(target);
  }

  @override
  Widget build(BuildContext context) {
    // 数据源变化时重新计算偏移量
    if (_sectionOffsets.isEmpty ||
        _sectionOffsets.length != widget.categories.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _recalculateOffsets();
      });
    }

    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.all(_sectionPadding),
      child: Column(
        children: widget.categories.asMap().entries.map((entry) {
          final index = entry.key;
          final category = entry.value;

          if (category == null || !category.containsKey('children')) {
            return const SizedBox.shrink();
          }

          final children = (category['children'] as List?) ?? [];

          return Padding(
            padding: const EdgeInsets.only(bottom: _sectionGap),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category['text'] ?? '',
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _crossAxisCount,
                    childAspectRatio: 1,
                    crossAxisSpacing: _spacing,
                    mainAxisSpacing: _spacing,
                  ),
                  itemCount: children.length,
                  itemBuilder: (context, i) {
                    final item = children[i];
                    if (item == null || !item.containsKey('id')) {
                      return const SizedBox.shrink();
                    }
                    return BusinessCard(
                      item: item,
                      editMode: false,
                      isInUserList: false,
                      onTap: () => _goDetail(context, item),
                    );
                  },
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  void _goDetail(BuildContext context, dynamic item) {
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
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/shared/widgets/empty_card.dart';
import 'package:flutter_app/shared/widgets/loading_component.dart';

/// 分页列表屏幕 - 通用组件
///
/// 统一的列表页面架构，支持：
/// - 自动 loading/error/empty 状态处理
/// - 下拉刷新
/// - 上拉加载更多
/// - 可选 Tab 切换
/// - 可选搜索功能
class PaginatedListScreen<T, S> extends ConsumerWidget {
  /// 页面标题
  final String title;

  /// Provider
  final ProviderListenable<AsyncValue<S>> provider;

  /// 从 state 中提取数据列表
  final List<T> Function(S state) extractItems;

  /// 从 state 中判断是否有更多数据
  final bool Function(S state)? hasMore;

  /// 刷新方法
  final Future<void> Function(WidgetRef ref) onRefresh;

  /// 加载更多方法
  final Future<void> Function(WidgetRef ref)? onLoadMore;

  /// 列表项构建器
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// 空状态提示文字
  final String emptyMessage;

  /// 是否显示搜索
  final bool enableSearch;

  /// 搜索回调
  final void Function(WidgetRef ref, String keyword)? onSearch;

  /// Tab 组件（可选）
  final Widget? tabWidget;

  /// Tab 切换回调（配合 tabWidget 使用）
  final void Function(int index)? onTabChanged;

  const PaginatedListScreen({
    super.key,
    required this.title,
    required this.provider,
    required this.extractItems,
    this.hasMore,
    required this.onRefresh,
    this.onLoadMore,
    required this.itemBuilder,
    required this.emptyMessage,
    this.enableSearch = false,
    this.onSearch,
    this.tabWidget,
    this.onTabChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);
    final void Function(WidgetRef, String)? searchCallback = onSearch;

    return Scaffold(
      appBar: AppBarComponent(
        title: title,
        showSearch: enableSearch,
        onSearchPressed: enableSearch && searchCallback != null
            ? () {
                showSearch(
                  context: context,
                  delegate: _ListSearchDelegate(
                    onSearch: (keyword) => searchCallback(ref, keyword),
                  ),
                );
              }
            : null,
      ),
      body: Column(
        children: [
          if (tabWidget != null) tabWidget!,
          Expanded(
            child: state.when(
              loading: () => const LoadingComponent(message: '加载中...'),
              error: (error, stack) => _buildError(context, error),
              data: (data) => _buildList(context, ref, data),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, Object error) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.exclamationmark_triangle,
              size: 48,
              color: isDark
                  ? DarkColors.textSecondary
                  : LightColors.textSecondary,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              '加载失败: $error',
              style: AppTypography.bodyMedium.copyWith(
                color: isDark
                    ? DarkColors.textSecondary
                    : LightColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            GestureDetector(
              onTap: () => onRefresh,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withAlpha(15),
                  borderRadius: AppRadius.allSm,
                ),
                child: Text(
                  '重新加载',
                  style: AppTypography.bodyMedium.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: AppTypography.weightSemibold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, WidgetRef ref, S data) {
    final items = extractItems(data);
    if (items.isEmpty) {
      return EmptyCard(message: emptyMessage);
    }

    final canLoadMore = hasMore?.call(data) ?? false;

    return RefreshIndicator(
      onRefresh: () => onRefresh(ref),
      child: NotificationListener<ScrollEndNotification>(
        onNotification: (notification) {
          if (onLoadMore != null &&
              notification.metrics.pixels ==
                  notification.metrics.maxScrollExtent) {
            onLoadMore!(ref);
          }
          return false;
        },
        child: ListView.builder(
          itemCount: items.length + (canLoadMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == items.length) {
              return const LoadingComponent();
            }
            return itemBuilder(context, items[index], index);
          },
        ),
      ),
    );
  }
}

class _ListSearchDelegate extends SearchDelegate {
  final void Function(String) onSearch;

  _ListSearchDelegate({required this.onSearch});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(CupertinoIcons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(CupertinoIcons.back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearch(query);
    close(context, null);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}

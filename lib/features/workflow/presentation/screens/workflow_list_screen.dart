import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/tokens/app_spacing.dart';
import 'package:flutter_app/core/utils/navigation_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/shared/widgets/paginated_list_screen.dart';
import 'package:flutter_app/shared/widgets/card_item_component.dart';
import 'package:flutter_app/features/workflow/providers/workflow_list_provider.dart';

/// 流程列表页面
class WorkflowListScreen extends ConsumerWidget {
  final String workflowCode;
  final int dataId;
  final String name;

  const WorkflowListScreen({
    super.key,
    required this.workflowCode,
    required this.dataId,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaginatedListScreen<dynamic, WorkflowListData>(
      title: name,
      provider: workflowListProvider(dataId),
      extractItems: (state) => state.dataList,
      hasMore: (state) => state.hasMore,
      onRefresh: (ref) =>
          ref.read(workflowListProvider(dataId).notifier).refresh(),
      onLoadMore: (ref) =>
          ref.read(workflowListProvider(dataId).notifier).loadMore(),
      emptyMessage: '暂无数据',
      itemBuilder: (context, item, index) {
        final itemMap = item as Map<String, dynamic>;
        return CardItemComponent(
          formKey: itemMap['img'] ?? '',
          status: itemMap['status']?.toString(),
          title: itemMap['title'] ?? '',
          extra: itemMap['date'] ?? '',
          content: itemMap['name'] ?? '',
          margin: AppSpacing.listItemPadding,
          onTap: () => NavigationUtils.goToDetail(context, ref, itemMap, 'workflow'),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/shared/widgets/loading_component.dart';
import 'package:flutter_app/shared/widgets/card_item_component.dart';
import 'package:flutter_app/features/workflow/providers/workflow_list_provider.dart';

class WorkflowListScreen extends ConsumerWidget {
  final String workflowCode;
  final String dataId;
  final String name;

  const WorkflowListScreen({
    super.key,
    required this.workflowCode,
    required this.dataId,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBarComponent(title: name),
      body: WorkflowListContent(
        workflowCode: workflowCode,
        dataId: dataId,
        name: name,
      ),
    );
  }
}

class WorkflowListContent extends ConsumerStatefulWidget {
  final String workflowCode;
  final String dataId;
  final String name;

  const WorkflowListContent({
    super.key,
    required this.workflowCode,
    required this.dataId,
    required this.name,
  });

  @override
  ConsumerState<WorkflowListContent> createState() => _WorkflowListContentState();
}

class _WorkflowListContentState extends ConsumerState<WorkflowListContent> {
  void _goDetail(dynamic item, Map<String, dynamic> config) {
    if (config.containsKey('formKey') && config.containsKey('formMode')) {
      final params = {
        'formKey': config['formKey'],
        'processType': 'SEARCH',
        'url': config['formMode']['url'],
        'test': true,
        'data': {'id': item['id']},
      };

      context.push('/webview', extra: params);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(workflowListProvider(widget.dataId));

    return state.when(
      loading: () => const LoadingComponent(message: '加载中...'),
      error: (error, stack) => Center(
        child: Text('加载失败: $error'),
      ),
      data: (data) {
        return RefreshIndicator(
          onRefresh: () =>
              ref.read(workflowListProvider(widget.dataId).notifier).refresh(),
          child: ListView.builder(
            itemCount: data.dataList.length + (data.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == data.dataList.length) {
                if (data.hasMore) {
                  ref
                      .read(workflowListProvider(widget.dataId).notifier)
                      .loadMore();
                  return const LoadingComponent();
                } else {
                  return const SizedBox.shrink();
                }
              }

              var item = data.dataList[index];
              return CardItemComponent(
                formKey: item['img'] ?? '',
                status: item['status']?.toString(),
                title: item['title'] ?? '',
                extra: item['date'] ?? '',
                content: item['name'] ?? '',
                onTap: () => _goDetail(item, data.config),
              );
            },
          ),
        );
      },
    );
  }
}

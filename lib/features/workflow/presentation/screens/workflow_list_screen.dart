import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/shared/widgets/loading_component.dart';
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
      appBar: AppBarComponent(
        title: name,
      ),
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
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(workflowListProvider.notifier).loadConfig(widget.dataId);
    });
  }

  void _goDetail(dynamic item) {
    final state = ref.read(workflowListProvider);
    if (state.config.containsKey('formKey') && state.config.containsKey('formMode')) {
      final params = {
        'formKey': state.config['formKey'],
        'processType': 'SEARCH',
        'url': state.config['formMode']['url'],
        'data': {
          'id': item['id'],
        },
      };

      context.push(
        '/webview',
        extra: params,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(workflowListProvider);

    return state.isLoading && state.dataList.isEmpty
        ? const LoadingComponent(message: '加载中...')
        : RefreshIndicator(
            onRefresh: () => ref.read(workflowListProvider.notifier).initLoadData(widget.dataId),
            child: ListView.builder(
              itemCount: state.dataList.length + (state.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == state.dataList.length) {
                  if (state.hasMore) {
                    ref.read(workflowListProvider.notifier).loadData(widget.dataId);
                    return const LoadingComponent();
                  } else {
                    return const SizedBox.shrink();
                  }
                }

                var item = state.dataList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item['title'] ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              item['date'] ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item['name'] ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            item['status']?.toString() ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () => _goDetail(item),
                  ),
                );
              },
            ),
          );
  }
}

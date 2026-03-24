import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/shared/widgets/index.dart';
import 'package:flutter_app/features/workflow/providers/workflow_providers.dart';
import 'package:flutter_app/features/workflow/models/workflow_model.dart';

class ModuleListScreen extends ConsumerWidget {
  final String moduleName;

  const ModuleListScreen({super.key, required this.moduleName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBarComponent(title: moduleName),
      body: ModuleListContent(moduleName: moduleName),
    );
  }
}

class ModuleListContent extends ConsumerStatefulWidget {
  final String moduleName;

  const ModuleListContent({super.key, required this.moduleName});

  @override
  ConsumerState<ModuleListContent> createState() => _ModuleListContentState();
}

class _ModuleListContentState extends ConsumerState<ModuleListContent> {
  List<WorkflowItem> _moduleItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final service = ref.read(workflowServiceProvider);
      var moduleMenu = await service.getModuleMenus(widget.moduleName);
      if (moduleMenu != null && moduleMenu is Map) {
        List<dynamic> children = moduleMenu['children'] ?? [];
        setState(() {
          _moduleItems = children.map((item) => WorkflowItem.fromJson(item)).toList();
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      SnackBarHelper.showSnackBar(context, '加载数据失败，请稍后重试');
    }
  }

  void _goFlowDetail(WorkflowItem item) {
    context.push(
      '/workflow/list',
      extra: {
        'dataId': item.id,
        'workflowCode': item.img,
        'name': item.text,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (_isLoading) {
      return const LoadingComponent(message: '加载中...');
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _moduleItems.length,
      itemBuilder: (context, index) {
        final item = _moduleItems[index];

        return GestureDetector(
          onTap: () => _goFlowDetail(item),
          child: Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  CupertinoIcons.square_grid_2x2,
                  color: colorScheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.text ?? '',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/shared/widgets/loading_component.dart';
import 'package:flutter_app/shared/widgets/error_component.dart';
import 'package:flutter_app/features/workflow/providers/workflow_providers.dart';

class ModuleSettingScreen extends ConsumerWidget {
  const ModuleSettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const AppBarComponent(title: '模块设置'),
      body: const ModuleSettingContent(),
    );
  }
}

class ModuleSettingContent extends ConsumerStatefulWidget {
  const ModuleSettingContent({super.key});

  @override
  ConsumerState<ModuleSettingContent> createState() => _ModuleSettingContentState();
}

class _ModuleSettingContentState extends ConsumerState<ModuleSettingContent> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = false);
  }

  void _toggleModule(String moduleId) {
    ref.read(selectedModulesProvider.notifier).toggleModule(moduleId);
  }

  @override
  Widget build(BuildContext context) {
    final menusAsync = ref.watch(menusProvider);
    final selectedModulesAsync = ref.watch(selectedModulesProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (_isLoading) {
      return const LoadingComponent(message: '加载中...');
    }

    return menusAsync.when(
      data: (menus) {
        return selectedModulesAsync.when(
          data: (selectedModules) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: menus.length,
              itemBuilder: (context, index) {
                final menu = menus[index];
                final isSelected = selectedModules.contains(menu['id']?.toString() ?? '');

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    title: Text(
                      menu['text'] ?? '',
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    trailing: Switch(
                      value: isSelected,
                      onChanged: (value) {
                        _toggleModule(menu['id']?.toString() ?? '');
                      },
                      activeColor: colorScheme.primary,
                    ),
                  ),
                );
              },
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

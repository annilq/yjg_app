import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/shared/widgets/loading_component.dart';
import 'package:flutter_app/shared/widgets/error_component.dart';
import 'package:flutter_app/core/theme/app_theme.dart';
import 'package:flutter_app/features/workflow/providers/workflow_providers.dart';

class ModuleSettingScreen extends ConsumerWidget {
  const ModuleSettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBarComponent(
        title: '模块设置',
      ),
      body: ModuleSettingContent(),
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
    // 数据已在provider中加载
    setState(() {
      _isLoading = false;
    });
  }

  void _toggleModule(String moduleId) {
    final notifier = ref.read(selectedModulesProvider.notifier);
    notifier.toggleModule(moduleId);
  }

  bool _isModuleSelected(String moduleId) {
    final selectedModules = ref.watch(selectedModulesProvider);
    return selectedModules.contains(moduleId);
  }

  @override
  Widget build(BuildContext context) {
    final menusAsync = ref.watch(menusProvider);

    return _isLoading
        ? const LoadingComponent(message: '加载中...')
        : menusAsync.when(
            data: (menus) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: menus.length,
                itemBuilder: (context, index) {
                  var menu = menus[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            menu['text'] ?? '',
                            style: AppTheme.titleStyle,
                          ),
                          Switch(
                            value: _isModuleSelected(menu['id']?.toString() ?? ''),
                            onChanged: (value) {
                              _toggleModule(menu['id']?.toString() ?? '');
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                        ],
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
  }
}

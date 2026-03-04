import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class ModuleListScreen extends ConsumerStatefulWidget {
  final String moduleName;

  const ModuleListScreen({
    super.key,
    required this.moduleName,
  });

  @override
  ConsumerState<ModuleListScreen> createState() => _ModuleListScreenState();
}

class _ModuleListScreenState extends ConsumerState<ModuleListScreen> {
  late String _moduleName;
  List<dynamic> _moduleItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _moduleName = widget.moduleName;
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      var response = await ApiService().getMainWorkflows();
      List<dynamic> menus = response['menus'] ?? [];

      for (var menu in menus) {
        if (menu['text'] == _moduleName) {
          setState(() {
            _moduleItems = menu['children'] ?? [];
            _isLoading = false;
          });
          break;
        }
      }
    } catch (e) {
      print('加载数据失败: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _goFlowDetail(dynamic item) {
    context.push(
      '/workflow/list',
      extra: {
        'dataId': item['id'],
        'workflowCode': item['img'],
        'name': item['text'],
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: _moduleName,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _moduleItems.length,
              itemBuilder: (context, index) {
                var item = _moduleItems[index];
                return GestureDetector(
                  onTap: () => _goFlowDetail(item),
                  child: Column(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          CupertinoIcons.square_grid_2x2,
                          color: AppTheme.primaryColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['text'] ?? '',
                        style: AppTheme.smallStyle,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

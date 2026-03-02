import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:flutter_app/theme/theme.dart';

class ModuleListPage extends StatefulWidget {
  final String moduleName;

  const ModuleListPage({
    Key? key,
    required this.moduleName,
  }) : super(key: key);

  @override
  _ModuleListPageState createState() => _ModuleListPageState();
}

class _ModuleListPageState extends State<ModuleListPage> {
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

      // 查找指定模块的子项
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
    Navigator.pushNamed(
      context,
      '/workflow/list',
      arguments: {
        'dataId': item['id'],
        'workflowCode': item['img'],
        'name': item['text'],
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _moduleName,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                      SizedBox(height: 8),
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

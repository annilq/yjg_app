import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModuleSettingScreen extends ConsumerStatefulWidget {
  const ModuleSettingScreen({super.key});

  @override
  ConsumerState<ModuleSettingScreen> createState() => _ModuleSettingScreenState();
}

class _ModuleSettingScreenState extends ConsumerState<ModuleSettingScreen> {
  List<dynamic> _menus = [];
  List<dynamic> _selectedModules = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSelectedModules();
    _loadData();
  }

  Future<void> _loadSelectedModules() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? selectedModulesJson = prefs.getString('selectedModules');
      if (selectedModulesJson != null) {
        setState(() {
          _selectedModules = selectedModulesJson.split(',').map((id) => id).toList();
        });
      }
    } catch (e) {
      print('加载选中模块失败: $e');
    }
  }

  Future<void> _saveSelectedModules() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('selectedModules', _selectedModules.join(','));
    } catch (e) {
      print('保存选中模块失败: $e');
    }
  }

  Future<void> _loadData() async {
    try {
      var response = await ApiService().getMainWorkflows();
      setState(() {
        _menus = response['menus'] ?? [];
        _isLoading = false;
      });
    } catch (e) {
      print('加载数据失败: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggleModule(String moduleId) {
    setState(() {
      if (_selectedModules.contains(moduleId)) {
        _selectedModules.remove(moduleId);
      } else {
        _selectedModules.add(moduleId);
      }
      _saveSelectedModules();
    });
  }

  bool _isModuleSelected(String moduleId) {
    return _selectedModules.contains(moduleId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: '模块设置',
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _menus.length,
              itemBuilder: (context, index) {
                var menu = _menus[index];
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
                          value: _isModuleSelected(menu['id'] ?? ''),
                          onChanged: (value) {
                            _toggleModule(menu['id'] ?? '');
                          },
                          activeColor: AppTheme.primaryColor,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

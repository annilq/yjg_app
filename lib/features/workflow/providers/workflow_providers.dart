import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/features/workflow/service/workflow_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 依赖注入
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final workflowServiceProvider = Provider<WorkflowService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return WorkflowService(apiService);
});

// 状态providers
final menusProvider = FutureProvider<List<dynamic>>((ref) async {
  final service = ref.watch(workflowServiceProvider);
  return await service.getMenus();
});

final selectedModulesProvider = StateNotifierProvider<SelectedModulesNotifier, List<String>>(
  (ref) => SelectedModulesNotifier(),
);

class SelectedModulesNotifier extends StateNotifier<List<String>> {
  SelectedModulesNotifier() : super([]) {
    _loadSelectedModules();
  }

  Future<void> _loadSelectedModules() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final selectedModules = prefs.getString('selectedModules');
      if (selectedModules != null) {
        state = selectedModules.split(',').where((id) => id.isNotEmpty).toList();
      }
    } catch (e) {
      print('加载选中模块失败: $e');
    }
  }

  Future<void> toggleModule(String moduleId) async {
    final newState = state.contains(moduleId)
        ? state.where((id) => id != moduleId).toList()
        : [...state, moduleId];
    
    state = newState;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selectedModules', newState.join(','));
    } catch (e) {
      print('保存选中模块失败: $e');
    }
  }

  bool isModuleSelected(String moduleId) {
    return state.contains(moduleId);
  }
}

final userListProvider = StateNotifierProvider<UserListNotifier, List<String>>(
  (ref) => UserListNotifier(),
);

class UserListNotifier extends StateNotifier<List<String>> {
  UserListNotifier() : super([]) {
    _loadUserList();
  }

  Future<void> _loadUserList() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userList = prefs.getString('userList');
      if (userList != null) {
        state = userList.split(',').where((id) => id.isNotEmpty).toList();
      }
    } catch (e) {
      print('加载用户列表失败: $e');
    }
  }

  Future<void> toggleItem(String itemId) async {
    final newState = state.contains(itemId)
        ? state.where((id) => id != itemId).toList()
        : [...state, itemId];
    
    state = newState;
  }

  Future<void> saveUserList() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userList', state.join(','));
    } catch (e) {
      print('保存用户列表失败: $e');
    }
  }

  bool isItemInList(String itemId) {
    return state.contains(itemId);
  }
}

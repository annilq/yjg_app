import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/shared/services/api_service.dart';
import 'package:flutter_app/features/workflow/service/workflow_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 依赖注入
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final workflowServiceProvider = Provider<WorkflowService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return WorkflowService(apiService);
});

// 状态providers
final menusProvider = AsyncNotifierProvider<MenusNotifier, List<dynamic>>(
  MenusNotifier.new,
);

class MenusNotifier extends AsyncNotifier<List<dynamic>> {
  @override
  Future<List<dynamic>> build() async {
    final service = ref.read(workflowServiceProvider);
    return await service.getMenus();
  }
}

final selectedModulesProvider = AsyncNotifierProvider<SelectedModulesNotifier, List<String>>(
  SelectedModulesNotifier.new,
);

class SelectedModulesNotifier extends AsyncNotifier<List<String>> {
  @override
  Future<List<String>> build() async {
    return await _loadSelectedModules();
  }

  Future<List<String>> _loadSelectedModules() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final selectedModules = prefs.getString('selectedModules');
      if (selectedModules != null) {
        return selectedModules.split(',').where((id) => id.isNotEmpty).toList();
      }
    } catch (e) {
      print('加载选中模块失败: $e');
    }
    return [];
  }

  Future<void> toggleModule(String moduleId) async {
    final currentState = await future;
    final newState = currentState.contains(moduleId)
        ? currentState.where((id) => id != moduleId).toList()
        : [...currentState, moduleId];
    
    state = AsyncValue.data(newState);
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selectedModules', newState.join(','));
    } catch (e) {
      print('保存选中模块失败: $e');
    }
  }

  bool isModuleSelected(String moduleId) {
    final currentState = state.value ?? [];
    return currentState.contains(moduleId);
  }
}

final userListProvider = AsyncNotifierProvider<UserListNotifier, List<String>>(
  UserListNotifier.new,
);

class UserListNotifier extends AsyncNotifier<List<String>> {
  @override
  Future<List<String>> build() async {
    return await _loadUserList();
  }

  Future<List<String>> _loadUserList() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userList = prefs.getString('userList');
      if (userList != null) {
        return userList.split(',').where((id) => id.isNotEmpty).toList();
      }
    } catch (e) {
      print('加载用户列表失败: $e');
    }
    return [];
  }

  Future<void> toggleItem(String itemId) async {
    final currentState = await future;
    final newState = currentState.contains(itemId)
        ? currentState.where((id) => id != itemId).toList()
        : [...currentState, itemId];
    
    state = AsyncValue.data(newState);
  }

  Future<void> saveUserList() async {
    final currentState = await future;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userList', currentState.join(','));
    } catch (e) {
      print('保存用户列表失败: $e');
    }
  }

  bool isItemInList(String itemId) {
    final currentState = state.value ?? [];
    return currentState.contains(itemId);
  }
}


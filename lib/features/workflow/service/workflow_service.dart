import 'package:flutter_app/network/api_service.dart';

class WorkflowService {
  final ApiService _apiService;

  WorkflowService(this._apiService);

  Future<List<dynamic>> getMenus() async {
    final response = await _apiService.getMainWorkflows();
    return response['menus'] ?? [];
  }

  Future<Map<String, dynamic>> getDataList(
    String dataId,
    Map<String, dynamic> params,
    int page,
    int rows,
    int total,
  ) async {
    return await _apiService.getDataList(dataId, params, page, rows, total);
  }

  Future<Map<String, dynamic>> getConfig() async {
    return await _apiService.getMainDataListConfig();
  }

  Future<dynamic> getModuleMenus(String moduleName) async {
    final menus = await getMenus();
    for (var menu in menus) {
      if (menu['text'] == moduleName) {
        return menu;
      }
    }
    return {};
  }
}

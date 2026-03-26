import 'package:flutter_app/shared/services/api_service.dart';

class StartService {
  final ApiService _apiService = ApiService();

  /// 获取流程分类列表
  Future<List<dynamic>> getCategories() async {
    try {
      final data = await _apiService.getMainWorkflows();
      // API 返回 Map，取其中的 workflows 字段
      if (data.containsKey('workflows')) {
        return data['workflows'] as List;
      }
      return [];
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }
}

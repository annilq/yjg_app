import 'package:flutter_app/network/api_service.dart';

class OfficeService {
  final ApiService _apiService;

  OfficeService() : _apiService = ApiService();

  Future<Map<String, dynamic>> getBacklogList(int tabIndex, String? keyword, int page, int rows) async {
    return await _apiService.getBacklogList(tabIndex, keyword, page, rows);
  }

  Future<Map<String, dynamic>> getRelatedToMeList(int tabIndex, String? keyword, int page, int rows) async {
    return await _apiService.getRelatedToMeList(tabIndex, keyword, page, rows);
  }
}

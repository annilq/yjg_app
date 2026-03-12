import 'package:flutter_app/network/api_service.dart';

class NoticesService {
  final ApiService _apiService;

  NoticesService() : _apiService = ApiService();

  Future<Map<String, dynamic>> getNotices({String? keyword}) async {
    // 这里应该调用实际的通知列表接口
    // 暂时使用 getMainReminds 作为示例
    return await _apiService.getMainReminds();
  }
}

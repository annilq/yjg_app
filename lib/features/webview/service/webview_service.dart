import 'package:flutter_app/network/api_service.dart';

class WebviewService {
  final ApiService _apiService;

  WebviewService() : _apiService = ApiService();

  Future<Map<String, dynamic>> getWebviewConfig(String url) async {
    // 这里可以添加获取 webview 配置的逻辑
    return {};
  }

  Future<bool> shouldInterceptRequest(String url) async {
    // 这里可以添加拦截请求的逻辑
    return false;
  }
}

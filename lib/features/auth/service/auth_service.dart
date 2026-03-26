import 'package:flutter_app/shared/services/api_service.dart';

class AuthService {
  final ApiService _apiService;

  AuthService() : _apiService = ApiService();

  Future<Map<String, dynamic>> login(String accountName, String userName, String password) async {
    return await _apiService.login(accountName, userName, password);
  }

  Future<Map<String, dynamic>> resetPassword(Map<String, dynamic> params) async {
    return await _apiService.resetPassword(params);
  }

  Future<Map<String, dynamic>> updatePassword(Map<String, dynamic> params) async {
    return await _apiService.updatePassword(params);
  }
}

import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/features/auth/models/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountService {
  final ApiService _apiService = ApiService();

  Future<List<Account>> getAccounts() async {
    final prefs = await SharedPreferences.getInstance();
    final currentUserId = prefs.getInt('userId');
    final loginName = prefs.getString('userName');

    if (currentUserId != null && loginName != null) {
      return [
        Account(
          value: currentUserId,
          label: loginName,
          selected: true,
          disabled: true,
        ),
      ];
    }
    return [];
  }

  Future<Map<String, dynamic>> switchAccount(int userId) async {
    throw UnimplementedError('切换账号功能需要重新实现登录逻辑');
  }

  Future<Map<String, dynamic>> addAccount({
    required String tenantName,
    required String loginName,
    required String password,
  }) async {
    await _apiService.login(tenantName, loginName, password);
    return {'success': true};
  }

  Future<void> saveUserInfo(int userId, String userName, String accountName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
    await prefs.setString('userName', userName);
    await prefs.setString('accountName', accountName);
  }
}

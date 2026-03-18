import 'dart:convert';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/features/auth/models/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountService {
  final ApiService _apiService = ApiService();
  
  // 本地账号列表的 key
  static const String _accountsKey = 'local_accounts';
  // 当前选中的账号 key
  static const String _currentAccountKey = 'current_account';

  /// 获取所有本地缓存的账号列表
  Future<List<Account>> getAccounts() async {
    final prefs = await SharedPreferences.getInstance();
    final accountsJson = prefs.getString(_accountsKey);
    
    if (accountsJson == null || accountsJson.isEmpty) {
      return [];
    }
    
    final List<dynamic> accountsList = jsonDecode(accountsJson);
    final accounts = accountsList.map((e) => Account.fromJson(e as Map<String, dynamic>)).toList();
    
    // 检查当前选中的账号
    final currentAccountId = prefs.getInt(_currentAccountKey);
    if (currentAccountId != null) {
      return accounts.map((account) {
        return account.copyWith(selected: account.value == currentAccountId);
      }).toList();
    }
    
    return accounts;
  }

  /// 添加账号（登录成功后调用）
  Future<Account> addAccount({
    required String tenantName,
    required String loginName,
    required String password,
  }) async {
    // 调用 API 登录
    final response = await _apiService.login(tenantName, loginName, password);
    
    // 从响应中提取用户信息
    final userId = response['userId'] as int;
    final userName = response['userName'] as String? ?? loginName;
    
    // 创建账号对象
    final newAccount = Account(
      value: userId,
      label: userName,
      tenantName: tenantName,
      selected: true,
    );
    
    // 获取现有账号列表
    final prefs = await SharedPreferences.getInstance();
    final accountsJson = prefs.getString(_accountsKey);
    List<Account> accounts = [];
    
    if (accountsJson != null && accountsJson.isNotEmpty) {
      final List<dynamic> accountsList = jsonDecode(accountsJson);
      accounts = accountsList.map((e) => Account.fromJson(e as Map<String, dynamic>)).toList();
    }
    
    // 将新账号标记为选中，其他账号取消选中
    accounts = accounts.map((a) => a.copyWith(selected: false)).toList();
    accounts.add(newAccount);
    
    // 保存到本地
    final updatedAccountsJson = jsonEncode(accounts.map((a) => a.toJson()).toList());
    await prefs.setString(_accountsKey, updatedAccountsJson);
    await prefs.setInt(_currentAccountKey, userId);
    
    // 保存当前用户信息
    await saveUserInfo(userId, userName, tenantName);
    
    return newAccount;
  }

  /// 切换账号
  Future<void> switchAccount(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    
    // 获取现有账号列表
    final accountsJson = prefs.getString(_accountsKey);
    if (accountsJson == null || accountsJson.isEmpty) {
      throw Exception('没有本地账号数据');
    }
    
    final List<dynamic> accountsList = jsonDecode(accountsJson);
    final accounts = accountsList.map((e) => Account.fromJson(e as Map<String, dynamic>)).toList();
    
    // 查找要切换的账号
    final targetAccount = accounts.firstWhere(
      (a) => a.value == userId,
      orElse: () => throw Exception('账号不存在'),
    );
    
    if (targetAccount.disabled) {
      throw Exception('该账号已被禁用');
    }
    
    // 更新选中状态
    final updatedAccounts = accounts.map((a) {
      return a.copyWith(selected: a.value == userId);
    }).toList();
    
    // 保存更新后的列表
    final updatedAccountsJson = jsonEncode(updatedAccounts.map((a) => a.toJson()).toList());
    await prefs.setString(_accountsKey, updatedAccountsJson);
    await prefs.setInt(_currentAccountKey, userId);
    
    // 保存用户信息
    await saveUserInfo(userId, targetAccount.label, targetAccount.tenantName ?? '');
  }

  /// 删除账号
  Future<void> deleteAccount(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    
    final accountsJson = prefs.getString(_accountsKey);
    if (accountsJson == null || accountsJson.isEmpty) {
      return;
    }
    
    final List<dynamic> accountsList = jsonDecode(accountsJson);
    final accounts = accountsList.map((e) => Account.fromJson(e as Map<String, dynamic>)).toList();
    
    // 移除目标账号
    final updatedAccounts = accounts.where((a) => a.value != userId).toList();
    
    // 如果删除的是当前选中的账号，选中第一个账号
    final currentAccountId = prefs.getInt(_currentAccountKey);
    if (currentAccountId == userId && updatedAccounts.isNotEmpty) {
      await prefs.setInt(_currentAccountKey, updatedAccounts.first.value);
    } else if (updatedAccounts.isEmpty) {
      await prefs.remove(_currentAccountKey);
    }
    
    // 保存更新后的列表
    final updatedAccountsJson = jsonEncode(updatedAccounts.map((a) => a.toJson()).toList());
    await prefs.setString(_accountsKey, updatedAccountsJson);
  }

  /// 保存用户信息到 SharedPreferences
  Future<void> saveUserInfo(int userId, String userName, String accountName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
    await prefs.setString('userName', userName);
    await prefs.setString('accountName', accountName);
  }

  /// 获取当前选中的账号
  Future<Account?> getCurrentAccount() async {
    final accounts = await getAccounts();
    try {
      return accounts.firstWhere((a) => a.selected);
    } catch (_) {
      return null;
    }
  }
}

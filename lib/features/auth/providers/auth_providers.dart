import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/features/auth/service/auth_service.dart';
import 'package:flutter_app/features/auth/models/auth_model.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authProvider = AsyncNotifierProvider<AuthNotifier, LoginResponse?>(
  AuthNotifier.new,
);

class AuthNotifier extends AsyncNotifier<LoginResponse?> {
  late final AuthService _authService;

  @override
  Future<LoginResponse?> build() async {
    _authService = ref.read(authServiceProvider);
    // 这里可以添加从本地存储加载token的逻辑
    return null;
  }

  Future<LoginResponse> login(String accountName, String userName, String password) async {
    final response = await _authService.login(accountName, userName, password);
    final loginResponse = LoginResponse.fromJson(response);
    state = AsyncValue.data(loginResponse);
    // 这里可以添加保存token到本地存储的逻辑
    return loginResponse;
  }

  Future<void> resetPassword(Map<String, dynamic> params) async {
    await _authService.resetPassword(params);
  }

  Future<void> updatePassword(Map<String, dynamic> params) async {
    await _authService.updatePassword(params);
  }

  Future<void> logout() async {
    state = AsyncValue.data(null);
    // 这里可以添加清除本地存储token的逻辑
  }
}

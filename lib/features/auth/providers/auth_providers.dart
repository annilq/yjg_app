import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/features/auth/service/auth_service.dart';
import 'package:flutter_app/features/auth/service/account_service.dart';
import 'package:flutter_app/features/auth/models/auth_model.dart';
import 'package:flutter_app/features/auth/models/account_model.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final accountServiceProvider = Provider<AccountService>((ref) {
  return AccountService();
});

final authProvider = AsyncNotifierProvider<AuthNotifier, LoginResponse?>(
  AuthNotifier.new,
);

final accountsProvider = FutureProvider<List<Account>>((ref) async {
  final accountService = ref.read(accountServiceProvider);
  return await accountService.getAccounts();
});

class AuthNotifier extends AsyncNotifier<LoginResponse?> {
  late final AuthService _authService;

  @override
  Future<LoginResponse?> build() async {
    _authService = ref.read(authServiceProvider);
    return null;
  }

  Future<Map<String, dynamic>> login(String accountName, String userName, String password) async {
    final response = await _authService.getUserToken(accountName, userName, password);
    state = AsyncValue.data(null);
    return response;
  }

  Future<void> resetPassword(Map<String, dynamic> params) async {
    await _authService.resetPassword(params);
  }

  Future<void> updatePassword(Map<String, dynamic> params) async {
    await _authService.updatePassword(params);
  }

  Future<void> logout() async {
    state = AsyncValue.data(null);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';
import 'package:flutter_app/features/auth/providers/auth_providers.dart';
import 'package:flutter_app/shared/models/login_response_model.dart';
import 'package:flutter_app/shared/widgets/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _accountCtrl = TextEditingController();
  final _userCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _accountCtrl.text = '内部演示';
    _userCtrl.text = '张小六';
    _pwdCtrl.text = '111111';
  }

  @override
  void dispose() {
    _accountCtrl.dispose();
    _userCtrl.dispose();
    _pwdCtrl.dispose();
    super.dispose();
  }

  OutlineInputBorder _border(BuildContext context, {bool focused = false}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: focused
            ? Theme.of(context).colorScheme.primary
            : (isDark ? DarkColors.border : LightColors.border),
        width: focused ? 1.5 : 1,
      ),
    );
  }

  InputDecoration _inputDeco(BuildContext context, {
    required String label,
    required String hint,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: _border(context),
      enabledBorder: _border(context),
      focusedBorder: _border(context, focused: true),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final response = await ref.read(authProvider.notifier).login(
        _accountCtrl.text,
        _userCtrl.text,
        _pwdCtrl.text,
      );
      final model = LoginResponseModel.fromJson(response);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', model.userId!);
      await prefs.setString('userName', model.userName!);
      await prefs.setString('accountName', model.accountName!);
      await prefs.setString('lastUpdateTime', model.lastUpdateTime!);
      if (mounted) context.pushReplacement('/main');
    } catch (e) {
      if (mounted) SnackBarHelper.showSnackBar(context, '登录失败: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).colorScheme.primary;
    final bgColor = isDark ? DarkColors.background : LightColors.background;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 彩带背景区域
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [
                            primary.withAlpha(30),
                            primary.withAlpha(15),
                            bgColor,
                          ]
                        : [
                            primary.withAlpha(8),
                            primary.withAlpha(5),
                            bgColor,
                          ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      // 品牌区域
                      Column(
                        children: [
                          // Logo - 简洁的圆形
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: primary.withAlpha(20),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '云',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: primary,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // 应用名称
                          Text(
                            '云建管',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? DarkColors.textPrimary
                                  : LightColors.textPrimary,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // 副标题
                          Text(
                            '企业管理平台',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: isDark
                                  ? DarkColors.textSecondary
                                  : LightColors.textSecondary,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              // 表单区域
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    // 表单
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // 账号输入框
                          TextFormFieldComponent(
                            controller: _accountCtrl,
                            decoration: _inputDeco(context,
                                label: '账号', hint: '请输入账号'),
                            validator: (v) =>
                                (v == null || v.isEmpty) ? '请输入账号' : null,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 16),
                          // 用户名输入框
                          TextFormFieldComponent(
                            controller: _userCtrl,
                            decoration: _inputDeco(context,
                                label: '用户名', hint: '请输入用户名'),
                            validator: (v) =>
                                (v == null || v.isEmpty) ? '请输入用户名' : null,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 16),
                          // 密码输入框
                          TextFormFieldComponent(
                            controller: _pwdCtrl,
                            decoration: _inputDeco(context,
                                label: '密码', hint: '请输入密码'),
                            obscureText: true,
                            validator: (v) =>
                                (v == null || v.isEmpty) ? '请输入密码' : null,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _login(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    // 按钮区域
                    Column(
                      children: [
                        // 登录按钮 - 主色，全宽
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              disabledBackgroundColor: primary.withAlpha(128),
                            ),
                            child: Text(
                              _isLoading ? '登录中...' : '登录',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // 忘记密码 - 文字链接
                        GestureDetector(
                          onTap: () => context.push('/reset-password'),
                          child: Text(
                            '忘记密码？',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: primary,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

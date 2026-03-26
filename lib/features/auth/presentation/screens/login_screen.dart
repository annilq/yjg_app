import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
  final _accountNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _accountNameController.text = '内部演示';
    _userNameController.text = '张小六';
    _passwordController.text = '111111';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: '登录',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormFieldComponent(
                controller: _accountNameController,
                decoration: InputDecoration(
                  labelText: '账号',
                  hintText: '请输入账号',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入账号';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormFieldComponent(
                controller: _userNameController,
                decoration: InputDecoration(
                  labelText: '用户名',
                  hintText: '请输入用户名',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入用户名';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormFieldComponent(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: '密码',
                  hintText: '请输入密码',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入密码';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.0),
              Center(
                child: _isLoading
                    ? CircularProgressIndicator()
                    : ButtonComponent(
                        onPressed: _login,
                        text: '登录',
                      ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: TextButtonComponent(
                  onPressed: () {
                    context.push('/reset-password');
                  },
                  text: '忘记密码',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        var response = await ref.read(authProvider.notifier).login(
          _accountNameController.text,
          _userNameController.text,
          _passwordController.text,
        );

        LoginResponseModel model = LoginResponseModel.fromJson(response);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('userId', model.userId!);
        await prefs.setString('userName', model.userName!);
        await prefs.setString('accountName', model.accountName!);
        await prefs.setString('lastUpdateTime', model.lastUpdateTime!);

        if (mounted) {
          context.pushReplacement('/main');
        }
      } catch (e) {
        if (mounted) {
          SnackBarHelper.showSnackBar(
            context,
            '登录失败: $e',
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/models/login_response_model.dart';
import 'package:flutter_app/components/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _accountNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '登录',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormFieldCustom(
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
              TextFormFieldCustom(
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
              TextFormFieldCustom(
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
                    : Button(
                        onPressed: _login,
                        text: '登录',
                      ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: TextButtonCustom(
                  onPressed: () {
                    Navigator.pushNamed(context, '/reset-password');
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
        var response = await ApiService().getUserToken(
          _accountNameController.text,
          _userNameController.text,
          _passwordController.text,
        );

        LoginResponseModel model = LoginResponseModel.fromJson(response);

        // 保存登录信息
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('userId', model.userId!);
        await prefs.setString('userName', model.userName!);
        await prefs.setString('accountName', model.accountName!);
        await prefs.setString('lastUpdateTime', model.lastUpdateTime!);
        // await prefs.setString('token', model.token!);

        // 登录成功，跳转到主界面
        Navigator.pushReplacementNamed(context, '/main');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('登录失败: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/components/index.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _isSendingCode = false;
  int _countdown = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('忘记密码'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormFieldCustom(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: '手机号',
                  hintText: '请输入手机号',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入手机号';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormFieldCustom(
                      controller: _codeController,
                      decoration: InputDecoration(
                        labelText: '验证码',
                        hintText: '请输入验证码',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '请输入验证码';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Button(
                    onPressed: _countdown > 0 ? () {} : _sendCode,
                    text: _countdown > 0 ? '$_countdown秒后重发' : '发送验证码',
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              TextFormFieldCustom(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: '新密码',
                  hintText: '请输入新密码',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入新密码';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormFieldCustom(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: '确认密码',
                  hintText: '请再次输入新密码',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请确认密码';
                  }
                  if (value != _passwordController.text) {
                    return '两次输入的密码不一致';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.0),
              Center(
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Button(
                        onPressed: _resetPassword,
                        text: '确认重置',
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendCode() async {
    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('请输入手机号')),
      );
      return;
    }

    setState(() {
      _isSendingCode = true;
    });

    try {
      await ApiService().sendCode({
        'phone': _phoneController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('验证码发送成功')),
      );

      // 开始倒计时
      setState(() {
        _countdown = 60;
      });

      // 倒计时逻辑
      for (int i = 60; i > 0; i--) {
        await Future.delayed(Duration(seconds: 1));
        setState(() {
          _countdown--;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('发送验证码失败: $e')),
      );
    } finally {
      setState(() {
        _isSendingCode = false;
      });
    }
  }

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await ApiService().resetPassword({
          'phone': _phoneController.text,
          'code': _codeController.text,
          'password': _passwordController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('密码重置成功')),
        );

        // 重置成功，返回登录页面
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('密码重置失败: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

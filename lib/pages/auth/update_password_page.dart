import 'package:flutter/material.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/components/index.dart';

class UpdatePasswordPage extends StatefulWidget {
  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '修改密码',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormFieldCustom(
                controller: _oldPasswordController,
                decoration: InputDecoration(
                  labelText: '原密码',
                  hintText: '请输入原密码',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入原密码';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormFieldCustom(
                controller: _newPasswordController,
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
                  if (value != _newPasswordController.text) {
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
                        onPressed: _updatePassword,
                        text: '确认修改',
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updatePassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await ApiService().updatePassword({
          'oldPassword': _oldPasswordController.text,
          'newPassword': _newPasswordController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('密码修改成功')),
        );

        // 修改成功，返回上一页
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('密码修改失败: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
